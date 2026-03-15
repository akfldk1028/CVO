---
name: review
description: 영어 스피킹 세션 피드백 리뷰. 진도 추적, 패턴 분석, 복습 퀴즈.
user-invocable: true
disable-model-invocation: true
allowed-tools: Read, Bash
---

# Review Mode 📊

Read these files:
- `progress/sessions.jsonl`
- `progress/vocab_log.md`
- `prompts/correction_rules.md`
- `prompts/research_methods.md`

## Flow

### 데이터 없는 경우
```
아직 기록된 세션이 없어요! 먼저 연습을 시작해볼까요?
추천: /warmup (가볍게 시작) 또는 /level (레벨 체크부터)
```

### 데이터 있는 경우 — 전체 한국어로 리뷰

#### 1. 오늘/최근 세션 요약
- 연습 모드 & 시간
- 총 문장 수 / 교정 횟수
- 정확도 (%)

#### 2. 자주 틀리는 패턴 TOP 3
- 패턴 설명 + 예시 (틀린 → 올바른)
- 왜 틀리기 쉬운지 설명

#### 3. 잘하는 점
- 칭찬 2-3개
- 발전이 보이는 영역

#### 4. 누적 통계 (sessions.jsonl 기반)
```bash
python scripts/log_session.py stats
```
- 총 세션 수, 모드별 횟수, 정확도 추이

#### 5. 배운 표현 복습 퀴즈
- `vocab_log.md`에서 최근 10개 표현
- "이 표현을 영어로 말해보세요:" 형식 퀴즈

#### 6. 다음 세션 추천
- 추천 모드 + 집중할 문법/표현
- 구체적 목표 설정

Start now! Begin the review.
