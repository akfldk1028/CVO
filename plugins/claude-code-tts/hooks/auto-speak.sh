#!/bin/bash

# Auto-speak hook for Claude Code
# Speaks Claude's response using gpt-4o-mini-tts with coral voice

PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-$HOME/.claude/plugins/claude-code-tts}"
SPEAK_BIN="$PLUGIN_ROOT/bin/speak-text"
LOG_FILE="$PLUGIN_ROOT/hooks/auto-speak.log"

# Read stdin BEFORE backgrounding
json=$(cat)

# Load OPENAI_API_KEY from ~/.claude.json if not set
if [ -z "$OPENAI_API_KEY" ]; then
    OPENAI_API_KEY=$(jq -r '.mcpServers.tts.env.OPENAI_API_KEY // ""' "$HOME/.claude.json" 2>/dev/null)
    export OPENAI_API_KEY
fi

{
    echo "[$(date)] Hook triggered" >> "$LOG_FILE"

    active=$(echo "$json" | jq -r '.stop_hook_active // false' 2>/dev/null)
    if [ "$active" = "true" ]; then
        echo "[$(date)] stop_hook_active=true, skipping" >> "$LOG_FILE"
        exit 0
    fi

    msg=$(echo "$json" | jq -r '.last_assistant_message // ""' 2>/dev/null)
    echo "[$(date)] msg length: ${#msg}" >> "$LOG_FILE"

    if [ -z "$msg" ] || [ ${#msg} -lt 10 ]; then
        echo "[$(date)] msg too short, skipping" >> "$LOG_FILE"
        exit 0
    fi

    # Clean up markdown for natural speech
    clean=$(echo "$msg" | \
        sed 's/\*\*//g' | \
        sed 's/✓/corrected: /g' | \
        sed 's/→/. /g' | \
        sed 's/💡/tip: /g' | \
        sed 's/📌//g' | \
        sed 's/^- //g' | \
        sed 's/^#\+ //g' | \
        sed '/^```/d' | \
        sed '/^|/d' | \
        sed '/^$/d' | \
        head -c 1500)

    echo "[$(date)] speaking: $clean" >> "$LOG_FILE"

    if [ -x "$SPEAK_BIN" ] || [ -x "${SPEAK_BIN}.exe" ]; then
        timeout 30 "$SPEAK_BIN" \
            -voice coral \
            -instructions "You are a friendly, cute, and cheerful English speaking coach. Speak naturally in both English and Korean. For English parts, use a warm and encouraging tone. For Korean parts, speak naturally like a kind friend. Keep the energy positive and supportive." \
            "$clean" >> "$LOG_FILE" 2>&1
        echo "[$(date)] speak exit code: $?" >> "$LOG_FILE"
    else
        echo "[$(date)] speak-text not found" >> "$LOG_FILE"
    fi
} &

exit 0
