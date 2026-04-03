#!/usr/bin/env bash
set -euo pipefail

skill_dir="$(cd "$(dirname "$0")/.." && pwd)"

clawhub publish "$skill_dir" \
  --slug llm-knowledge-bases \
  --name "LLM Knowledge Bases" \
  --version "1.0.0" \
  --changelog "Initial workflow-first 1.0 release of LLM Knowledge Bases: turn raw research material into a maintained Markdown wiki with reusable outputs, health checks, and an Obsidian-friendly workflow." \
  --tags "knowledge-base,research,markdown,wiki,obsidian,notes,knowledge-management,llm,slides,productivity"
