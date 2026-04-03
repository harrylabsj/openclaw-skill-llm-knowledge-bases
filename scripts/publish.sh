#!/usr/bin/env bash
set -euo pipefail

skill_dir="$(cd "$(dirname "$0")/.." && pwd)"

clawhub publish "$skill_dir" \
  --slug llm-knowledge-bases \
  --name "LLM Knowledge Bases" \
  --version "1.0.6" \
  --changelog "Update the SKILL description so ClawHub uses the intended Karpathy-inspired hero summary on the page." \
  --tags "knowledge-base,research,markdown,wiki,obsidian,notes,knowledge-management,llm,slides,productivity"
