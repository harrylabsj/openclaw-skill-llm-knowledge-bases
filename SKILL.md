---
name: llm-knowledge-bases
description: Build and operate an LLM-maintained markdown knowledge base with `raw/` source capture, `wiki/` compilation, `outputs/` answer artifacts, Obsidian-friendly structure, incremental health checks, and workflow scaffolding. Use when the user wants to ingest articles, papers, repos, datasets, or images; compile them into linked wiki pages; answer questions by writing markdown, slides, or figures back to the repo; or continuously improve a personal or team research vault.
---

# LLM Knowledge Bases

Treat the repository as a living knowledge system:
- `raw/` stores captured source material
- `wiki/` stores durable synthesized knowledge
- `outputs/` stores answers, slide decks, and figures produced for specific questions
- `queries/` stores prompts or work requests that should accumulate over time

Use Obsidian as the default human-facing frontend when the user wants a local-first browsing experience, but keep the repo plain Markdown so it remains tool-agnostic.

## Version Status

This is a workflow-first `1.0` release, not a mature standalone CLI.

What ships today:
- the skill workflow
- repository conventions
- reference docs
- scaffold and publish scripts

What does not ship yet:
- a production-grade compiler
- a full query engine
- a polished search or lint CLI

## When To Use This Skill

Use it for:
- standing up a new research vault
- converting a source dump into a navigable wiki
- incremental source ingest and source-page maintenance
- answering complex questions against the wiki by creating files instead of chat-only answers
- health checks, consistency passes, gap analysis, and candidate article generation
- lightweight local search or indexing tools that help the LLM operate on the corpus

## Operating Modes

### 1. Bootstrap

If the user is starting fresh, run:

```bash
bash scripts/init_llm_kb_repo.sh <target-dir>
```

Read `references/repo-layout.md` before changing the default structure.

### 2. Ingest

For each new source:
- preserve the original material under `raw/`
- normalize web articles to Markdown when possible
- keep local images near the source or under `raw/images/`
- record provenance: title, author, URL or repo, access date, and why the source matters

Every source in `raw/` should eventually have a corresponding page in `wiki/sources/`.

### 3. Compile

Build the wiki incrementally instead of rewriting it wholesale. For each source batch:
- create or update source pages in `wiki/sources/`
- extract concepts, methods, entities, datasets, claims, and open questions
- create or update concept pages in `wiki/concepts/`
- add backlinks, `See also`, and short `Why this matters` sections
- update at least one map or index page in `wiki/maps/` when the topic structure changes

### 4. Answer

When the user asks a question, prefer durable artifacts over chat-only output:
- write answer memos to `outputs/answers/`
- write Marp decks to `outputs/slides/`
- write charts or diagrams to `outputs/figures/`
- if the answer adds lasting knowledge, file it back into `wiki/briefs/` or link it from relevant concept pages

### 5. Lint And Improve

Run health checks when the corpus grows or starts drifting:
- orphan source pages
- orphan concept pages
- weakly sourced claims
- duplicate concepts with inconsistent naming
- missing backlinks
- stale map pages
- source summaries that no longer reflect the raw material

Read `references/maintenance-playbook.md` before implementing automated checks or cleanup passes.

## Default Workflow

1. Inspect `raw/`, `wiki/`, and `outputs/` before changing structure.
2. Make the smallest incremental update that moves the knowledge base forward.
3. Prefer many linked small pages over one giant summary dump.
4. Keep source-grounded pages separate from concept synthesis pages.
5. Leave explicit open questions when the material is incomplete.
6. Suggest the next one to three high-value ingest, synthesis, or audit steps.

## Language Policy

- Write outward-facing documentation in English by default.
- Apply this to public or shareable wiki pages, briefs, slide decks, READMEs, and polished deliverables.
- Preserve original-language titles or quotes when they matter, but explain them in English.
- Temporary scratch notes may follow the user's working language, but final external artifacts should be English unless the user explicitly asks otherwise.

## Writing Rules

- Preserve provenance on every source-derived claim.
- Mark inference clearly when it goes beyond the cited material.
- Do not silently delete uncertain material; downgrade confidence or move it to an open-question section.
- Keep page titles stable so backlinks do not churn.
- Prefer plain Markdown and local assets that Obsidian can render without custom infrastructure.
- Avoid premature RAG or finetuning work unless the corpus size or retrieval quality clearly justifies it.
- Build lightweight CLIs only when they reduce repetitive work for future queries.

## File Conventions

- `wiki/sources/`: one page per source item, including metadata, summary, highlights, and outbound links
- `wiki/concepts/`: one page per recurring concept, method, entity, or theme
- `wiki/maps/`: topic maps, reading lists, timelines, and frontier overviews
- `wiki/briefs/`: durable synthesized briefs that should become part of the knowledge base
- `outputs/answers/`: query-specific answer memos
- `outputs/slides/`: Marp slide decks
- `outputs/figures/`: generated charts, plots, and diagrams
- `queries/open/`: queued research questions
- `queries/archive/`: completed or superseded questions

Read `references/repo-layout.md` when creating new pages or introducing new top-level folders.

## Output Standard

When you finish work with this skill, return:
- what new knowledge was ingested, compiled, or generated
- which files were created or updated
- any unresolved ambiguity or weak evidence
- the best next questions or cleanup passes

## Bundled Resources

- `references/repo-layout.md`: detailed folder contract and starter page shapes
- `references/maintenance-playbook.md`: linting and improvement checklist
- `scripts/init_llm_kb_repo.sh`: scaffold a new local-first knowledge base repo
