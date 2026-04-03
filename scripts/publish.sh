#!/usr/bin/env bash
set -euo pipefail

skill_dir="$(cd "$(dirname "$0")/.." && pwd)"

clawhub publish "$skill_dir" \
  --slug llm-knowledge-bases \
  --name "LLM Knowledge Bases" \
  --version "1.0.4" \
  --changelog "Show the Andrej Karpathy (@karpathy) attribution as an exact sentence in the public summary." \
  --tags "knowledge-base,research,markdown,wiki,obsidian,notes,knowledge-management,llm,slides,productivity"
