"""
Session Logger for CVO English Speaking Practice
세션 기록 유틸리티

Usage:
    python scripts/log_session.py log --mode warmup --sentences 8 --corrections 5 --summary "시제 오류 자주 발생"
    python scripts/log_session.py vocab --expression "work on" --meaning "~에 참여하다" --mode warmup
    python scripts/log_session.py stats
"""

import json
import argparse
import sys
import io
from datetime import datetime
from pathlib import Path

# Fix Windows console encoding
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")

SESSIONS_FILE = Path(__file__).parent.parent / "progress" / "sessions.jsonl"
VOCAB_FILE = Path(__file__).parent.parent / "progress" / "vocab_log.md"


def log_session(mode: str, sentences: int, corrections: int, summary: str, score: int = 0):
    """세션 기록을 sessions.jsonl에 추가"""
    entry = {
        "date": datetime.now().strftime("%Y-%m-%d %H:%M"),
        "mode": mode,
        "sentences": sentences,
        "corrections": corrections,
        "accuracy": round((1 - corrections / max(sentences, 1)) * 100, 1),
        "score": score,
        "summary": summary,
    }

    with open(SESSIONS_FILE, "a", encoding="utf-8") as f:
        f.write(json.dumps(entry, ensure_ascii=False) + "\n")

    print(f"✓ 세션 기록 완료: {entry['date']} | {mode} | 정확도 {entry['accuracy']}%")
    return entry


def add_vocab(expression: str, meaning: str, mode: str):
    """새 표현을 vocab_log.md에 추가"""
    date = datetime.now().strftime("%Y-%m-%d")
    line = f"| {date} | {expression} | {meaning} | {mode} |\n"

    with open(VOCAB_FILE, "a", encoding="utf-8") as f:
        f.write(line)

    print(f"✓ 표현 추가: {expression} ({meaning})")


def get_stats():
    """누적 통계 출력"""
    if not SESSIONS_FILE.exists() or SESSIONS_FILE.stat().st_size == 0:
        print("아직 기록된 세션이 없습니다.")
        return

    sessions = []
    with open(SESSIONS_FILE, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if line:
                sessions.append(json.loads(line))

    total = len(sessions)
    modes = {}
    total_accuracy = 0

    for s in sessions:
        mode = s["mode"]
        modes[mode] = modes.get(mode, 0) + 1
        total_accuracy += s.get("accuracy", 0)

    avg_accuracy = round(total_accuracy / total, 1) if total > 0 else 0

    print(f"\n📊 누적 통계")
    print(f"  총 세션: {total}회")
    print(f"  평균 정확도: {avg_accuracy}%")
    print(f"  모드별:")
    for mode, count in sorted(modes.items()):
        print(f"    - {mode}: {count}회")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="CVO Session Logger")
    sub = parser.add_subparsers(dest="command")

    # log command
    log_parser = sub.add_parser("log", help="Log a session")
    log_parser.add_argument("--mode", required=True, choices=["warmup", "shadow", "interview", "debate", "level"])
    log_parser.add_argument("--sentences", type=int, required=True)
    log_parser.add_argument("--corrections", type=int, required=True)
    log_parser.add_argument("--score", type=int, default=0)
    log_parser.add_argument("--summary", required=True)

    # vocab command
    vocab_parser = sub.add_parser("vocab", help="Add vocabulary")
    vocab_parser.add_argument("--expression", required=True)
    vocab_parser.add_argument("--meaning", required=True)
    vocab_parser.add_argument("--mode", required=True)

    # stats command
    sub.add_parser("stats", help="Show statistics")

    args = parser.parse_args()

    if args.command == "log":
        log_session(args.mode, args.sentences, args.corrections, args.summary, args.score)
    elif args.command == "vocab":
        add_vocab(args.expression, args.meaning, args.mode)
    elif args.command == "stats":
        get_stats()
    else:
        parser.print_help()
