# LLM Knowledge Bases Release Notes

## Short Description

Inspired by a public workflow shared by Andrej Karpathy (@karpathy).
From raw text, PDFs, images, and structured data to a living Markdown wiki that compounds with every question.

## Marketplace Card Copy

Title:
- LLM Knowledge Bases

Slug:
- llm-knowledge-bases

Short description:
- Inspired by a public workflow shared by Andrej Karpathy (@karpathy).

Install hook:
- From raw text, PDFs, images, and structured data to a living Markdown wiki that compounds with every question

## Announcement Copy

`LLM Knowledge Bases` now lands on top of runtime `0.4.1` with a representation-first multimodal workflow:

- ingest Markdown, text, and structured data directly
- inspect PDFs and images through deterministic raw-asset metadata
- store OCR, vision, page-note, metadata, and profiling artifacts under `.llm-kb/representations/`
- compile source notes from a full source bundle with explicit readiness states
- keep `raw_kind`, `mime_type`, `asset_paths`, and visible review notes aligned with what was actually reviewed
- promote repeated ideas into concept and entity pages
- write cross-source analysis into synthesis pages
- keep the wiki navigable with generated indexes and logs

The workflow remains local-first and Markdown-first, but it no longer has to pretend every important source is plain text. The wiki itself stays the product, while the runtime now provides a deterministic bridge from non-text assets into grounded notes.

This release is still explicitly inspired by a public workflow shared by Andrej Karpathy ([@karpathy](https://x.com/karpathy)) around using LLMs to maintain personal knowledge bases built from Markdown, images, and accumulated outputs. That attribution helps position the skill in a recognizable lineage without implying endorsement.

The current release focuses on:

- multimodal skill docs and agent prompts for text/data vs PDF/image ingest
- documented runtime tools for `kb_get_raw_asset`, `kb_prepare_source_bundle`, `kb_prepare_representation`, `kb_upsert_representation`, and `kb_read_representations`
- documented deterministic repair through `kb_repair_source_ids` when source ids or manifest/source-note metadata drift
- maintenance guidance that repairs legacy `src-untitled-*` ids before future source updates preserve the stale path
- clearer expectations around `raw_kind`, `mime_type`, `asset_paths`, and visible review notes
- lint follow-up guidance for missing or stale representation trails
- release metadata that matches skill `1.2.1` and runtime `0.4.1`

It works especially well with Obsidian, while staying portable because everything remains plain Markdown.

## Suggested Tags

- knowledge-base
- research
- markdown
- wiki
- obsidian
- multimodal
- pdf
- image
- data
- local-first

## Suggested Repo Name

- `openclaw-skill-llm-knowledge-bases`

## Publish Command

```bash
clawhub publish /absolute/path/to/llm-knowledge-bases \
  --slug llm-knowledge-bases \
  --name "LLM Knowledge Bases" \
  --version "1.2.1" \
  --changelog "Ship deterministic repair for legacy src-untitled source ids on top of runtime 0.4.1." \
  --tags "knowledge-base,research,markdown,wiki,obsidian,multimodal,pdf,image,data,local-first"
```
