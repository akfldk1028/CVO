# CVO - Claude Voice English Speaking Practice

Claude Code의 `/voice` 기능을 활용한 영어 스피킹 연습 환경.
디지털트윈 개발자의 영어 기술 면접 준비에 특화되어 있습니다.

## Quick Start

```bash
# 1. 이 레포를 클론
git clone https://github.com/akfldk1028/CVO.git
cd CVO

# 2. Claude Code 실행
claude

# 3. 레벨 체크부터 시작
/level

# 4. 음성 모드로 연습
/warmup
/voice  # 스페이스바 홀드 → 영어로 말하기
```

## Skills (슬래시 커맨드)

| 스킬 | 설명 | 사용법 |
|------|------|--------|
| `/warmup` | 3분 워밍업 일상 대화 | `/warmup` 또는 `/warmup 3` |
| `/shadow` | 문장 따라말하기 (섀도잉) | `/shadow` |
| `/interview` | 디지털트윈 모의 면접 | `/interview` 또는 `/interview 3` |
| `/debate` | 기술 주제 토론 | `/debate` 또는 `/debate 1` |
| `/review` | 세션 피드백 리뷰 | `/review` |
| `/level` | 레벨 체크 & 조정 | `/level` |

**자동 스킬**: `correct` — 영어/한영혼합 입력 시 자동으로 교정 발동

## 핵심 기능

### 매 문장 즉시 교정
```
You: "I working in digital twin project last year"

Coach:
  ✓ "I worked on a digital twin project last year."
  → working → worked (과거형), in → on (프로젝트에는 on)
```

### 한국어 혼합 OK
```
You: "I 어제 deploy 했는데 bug가 있어서 rollback 했어"

Coach:
  ✓ "I deployed yesterday, but there was a bug, so I rolled back."
```

### 연구 기반 학습 방법론
- **명시적 교정** > 단순 반복 (Frontiers in Psychology, 2023)
- **i+1 난이도** 자동 조절 (NAACL 2025)
- **간격 반복**으로 이전 표현 복습 (Kim 2022 메타분석)
- **불안감 감소** 프레이밍 (ELLMA-T, 2024)

## 프로젝트 구조

```
CVO/
├── CLAUDE.md                          # 프로젝트 지침 (Coach 역할 정의)
├── .claude/skills/                    # Claude Code Skills
│   ├── correct/SKILL.md               # 자동 교정 (auto-invocation)
│   ├── warmup/SKILL.md                # 워밍업 대화
│   ├── shadow/SKILL.md                # 섀도잉
│   ├── interview/SKILL.md             # 모의 면접
│   ├── debate/SKILL.md                # 토론
│   ├── review/SKILL.md                # 리뷰
│   └── level/SKILL.md                 # 레벨 체크
├── prompts/
│   ├── tutor_persona.md               # 튜터 페르소나
│   ├── correction_rules.md            # 교정 규칙
│   └── research_methods.md            # 연구 기반 방법론
├── bank/
│   ├── interview/                     # 면접 질문 뱅크
│   │   ├── self_intro.md              # 자기소개
│   │   ├── behavioral.md              # 행동 면접 (STAR)
│   │   ├── technical_dt.md            # 기술 면접 (디지털트윈)
│   │   └── situational.md             # 상황 대처
│   ├── daily_topics.md                # 일상 대화 주제 25개
│   └── expressions/
│       ├── interview_must.md          # 면접 필수 표현 30+
│       └── tech_terms_dt.md           # 디지털트윈 기술 용어 50+
├── progress/
│   ├── sessions.jsonl                 # 세션 기록
│   └── vocab_log.md                   # 배운 표현 누적
└── scripts/
    └── log_session.py                 # 세션 로그 유틸리티
```

## 다른 프로젝트에서 사용하기 (Submodule)

다른 프로젝트에 `.cvo/` submodule로 추가하면, 해당 프로젝트에서 바로 영어 연습이 가능합니다:

```bash
# 1. submodule 추가
git submodule add https://github.com/akfldk1028/CVO.git .cvo

# 2. install.sh 실행 (스킬 심링크 + CLAUDE.md 설정 자동)
bash .cvo/install.sh

# 3. Claude Code 실행 후 바로 사용
claude
/warmup
```

`install.sh`가 하는 일:
- `.claude/skills/` 에 CVO 스킬 심링크 생성
- 프로젝트 `CLAUDE.md`에 Coach 모드 설정 추가
- `progress/` 디렉토리 및 로그 파일 초기화

## 세션 로그 유틸리티

```bash
# 세션 기록
python scripts/log_session.py log --mode warmup --sentences 8 --corrections 3 --summary "시제 오류"

# 표현 추가
python scripts/log_session.py vocab --expression "work on" --meaning "~에 참여하다" --mode warmup

# 통계 조회
python scripts/log_session.py stats
```

## 대상
- 영어 초급 한국인 개발자
- 특히 디지털트윈/IoT/3D/게임엔진 분야
- 영어 기술 면접 준비가 필요한 분

## Requirements
- [Claude Code](https://claude.com/claude-code) CLI
- Python 3.8+ (세션 로그용)
