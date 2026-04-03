#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: bash scripts/init_llm_kb_repo.sh <target-dir>" >&2
  exit 1
fi

target_dir="$1"

mkdir -p \
  "$target_dir/raw/articles" \
  "$target_dir/raw/papers" \
  "$target_dir/raw/repos" \
  "$target_dir/raw/datasets" \
  "$target_dir/raw/images" \
  "$target_dir/wiki/sources" \
  "$target_dir/wiki/concepts" \
  "$target_dir/wiki/maps" \
  "$target_dir/wiki/briefs" \
  "$target_dir/outputs/answers" \
  "$target_dir/outputs/slides" \
  "$target_dir/outputs/figures" \
  "$target_dir/queries/open" \
  "$target_dir/queries/archive" \
  "$target_dir/tools"

write_if_missing() {
  local path="$1"
  local content="$2"

  if [[ -e "$path" ]]; then
    return 0
  fi

  printf '%s\n' "$content" > "$path"
}

write_if_missing "$target_dir/wiki/index.md" "# Knowledge Base

## What lives here
- \`sources/\` captures page-level summaries of raw material
- \`concepts/\` connects recurring ideas across sources
- \`maps/\` keeps the corpus navigable
- \`briefs/\` stores durable synthesized writeups

## Starter maps
- [Research Overview](maps/research-overview.md)

## Operating rule
Prefer incremental updates with provenance over large rewrites."

write_if_missing "$target_dir/wiki/maps/research-overview.md" "# Research Overview

## Core themes
- TODO

## Foundational sources
- TODO

## Open questions
- TODO

## Next ingest batch
- TODO"

write_if_missing "$target_dir/queries/open/inbox.md" "# Query Inbox

Capture research requests here before they are answered.

## Template
- Question:
- Why it matters:
- Candidate sources:
- Desired output:
- Status:"

echo "Initialized knowledge base scaffold at: $target_dir"
