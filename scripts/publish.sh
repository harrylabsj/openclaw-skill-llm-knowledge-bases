#!/usr/bin/env bash
set -euo pipefail

skill_dir="$(cd "$(dirname "$0")/.." && pwd)"

clawhub publish "$skill_dir" \
  --slug llm-knowledge-bases \
  --name "LLM Knowledge Bases" \
  --version "1.0.2" \
  --changelog "Move the Andrej Karpathy (@karpathy) inspiration attribution into the public summary and marketplace-facing description." \
  --tags "knowledge-base,research,markdown,wiki,obsidian,notes,knowledge-management,llm,slides,productivity"
