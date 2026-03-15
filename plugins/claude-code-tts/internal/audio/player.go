package audio

import (
	"fmt"
	"os"
	"os/exec"
	"runtime"
	"sync"
)

// Player handles audio playback with mutex protection
type Player struct {
	mu        sync.Mutex
	isPlaying bool
}

// NewPlayer creates a new audio player
func NewPlayer() *Player {
	return &Player{}
}

// Play plays the given audio data
// Only one audio can play at a time (mutex protected)
func (p *Player) Play(audioData []byte) error {
	p.mu.Lock()
	defer p.mu.Unlock()

	p.isPlaying = true
	defer func() { p.isPlaying = false }()

	// Create temporary file
	tmpFile, err := os.CreateTemp("", "tts-*.mp3")
	if err != nil {
		return fmt.Errorf("failed to create temp file: %w", err)
	}
	defer os.Remove(tmpFile.Name())

	if _, err := tmpFile.Write(audioData); err != nil {
		tmpFile.Close()
		return fmt.Errorf("failed to write audio data: %w", err)
	}
	tmpFile.Close()

	// Play audio based on platform
	var cmd *exec.Cmd
	switch runtime.GOOS {
	case "darwin":
		cmd = exec.Command("afplay", tmpFile.Name())
	case "linux":
		// Try common Linux audio players
		if _, err := exec.LookPath("mpv"); err == nil {
			cmd = exec.Command("mpv", "--no-video", tmpFile.Name())
		} else if _, err := exec.LookPath("ffplay"); err == nil {
			cmd = exec.Command("ffplay", "-nodisp", "-autoexit", tmpFile.Name())
		} else if _, err := exec.LookPath("aplay"); err == nil {
			// aplay requires WAV, so use mpg123 for MP3
			if _, err := exec.LookPath("mpg123"); err == nil {
				cmd = exec.Command("mpg123", "-q", tmpFile.Name())
			} else {
				return fmt.Errorf("no suitable audio player found on Linux (install mpv, ffplay, or mpg123)")
			}
		} else {
			return fmt.Errorf("no suitable audio player found on Linux (install mpv, ffplay, or mpg123)")
		}
	case "windows":
		// Use Windows Media Player COM object via PowerShell for MP3 support
		psScript := fmt.Sprintf(`
Add-Type -AssemblyName presentationCore
$player = New-Object System.Windows.Media.MediaPlayer
$player.Open([Uri]::new('%s'))
$player.Play()
Start-Sleep -Milliseconds 500
while ($player.Position -lt $player.NaturalDuration.TimeSpan) { Start-Sleep -Milliseconds 100 }
Start-Sleep -Milliseconds 200
$player.Close()
`, tmpFile.Name())
		cmd = exec.Command("powershell", "-NoProfile", "-c", psScript)
	default:
		return fmt.Errorf("unsupported platform: %s", runtime.GOOS)
	}

	if err := cmd.Run(); err != nil {
		return fmt.Errorf("audio playback failed: %w", err)
	}

	return nil
}

// IsPlaying returns whether audio is currently playing
func (p *Player) IsPlaying() bool {
	p.mu.Lock()
	defer p.mu.Unlock()
	return p.isPlaying
}
