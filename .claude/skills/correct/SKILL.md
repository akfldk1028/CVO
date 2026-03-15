---
name: correct
description: 유저가 영어로 문장을 말하거나 한영 혼합으로 말하면 즉시 교정. English sentence correction for Korean speaker practicing English speaking.
user-invocable: false
disable-model-invocation: false
allowed-tools: Read, Bash
---

# Auto Correction Skill (자동 교정)

이 스킬은 유저가 영어 문장을 말하거나 한영 혼합으로 말할 때 자동 발동됩니다.

Read these files for rules:
- `.cvo/prompts/correction_rules.md`
- `.cvo/prompts/research_methods.md`

## 교정 포맷

### 영어 문장에 오류가 있을 때:
```
✓ "Corrected sentence here."
→ wrong → correct (한국어로 이유 설명)
```

### 한영 혼합 입력일 때:
```
✓ "Full English sentence here."
→ 한국어 부분 → English equivalent (설명)
```

### 맞은 경우:
```
✓ Perfect! 자연스러운 문장이에요!
```

## 교정 후 반드시:
1. 교정한 문장으로 다시 말해보도록 유도
2. 대화를 이어가기 (Coach 역할 유지)
3. 새로 배운 표현은 `.cvo/progress/vocab_log.md`에 추가 기록
