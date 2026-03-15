---
name: level
description: 영어 스피킹 레벨 체크. 5문항 진단 후 맞춤 학습 계획 제시.
user-invocable: true
disable-model-invocation: true
allowed-tools: Read, Bash
---

# Level Check Mode 📏

Read these files:
- `prompts/tutor_persona.md`
- `prompts/correction_rules.md`
- `prompts/research_methods.md`

## Flow

### Phase 1: 레벨 테스트
```
레벨 체크를 시작합니다!
5개의 질문에 영어로 답해주세요.
문장으로 답해주시면 더 정확한 진단이 됩니다.
한국어 섞어도 괜찮아요!
준비되셨으면 "ready"라고 말해주세요!
```

5문항 (easy → hard):
1. **기초**: "What do you do for work?"
2. **초급**: "Can you describe your typical workday?"
3. **중급**: "What was the most challenging project you worked on?"
4. **중상급**: "How would you explain digital twin technology to a non-technical person?"
5. **고급**: "What do you think will be the biggest trend in digital twin technology in the next 5 years, and why?"

**매 답변 즉시 교정** (표준 포맷 사용)

### Phase 2: 진단 결과 (한국어)
```
📊 레벨 진단 결과

현재 레벨: [Beginner / Elementary / Intermediate / Upper-Intermediate / Advanced]

✅ 강점:
- (구체적으로)

⚠️ 약점:
- (구체적으로)

📋 상세 분석:
- 문법 정확도: ★☆☆☆☆ ~ ★★★★★
- 어휘 다양성: ★☆☆☆☆ ~ ★★★★★
- 문장 구조:   ★☆☆☆☆ ~ ★★★★★
- 기술 용어:   ★☆☆☆☆ ~ ★★★★★
- 유창성:      ★☆☆☆☆ ~ ★★★★★

🎯 맞춤 학습 계획:
1. 이번 주 집중: (구체적 목표)
2. 추천 연습 모드: (/warmup, /shadow, /interview 중)
3. 매일 연습 시간: (추천)
4. 면접 준비 타임라인: (현실적 예측)
```

### Phase 3: 세션 로그
```bash
python scripts/log_session.py log --mode level --sentences 5 --corrections [수] --summary "레벨: [결과], 약점: [요약]"
```

Start now! Begin the level check.
