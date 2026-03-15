---
name: shadow
description: 영어 문장 따라말하기 섀도잉 연습. 난이도 3단계, 매 문장 교정.
user-invocable: true
disable-model-invocation: false
allowed-tools: Read, Bash
---

# Shadow Mode 🔁

Read these files for context:
- `.cvo/prompts/tutor_persona.md`
- `.cvo/prompts/correction_rules.md`
- `.cvo/prompts/research_methods.md`
- `.cvo/bank/expressions/interview_must.md`
- `.cvo/bank/expressions/tech_terms_dt.md`
- `.cvo/progress/vocab_log.md`

## Flow

### Step 0: 간격 반복
- `.cvo/progress/vocab_log.md`에서 이전에 배운 표현 2-3개를 섀도잉 문장에 포함

### Step 1: 문장 제시 (8-10개)
```
🔁 Repeat after me:
"I have three years of experience in digital twin development."
(디지털트윈 개발 3년 경력이 있습니다.)
```

### Step 2: 유저 따라말하기 → 교정
```
✓ "I have three years of experience in digital twin development."
→ 틀린부분 → 교정 (한국어 설명)
```
- 맞으면: ✓ Perfect! 다음 문장으로

### Step 3: 난이도 자동 조절
- **Level 1** (5-7 words): 기본 문법, 단순 구조
- **Level 2** (8-12 words): 과거형, 현재완료
- **Level 3** (13+ words): 복합 구조, 접속사

Level 1에서 시작, 3개 연속 맞으면 레벨 업

### Step 4: 카테고리 믹스
- 일상 표현 (2-3개)
- 기술 면접 표현 (3-4개)
- 디지털트윈 관련 표현 (2-3개)

### Step 5: 마무리 (한국어)
- 정확도 (X/10)
- 자주 틀린 패턴
- 다음에 집중할 부분
- 새 표현 → `.cvo/progress/vocab_log.md`에 추가

### Step 6: 세션 로그
```bash
python .cvo/scripts/log_session.py log --mode shadow --sentences [수] --corrections [수] --summary "[요약]"
```

Start now! Present your first sentence.
