#!/usr/bin/env bash
set -euo pipefail

skill_dir="$(cd "$(dirname "$0")/.." && pwd)"

clawhub publish "$skill_dir" \
  --slug llm-knowledge-bases \
  --name "LLM Knowledge Bases" \
  --version "1.0.5" \
  --changelog "Refine the public summary into a two-line hero: Karpathy attribution first, compounding knowledge-base promise second." \
  --tags "knowledge-base,research,markdown,wiki,obsidian,notes,knowledge-management,llm,slides,productivity"
