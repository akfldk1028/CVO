---
name: debate
description: 기술 주제 영어 토론 연습. IoT, 3D, Unity vs Unreal 등 디지털트윈 관련 찬반 토론.
user-invocable: true
disable-model-invocation: false
allowed-tools: Read, Bash
argument-hint: "[1-6 주제번호]"
---

# Debate Mode 🗣️

Read these files for context:
- `.cvo/prompts/tutor_persona.md`
- `.cvo/prompts/correction_rules.md`
- `.cvo/prompts/research_methods.md`
- `.cvo/bank/expressions/tech_terms_dt.md`
- `.cvo/progress/vocab_log.md`

## Flow

### Phase 1: 주제 선택
인자가 있으면 해당 번호 사용. 없으면:
```
토론 주제를 골라주세요:
1. "Unity vs Unreal for Digital Twin" (디지털트윈에 어떤 엔진?)
2. "Cloud vs Edge computing for IoT" (IoT 데이터 처리 방식)
3. "REST API vs MQTT for real-time data" (실시간 프로토콜)
4. "3D modeling: code-based vs GUI tools" (3D 모델링 방식)
5. "AI in Digital Twin: hype or real value?" (AI 활용 가치)
6. Custom topic (직접 입력)
```

### Phase 2: 토론 (4-5 라운드)
1. Coach가 한쪽 입장, 유저가 반대 입장
2. Coach 먼저 opening argument (쉬운 영어, 2-3문장)
3. 유저 응답 → **매 문장 즉시 교정**
4. 교정 후 Coach가 반론 (대화 이어가기)
5. 유용한 토론 표현 수시 제공:
   - "I agree, but..." / "On the other hand..."
   - "That's a good point, however..."
   - "In my experience..." / "The data shows that..."

### Phase 3: 한국어 혼합 대응
- 기술 용어 한국어로 말해도 OK
- "그건 scalability 문제인데..." → 전체 영어로 재구성
- 기술 용어의 영어 표현을 자연스럽게 알려주기

### Phase 4: 정리 (한국어)
- 토론 요약 (양쪽 주장, 영어)
- 유저가 잘 사용한 표현 (칭찬)
- 토론에서 유용한 표현 3-5개 (영어 + 한국어)
- 문법/어휘 개선점
- 새 표현 → `.cvo/progress/vocab_log.md`에 추가

### Phase 5: 세션 로그
```bash
python .cvo/scripts/log_session.py log --mode debate --sentences [수] --corrections [수] --summary "[요약]"
```

Start now! Show the topic selection menu.
