# CVO - Claude Voice English Speaking Practice

An English speaking practice environment powered by Claude Code's `/voice` feature.
Designed for digital twin software developers preparing for English technical interviews.

## Quick Start

```bash
# 1. Clone this repo
git clone https://github.com/akfldk1028/CVO.git
cd CVO

# 2. Launch Claude Code
claude

# 3. Start with a level check
/level

# 4. Practice with voice mode
/warmup
/voice  # Hold spacebar to speak in English
```

## Skills (Slash Commands)

| Skill | Description | Usage |
|-------|-------------|-------|
| `/warmup` | 3-minute warm-up casual conversation | `/warmup` or `/warmup 3` (topic number) |
| `/shadow` | Sentence shadowing (repeat after me) | `/shadow` |
| `/interview` | Digital twin mock interview | `/interview` or `/interview 3` (category) |
| `/debate` | Technical topic debate | `/debate` or `/debate 1` (topic number) |
| `/review` | Session feedback review | `/review` |
| `/level` | Level check & adjustment | `/level` |

**Auto skill**: `correct` — Automatically corrects English or mixed Korean-English input

## Key Features

### Instant Sentence Correction
Every sentence you say is corrected immediately:
```
You: "I working in digital twin project last year"

Coach:
  "I worked on a digital twin project last year."
  working -> worked (past tense), in -> on (use "on" for projects)
```

### Code-Switching Friendly
Mix Korean and English freely — Coach reconstructs the full English sentence:
```
You: "I deploy yesterday but there was bug so I rollback"

Coach:
  "I deployed yesterday, but there was a bug, so I rolled back."
```

### Research-Backed Methods
- **Explicit correction** over simple recasts (Frontiers in Psychology, 2023)
- **i+1 difficulty** auto-adjustment (NAACL 2025, Grammar Control)
- **Spaced repetition** of previously learned expressions (Kim 2022 meta-analysis)
- **Anxiety reduction** framing (ELLMA-T, 2024)

## Project Structure

```
CVO/
├── CLAUDE.md                          # Project instructions (Coach role definition)
├── .claude/skills/                    # Claude Code Skills
│   ├── correct/SKILL.md               # Auto correction (auto-invocation)
│   ├── warmup/SKILL.md                # Warm-up conversation
│   ├── shadow/SKILL.md                # Shadowing
│   ├── interview/SKILL.md             # Mock interview
│   ├── debate/SKILL.md                # Debate
│   ├── review/SKILL.md                # Review
│   └── level/SKILL.md                 # Level check
├── prompts/
│   ├── tutor_persona.md               # Tutor persona
│   ├── correction_rules.md            # Correction rules
│   └── research_methods.md            # Research-based methodology
├── bank/
│   ├── interview/                     # Interview question bank
│   │   ├── self_intro.md              # Self introduction
│   │   ├── behavioral.md              # Behavioral (STAR method)
│   │   ├── technical_dt.md            # Technical (Digital Twin)
│   │   └── situational.md             # Situational
│   ├── daily_topics.md                # 25 daily conversation topics
│   └── expressions/
│       ├── interview_must.md          # 30+ must-know interview expressions
│       └── tech_terms_dt.md           # 50+ digital twin technical terms
├── progress/
│   ├── sessions.jsonl                 # Session logs
│   └── vocab_log.md                   # Cumulative vocabulary log
└── scripts/
    └── log_session.py                 # Session logging utility
```

## Use as a Submodule in Another Project

Add CVO as a `.cvo/` submodule to any project for instant English practice:

```bash
# 1. Add submodule
git submodule add https://github.com/akfldk1028/CVO.git .cvo

# 2. Run install script (creates skill symlinks + updates CLAUDE.md)
bash .cvo/install.sh

# 3. Launch Claude Code and start practicing
claude
/warmup
```

What `install.sh` does:
- Creates symlinks to CVO skills in `.claude/skills/`
- Appends Coach mode configuration to your project's `CLAUDE.md`
- Initializes `progress/` directory and log files

## Session Logging Utility

```bash
# Log a session
python scripts/log_session.py log --mode warmup --sentences 8 --corrections 3 --summary "tense errors"

# Add a new expression
python scripts/log_session.py vocab --expression "work on" --meaning "to participate in" --mode warmup

# View statistics
python scripts/log_session.py stats
```

## Who Is This For?
- Beginner-level Korean developers learning English
- Especially in Digital Twin / IoT / 3D / Game Engine fields
- Anyone preparing for English technical interviews

## Requirements
- [Claude Code](https://claude.com/claude-code) CLI
- Python 3.8+ (for session logging)
