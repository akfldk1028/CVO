#!/bin/bash
# CVO Install Script
# 프로젝트에 CVO submodule 추가 후 실행하세요.
#
# Usage:
#   git submodule add https://github.com/akfldk1028/CVO.git .cvo
#   bash .cvo/install.sh
#
# 이 스크립트가 하는 일:
#   1. .claude/skills/ 에 CVO 스킬 심링크 생성
#   2. 프로젝트 CLAUDE.md에 CVO 설정 추가 (기존 내용 유지)
#   3. progress/ 디렉토리 생성

set -e

# CVO 루트 경로 (이 스크립트 기준)
CVO_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$CVO_DIR/.." && pwd)"

echo "🎙️ CVO - Claude Voice English Speaking Practice"
echo "   Installing to: $PROJECT_DIR"
echo ""

# 1. Skills 심링크 생성
echo "📦 Setting up skills..."
mkdir -p "$PROJECT_DIR/.claude/skills"

SKILLS=(warmup shadow interview debate review level correct)
for skill in "${SKILLS[@]}"; do
    TARGET="$PROJECT_DIR/.claude/skills/$skill"
    if [ -L "$TARGET" ] || [ -d "$TARGET" ]; then
        echo "   ⏭️  $skill (already exists)"
    else
        # 상대 경로로 심링크 (git 호환성)
        ln -s "../../.cvo/.claude/skills/$skill" "$TARGET"
        echo "   ✅ $skill"
    fi
done

# 2. CLAUDE.md에 CVO 섹션 추가
echo ""
echo "📝 Updating CLAUDE.md..."
CLAUDE_FILE="$PROJECT_DIR/CLAUDE.md"

CVO_MARKER="<!-- CVO:START -->"
if [ -f "$CLAUDE_FILE" ] && grep -q "$CVO_MARKER" "$CLAUDE_FILE"; then
    echo "   ⏭️  CVO section already exists in CLAUDE.md"
else
    cat >> "$CLAUDE_FILE" << 'CLAUDE_EOF'

<!-- CVO:START -->
## 🎙️ English Speaking Practice (CVO)

이 프로젝트에는 영어 스피킹 연습 환경(CVO)이 설치되어 있습니다.

### 활성화 조건
- 유저가 `/warmup`, `/shadow`, `/interview`, `/debate`, `/review`, `/level` 을 호출하면 Coach 모드로 전환
- 유저가 영어 또는 한영 혼합으로 말하면 `correct` 스킬이 자동 교정

### Coach 모드 규칙
- Coach 대화: **쉬운 영어** (초급 맞춤)
- 교정/설명: **한국어**
- 매 문장 즉시 교정: `✓ "교정된 문장" → 틀린부분 → 교정 (한국어 설명)`
- 한국어 혼합 OK → 전체를 영어로 재구성

### 참조 파일 (CVO submodule)
- `.cvo/prompts/` — 튜터 페르소나, 교정 규칙, 연구 기반 방법론
- `.cvo/bank/` — 면접 질문, 표현, 주제 뱅크
- `.cvo/progress/` — 세션 기록, 배운 표현 누적
<!-- CVO:END -->
CLAUDE_EOF
    echo "   ✅ CVO section added to CLAUDE.md"
fi

# 3. Progress 디렉토리 확인
echo ""
echo "📊 Setting up progress tracking..."
mkdir -p "$CVO_DIR/progress"
if [ ! -f "$CVO_DIR/progress/sessions.jsonl" ]; then
    touch "$CVO_DIR/progress/sessions.jsonl"
    echo "   ✅ sessions.jsonl created"
fi
if [ ! -f "$CVO_DIR/progress/vocab_log.md" ]; then
    cat > "$CVO_DIR/progress/vocab_log.md" << 'VOCAB_EOF'
# Vocabulary Log (배운 표현 누적)

> 새로 배운 표현이 여기에 자동으로 추가됩니다.

| 날짜 | 표현 (영어) | 뜻 (한국어) | 모드 |
|------|------------|------------|------|
VOCAB_EOF
    echo "   ✅ vocab_log.md created"
fi

# 4. .gitignore에 progress 제외 추가
echo ""
echo "🔒 Updating .gitignore..."
if [ -f "$PROJECT_DIR/.gitignore" ]; then
    if ! grep -q ".cvo/progress/" "$PROJECT_DIR/.gitignore"; then
        echo "" >> "$PROJECT_DIR/.gitignore"
        echo "# CVO progress (personal session data)" >> "$PROJECT_DIR/.gitignore"
        echo ".cvo/progress/sessions.jsonl" >> "$PROJECT_DIR/.gitignore"
        echo "   ✅ Added .cvo/progress to .gitignore"
    else
        echo "   ⏭️  Already in .gitignore"
    fi
fi

# 5. TTS Plugin 설치 (claude-code-tts)
echo ""
echo "🔊 Setting up TTS plugin..."

TTS_SRC="$CVO_DIR/plugins/claude-code-tts"
TTS_DEST="$HOME/.claude/plugins/claude-code-tts"

if [ -d "$TTS_SRC" ]; then
    # Copy source to ~/.claude/plugins/
    mkdir -p "$HOME/.claude/plugins"
    if [ -d "$TTS_DEST" ]; then
        echo "   ⏭️  TTS plugin already exists at $TTS_DEST"
    else
        cp -r "$TTS_SRC" "$TTS_DEST"
        echo "   ✅ TTS source copied to $TTS_DEST"
    fi

    # Build binaries (requires Go 1.23+)
    if command -v go &>/dev/null; then
        echo "   🔨 Building TTS binaries..."
        mkdir -p "$TTS_DEST/bin"
        (cd "$TTS_DEST" && go build -ldflags="-s -w" -o bin/tts-server.exe ./cmd/tts-server 2>/dev/null && \
         go build -ldflags="-s -w" -o bin/speak-text.exe ./cmd/speak-text 2>/dev/null)
        if [ $? -eq 0 ]; then
            echo "   ✅ TTS binaries built"
        else
            # Try with explicit Go path (Windows)
            export PATH="/c/Program Files/Go/bin:$PATH"
            (cd "$TTS_DEST" && go build -ldflags="-s -w" -o bin/tts-server.exe ./cmd/tts-server && \
             go build -ldflags="-s -w" -o bin/speak-text.exe ./cmd/speak-text)
            [ $? -eq 0 ] && echo "   ✅ TTS binaries built" || echo "   ⚠️  Build failed. Install Go 1.23+ and rebuild manually."
        fi
    else
        echo "   ⚠️  Go not found. Install Go 1.23+ then run:"
        echo "      cd $TTS_DEST && go build -ldflags=\"-s -w\" -o bin/tts-server.exe ./cmd/tts-server"
        echo "      cd $TTS_DEST && go build -ldflags=\"-s -w\" -o bin/speak-text.exe ./cmd/speak-text"
    fi

    # Register MCP server (user scope)
    if command -v claude &>/dev/null; then
        claude mcp add --scope user tts -- "$TTS_DEST/bin/tts-server.exe" 2>/dev/null
        echo "   ✅ TTS MCP server registered (user scope)"
    else
        echo "   ⚠️  claude CLI not found. Register manually:"
        echo "      claude mcp add --scope user tts -- $TTS_DEST/bin/tts-server.exe"
    fi

    # Setup Stop Hook for auto-speak
    SETTINGS_FILE="$HOME/.claude/settings.json"
    if [ -f "$SETTINGS_FILE" ] && grep -q "auto-speak" "$SETTINGS_FILE"; then
        echo "   ⏭️  Stop Hook already configured"
    else
        echo "   ⚠️  Add Stop Hook manually to $SETTINGS_FILE:"
        echo '      "hooks": { "Stop": [{ "hooks": [{ "type": "command", "command": "bash \"$HOME/.claude/plugins/claude-code-tts/hooks/auto-speak.sh\"", "timeout": 30 }] }] }'
    fi

    # Check OPENAI_API_KEY
    if [ -z "$OPENAI_API_KEY" ]; then
        echo ""
        echo "   ⚠️  OPENAI_API_KEY not set. TTS requires it."
        echo "      export OPENAI_API_KEY=\"sk-...\""
        echo "      Also add to ~/.claude.json mcpServers.tts.env"
    else
        echo "   ✅ OPENAI_API_KEY detected"
    fi
else
    echo "   ⏭️  TTS plugin source not found, skipping"
fi

echo ""
echo "✅ CVO installation complete!"
echo ""
echo "📌 Quick start:"
echo "   /level     → 레벨 체크"
echo "   /warmup    → 워밍업 대화"
echo "   /interview → 모의 면접"
echo "   /voice     → 음성 모드 (스페이스바 홀드)"
echo ""
