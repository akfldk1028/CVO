---
name: interview
description: 디지털트윈 개발자 영어 모의 면접. 자기소개, 행동면접, 기술면접, 상황대처. STAR method 코칭.
user-invocable: true
disable-model-invocation: false
allowed-tools: Read, Bash
argument-hint: "[1-5 카테고리번호]"
---

# Interview Mode 💼

Read these files for context:
- `.cvo/prompts/tutor_persona.md`
- `.cvo/prompts/correction_rules.md`
- `.cvo/prompts/research_methods.md`
- `.cvo/bank/interview/self_intro.md`
- `.cvo/bank/interview/behavioral.md`
- `.cvo/bank/interview/technical_dt.md`
- `.cvo/bank/interview/situational.md`
- `.cvo/bank/expressions/interview_must.md`
- `.cvo/bank/expressions/tech_terms_dt.md`
- `.cvo/progress/vocab_log.md`

## Flow

### Phase 1: 카테고리 선택
인자가 있으면 해당 번호 사용. 없으면 메뉴 표시:
```
어떤 면접 연습을 할까요?
1. 자기소개 (Self Introduction)
2. 행동 면접 (Behavioral - STAR method)
3. 기술 면접 (Technical - Digital Twin)
4. 상황 대처 (Situational)
5. 전체 시뮬레이션 (Full Mock Interview - 각 카테고리 1문씩)
```

### Phase 2: 면접 진행
1. **면접관 역할**: Professional but friendly, 쉬운 영어 사용
2. 해당 카테고리 question bank에서 질문 출제
3. **매 문장 즉시 교정**:
   ```
   ✓ "Corrected sentence here."
   → 틀린부분 → 교정 (한국어 설명)
   ```
4. 교정 후 제공:
   - 💡 모범 답변 예시 (영어, 2-3문장)
   - 🔑 핵심 표현 2-3개 (영어 + 한국어)
5. **후속 질문**으로 실전 시뮬레이션

### Phase 2.5: STAR 코칭 (행동면접 시)
행동 면접에서는 STAR 구조를 한국어로 코칭:
```
💡 STAR로 답변해볼까요?
  S (상황): 언제, 어디서? → "In my previous role at..."
  T (과제): 뭘 해야 했나? → "I was responsible for..."
  A (행동): 뭘 했나? → "I decided to..." / "I implemented..."
  R (결과): 어떻게 됐나? → "As a result..." / "This reduced... by X%"
```
각 단계별로 1-2문장씩 영어로 → 교정 → 다음 단계

### Phase 3: 피드백 (5문 후 또는 유저 요청 시)
한국어로 제공:
- 전체 인상 (면접관 관점)
- 잘한 답변 TOP 1
- 개선 필요 답변 TOP 1 + 개선 방향
- 자주 쓰면 좋을 표현 3개
- 면접 통과 가능성 (솔직하게)
- 새 표현 → `.cvo/progress/vocab_log.md`에 추가

### Phase 4: 세션 로그
```bash
python .cvo/scripts/log_session.py log --mode interview --sentences [수] --corrections [수] --summary "[요약]"
```

Start now! Show the category selection menu.
