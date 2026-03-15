package main

import (
	"flag"
	"fmt"
	"os"

	"github.com/ybouhjira/claude-code-tts/internal/audio"
	"github.com/ybouhjira/claude-code-tts/internal/tts"
)

func main() {
	// Parse flags
	voice := flag.String("voice", "coral", "Voice to use (alloy, echo, fable, onyx, nova, shimmer, coral)")
	instructions := flag.String("instructions", "", "Instructions for speech style/tone (gpt-4o-mini-tts only)")
	flag.Usage = func() {
		fmt.Fprintf(os.Stderr, "Usage: %s [OPTIONS] TEXT\n\n", os.Args[0])
		fmt.Fprintf(os.Stderr, "Converts text to speech using OpenAI TTS API and plays it.\n\n")
		fmt.Fprintf(os.Stderr, "Options:\n")
		flag.PrintDefaults()
		fmt.Fprintf(os.Stderr, "\nExample:\n")
		fmt.Fprintf(os.Stderr, "  %s \"Build completed\"\n", os.Args[0])
		fmt.Fprintf(os.Stderr, "  %s -voice coral -instructions \"Speak cheerfully\" \"Hello!\"\n", os.Args[0])
	}
	flag.Parse()

	// Check for text argument
	if flag.NArg() == 0 {
		flag.Usage()
		os.Exit(1)
	}

	text := flag.Arg(0)

	// Validate environment
	if os.Getenv("OPENAI_API_KEY") == "" {
		fmt.Fprintf(os.Stderr, "Error: OPENAI_API_KEY environment variable is required\n")
		os.Exit(1)
	}

	// Validate voice
	if !tts.IsValidVoice(*voice) {
		fmt.Fprintf(os.Stderr, "Error: invalid voice '%s'. Valid voices: ", *voice)
		for i, v := range tts.ValidVoices() {
			if i > 0 {
				fmt.Fprintf(os.Stderr, ", ")
			}
			fmt.Fprintf(os.Stderr, "%s", v)
		}
		fmt.Fprintf(os.Stderr, "\n")
		os.Exit(1)
	}

	// Create TTS client
	client := tts.NewClient()

	// Synthesize speech
	audioData, err := client.Synthesize(text, tts.Voice(*voice), *instructions)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error synthesizing speech: %v\n", err)
		os.Exit(1)
	}

	// Play audio
	player := audio.NewPlayer()
	if err := player.Play(audioData); err != nil {
		fmt.Fprintf(os.Stderr, "Error playing audio: %v\n", err)
		os.Exit(1)
	}
}
