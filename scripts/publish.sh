#!/usr/bin/env bash
set -euo pipefail

skill_dir="$(cd "$(dirname "$0")/.." && pwd)"

clawhub publish "$skill_dir" \
  --slug llm-knowledge-bases \
  --name "LLM Knowledge Bases" \
  --version "1.0.7" \
  --changelog "Align the skill with plugin 1.0 around compile-changed, ask-and-archive, and lint-check workflows, and sync the scaffold and references." \
  --tags "knowledge-base,research,markdown,wiki,obsidian,notes,knowledge-management,llm,lint,productivity"
