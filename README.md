# LLM Knowledge Bases

Inspired by a public workflow shared by Andrej Karpathy (@karpathy).
From raw research to a living Markdown wiki that compounds with every question.

## Product Model

`LLM Knowledge Bases` is best understood as a local-first wiki operating system for research.

The core model is:

- `raw/` holds outside-world source material
- `wiki/` holds the persistent knowledge layer the agent maintains
- `schema` defines what kinds of pages belong in the wiki and how they relate
- every ingest, query, and maintenance pass should improve the wiki itself

The runtime provides deterministic guardrails for paths, IDs, validation, and writes.
The skill tells the agent how to grow the wiki into something durable and navigable.

## What Changed

The old mental model was:

- compile raw notes into `wiki/sources/`
- archive answers into `wiki/outputs/`
- lint the structure

The upgraded mental model is:

- ingest raw material into source pages
- promote recurring ideas into `concept` and `entity` pages
- write cross-source analysis into `synthesis` pages
- keep `wiki/index.md` as a master catalog, `wiki/log.md` as a readable activity log, and `_indexes/` current
- let important answers write back into the wiki instead of disappearing into chat history

This is closer to the original Karpathy-style wiki workflow: the wiki is the product, not just a side effect of a runtime.

## Current Page Types

Runtime-backed page kinds now include:

- `source` for grounded source notes compiled from `raw/`
- `output` for archived answers tied to a specific question
- `concept` for reusable ideas that recur across notes
- `entity` for named systems, people, products, orgs, methods, or datasets
- `synthesis` for higher-level cross-source thinking
- `index` for generated navigation pages
- `log` for the generated run log page

## Default Repository Shape

```text
<vault>/
  raw/
    inbox/
    web/
    notes/
    papers/
    repos/
    datasets/
    images/
  wiki/
    sources/
    outputs/
    concepts/
    entities/
    syntheses/
    _indexes/
    index.md
    log.md
  .llm-kb/
    manifest.json
    runs.jsonl
```

## High-Level Actions

The skill should think in terms of four high-level actions:

- `ingest-source`: compile changed raw files into `source` pages and refresh indexes
- `ask-and-file`: answer from retrieved notes and archive the result as an `output` or promote it into a richer wiki page
- `maintain-wiki`: improve navigation, derived pages, consistency, and wiki-health signals across the wiki
- `map-gaps`: identify missing concept/entity/synthesis pages, produce prioritized draft templates, and optionally promote the best current candidate straight into a real derived page

## Runtime-Backed Tools

The runtime now supports the core wiki-maintenance surface:

- `kb_status`
- `kb_list_raw`
- `kb_read_raw`
- `kb_prepare_source`
- `kb_upsert_source_note`
- `kb_prepare_output`
- `kb_upsert_output`
- `kb_prepare_derived_note`
- `kb_upsert_derived_note`
- `kb_search`
- `kb_read_notes`
- `kb_map_gaps`
- `kb_promote_gap`
- `kb_rebuild_indexes`
- `kb_lint`

## Install

```bash
clawhub install llm-knowledge-bases
```

For Claude Code:

```bash
claude mcp add llm-knowledge-bases -- \
  npx -y --package @harrylabs/llm-knowledge-bases@latest \
  llm-knowledge-bases-mcp \
  --vault-root /absolute/path/to/your/obsidian-vault
```

For Codex, copy [`agents/codex-AGENTS.md`](agents/codex-AGENTS.md) into your project root as `AGENTS.md`.

For other MCP-capable agents:

```bash
npx -y --package @harrylabs/llm-knowledge-bases@latest \
  llm-knowledge-bases-configs --vault-root /absolute/path/to/your/obsidian-vault
```

To scaffold a new vault:

```bash
bash scripts/init_llm_kb_repo.sh my-knowledge-base
```

## Example Prompts

```text
Use $llm-knowledge-bases to ingest changed raw notes and refresh the wiki indexes.
```

```text
Use $llm-knowledge-bases to answer "What are the tradeoffs between retrieval and memory finetuning?" and file the result back into the wiki.
```

```text
Use $llm-knowledge-bases to inspect the wiki for missing concept or entity pages around agent memory systems.
```

```text
Use $llm-knowledge-bases to run map-gaps and tell me the next five pages this wiki should gain.
```

```text
Use $llm-knowledge-bases to run map-gaps and immediately promote the top synthesis candidate into the wiki.
```

```text
Use $llm-knowledge-bases to run a wiki maintenance pass and tell me which pages are stale, missing, or weakly grounded.
```

## Writing Style

This skill prefers durable wiki artifacts over chat-only answers:

- source-grounded pages
- explicit `source_refs`
- linked Markdown pages that humans can browse
- generated indexes and logs that keep the vault navigable
- warnings from `kb_lint` that highlight isolated draft pages, missing cross-links, stale source coverage, unresolved research gaps, unsupported claims, contradiction candidates, placeholder content, and medium/high-value missing pages before those problems spread

Outward-facing artifacts default to English unless the user explicitly asks otherwise.
