# 연구 기반 학습 방법론 (Research-Backed Methods)

> 아래 방법론들은 최신 논문/연구에서 검증된 것들입니다. 모든 세션에 적용하세요.

## 1. 즉시 교정 피드백 (Immediate Corrective Feedback)

**근거**: Frontiers in Psychology (2023) 체계적 리뷰 — 즉시 피드백이 스피킹 문맥에서 더 효과적
- 매 문장 즉시 교정 ✓ (현재 CVO 방식과 일치)
- 단, **recast(단순 반복)보다 explicit correction(명시적 교정)** 이 학습자 uptake 높음
- → CVO 방식: 틀린 부분을 명시적으로 짚고 한국어로 설명

> 📎 Ref: "Optimal timing of treatment for errors in second language learning" (PMC, 2023)

## 2. 문법 수준 맞춤 대화 (Grammar-Grounded Dialogue)

**근거**: "Grammar Control in Dialogue Response Generation for Language Learning Chatbots" (NAACL 2025, arXiv:2502.07544)
- 학습자의 현재 문법 수준에 맞춰 대화를 생성해야 함
- 너무 쉬운 문법만 쓰면 성장 없음, 너무 어려우면 좌절
- **i+1 원칙**: 현재 수준보다 딱 한 단계 위의 문법을 자연스럽게 노출

### 적용법:
- 초급: 현재형, 과거형, 기본 전치사 집중
- 초급→중급 전환기: 현재완료, 관계대명사, 조건문 서서히 도입
- Coach 발화에 목표 문법을 자연스럽게 포함 → 학습자가 무의식적으로 흡수

## 3. LLM 기반 스피킹 연습 효과 (Comuniqa 연구)

**근거**: "Comuniqa: Exploring LLMs for improving speaking skills" (ACM COMPASS 2024, arXiv:2401.15595)
- LLM 기반 앱이 즉각적 피드백 제공 → 스피킹 실력 유의미하게 향상
- 핵심 성공 요소:
  1. **즉각적 피드백** (문법, 어휘, 발음)
  2. **반복 연습 기회** (저부담 환경)
  3. **개인화된 난이도 조절**

### 적용법:
- 매 세션 시작 시 이전 세션 약점 기반 맞춤 연습
- 틀려도 OK인 분위기 강조 ("This is practice, mistakes help you learn!")
- 같은 표현을 다른 맥락에서 반복 사용하도록 유도

## 4. 간격 반복 (Spaced Repetition)

**근거**: Kim (2022) 메타분석 — 간격 반복이 L2 학습에 중간~큰 효과 크기
- 한 번 배운 표현을 시간 간격을 두고 반복
- 짧은 간격보다 **긴 간격이 장기 기억에 더 효과적**

### 적용법:
- `vocab_log.md`에 기록된 표현을 다음 세션에서 자연스럽게 재사용
- `/warmup` 시작 시 지난 세션의 핵심 표현 2-3개 복습
- `/shadow` 에서 과거 틀렸던 문장 패턴 재출제
- 1일 → 3일 → 7일 → 14일 간격으로 복습 추천

## 5. 불안감 감소 (Anxiety Reduction)

**근거**: ELLMA-T 연구 (arXiv:2410.02406) + AI chatbot 메타분석
- AI 대화 상대는 사람보다 불안감 낮춤 → 발화 의지(willingness to communicate) 증가
- 75% 도시 학생, 87.5% 농촌 학생이 AI 앱으로 스피킹 자신감 향상 보고

### 적용법:
- Coach 톤: 격려적, 절대 비판적이지 않음
- "There's no wrong answer here" / "Good try!" 자주 사용
- 한국어 섞어 써도 OK → 점진적으로 영어 비율 높이기
- 실수를 학습 기회로 프레이밍 ("This is a common mistake, good that we caught it!")

## 6. 한국어-영어 코드스위칭 전략

**근거**: 바이링구얼 학습 연구 일반론 + 실용적 필요성 (음성 인식 정확도)
- 한국어 혼합 자유 → 영어 표현 모를 때 한국어로 대체 가능
- Coach가 전체를 영어로 재구성해서 보여줌
- 핵심: **한국어 사용에 대한 죄책감 없애기**

### 적용법:
```
User: "I 어제 deploy 했는데 bug가 있어서 rollback 했어"
Coach:
  ✓ "I deployed yesterday, but there was a bug, so I rolled back."
  → 자연스럽게 한국어 부분을 영어로 전환해서 보여주기
  → "deploy → deployed (과거형), bug가 있어서 → there was a bug"
```

## 7. STAR 메서드 + 영어 면접 (구조화된 답변)

**근거**: 행동 면접 연구 일반론
- 구조화된 답변이 면접관에게 더 높은 점수
- 한국어로 STAR 구조 먼저 잡기 → 영어로 전환 → 교정

### 적용법:
- 면접 모드에서 STAR 프레임 한국어로 먼저 코칭
- 각 STAR 단계별로 1-2문장씩 영어로 말하기
- 한꺼번에 긴 답변보다 단계별 빌드업

---

## 참고 논문/자료

1. [Comuniqa: Exploring LLMs for improving speaking skills](https://arxiv.org/abs/2401.15595) (ACM COMPASS 2024)
2. [Grammar Control in Dialogue Response Generation for Language Learning Chatbots](https://arxiv.org/abs/2502.07544) (NAACL 2025)
3. [ELLMA-T: Embodied LLM-agent for English Language Learning](https://arxiv.org/abs/2410.02406) (2024)
4. [Zero-Shot Speech LLMs for Multi-Aspect Evaluation of L2 Speech](https://arxiv.org/abs/2601.16230) (SLaTE 2025)
5. [Speak & Improve Corpus 2025](https://arxiv.org/abs/2412.11986) (L2 English Speech Corpus)
6. [Spaced Practice on L2 Learning: Meta-Analysis](https://onlinelibrary.wiley.com/doi/abs/10.1111/lang.12479) (Kim, 2022)
7. [Corrective Feedback Timing in SLA](https://pmc.ncbi.nlm.nih.gov/articles/PMC9995700/) (Frontiers in Psychology, 2023)
8. [AI chatbots in L2 education: Systematic Review](https://www.sciencedirect.com/science/article/pii/S2215039025000086) (2025)
9. [Chatbot Effectiveness in Language Learning: Meta-Analysis](https://onlinelibrary.wiley.com/doi/full/10.1111/ijal.12668) (Lyu, 2025)
10. [LLM-based Chatbots impact on L2 vocabulary](https://pmc.ncbi.nlm.nih.gov/articles/PMC10850600/) (PMC, 2024)
