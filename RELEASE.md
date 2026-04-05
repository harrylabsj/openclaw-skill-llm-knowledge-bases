# LLM Knowledge Bases Release Notes

## Short Description

Inspired by a public workflow shared by Andrej Karpathy (@karpathy).
From raw research to a living Markdown wiki that compounds with every question.

## Marketplace Card Copy

Title:
- LLM Knowledge Bases

Slug:
- llm-knowledge-bases

Short description:
- Inspired by a public workflow shared by Andrej Karpathy (@karpathy).

Install hook:
- From raw research to a living Markdown wiki that compounds with every question

## Announcement Copy

`LLM Knowledge Bases` now positions itself more honestly and more ambitiously as a wiki-first system:

- capture raw sources locally
- compile them into grounded source pages
- promote repeated ideas into concept and entity pages
- write cross-source analysis into synthesis pages
- keep the wiki navigable with generated indexes and logs

The workflow remains local-first and Markdown-first, but the product story is no longer just "safe runtime + three commands." The wiki itself is now the center of gravity.

This release is still explicitly inspired by a public workflow shared by Andrej Karpathy ([@karpathy](https://x.com/karpathy)) around using LLMs to maintain personal knowledge bases built from Markdown, images, and accumulated outputs. That attribution helps position the skill in a recognizable lineage without implying endorsement.

The current patch focuses on:

- wiki-first docs and agent prompts
- first-class `concept`, `entity`, and `synthesis` page types
- runtime-backed gap mapping through `kb_map_gaps`
- prioritized gap candidates with ready-to-fill Markdown drafts
- suggested openings and evidence summaries for semi-automatic page drafting
- generated `wiki/index.md` and `wiki/log.md`
- richer `_indexes/` coverage across source, output, and derived pages
- a scaffold shape that matches the upgraded wiki model
- durable file-back behavior where good answers can become reusable wiki pages

It works especially well with Obsidian, while staying portable because everything remains plain Markdown.

## Suggested Tags

- knowledge-base
- research
- markdown
- wiki
- obsidian
- notes
- knowledge-management
- llm
- productivity
- local-first

## Suggested Repo Name

- `openclaw-skill-llm-knowledge-bases`

## Publish Command

```bash
clawhub publish /absolute/path/to/llm-knowledge-bases \
  --slug llm-knowledge-bases \
  --name "LLM Knowledge Bases" \
  --version "1.1.4" \
  --changelog "Add kb_promote_gap so the best current gap candidate can be promoted straight into a real derived note." \
  --tags "knowledge-base,research,markdown,wiki,obsidian,notes,knowledge-management,llm,productivity,local-first"
```
