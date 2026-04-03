# LLM Knowledge Bases Release Notes

## Short Description

Inspired by a public workflow shared by Andrej Karpathy (@karpathy), turn raw research into a living Markdown knowledge base that compounds with every question.

## Marketplace Card Copy

Title:
- LLM Knowledge Bases

Slug:
- llm-knowledge-bases

Short description:
- Inspired by a public workflow shared by Andrej Karpathy (@karpathy), turn raw research into a Markdown knowledge base that compounds

Install hook:
- Bring the Karpathy-inspired knowledge-base workflow into an Obsidian-friendly Markdown system that gets more useful with every query

## Announcement Copy

`LLM Knowledge Bases` packages a workflow that many power users already approximate with ad hoc scripts:

- capture raw sources locally
- compile them into linked Markdown pages
- answer questions by writing files back into the repo
- keep the corpus clean with health checks and incremental maintenance

This release is designed for people who want a practical, local-first knowledge system instead of a fragile pile of notes or a heavyweight retrieval stack too early.

The method is explicitly inspired by a public workflow shared by Andrej Karpathy ([@karpathy](https://x.com/karpathy)) around using LLMs to maintain personal knowledge bases built from Markdown, images, and accumulated outputs. That attribution helps position this skill in a recognizable and credible lineage, without implying endorsement or direct involvement.

It should be presented honestly as a `1.0` workflow release, not as a mature standalone CLI. The current release gives users a strong operating model and scaffolding, while leaving room for future search, compile, and lint tooling.

The first version focuses on:

- clear repository conventions
- source-to-wiki compilation workflow
- answer outputs that accumulate into the corpus
- English-first outward documentation
- a simple scaffold script for new knowledge bases

It works especially well with Obsidian, but keeps everything in plain Markdown so the knowledge base stays portable.

## Suggested Tags

- knowledge-base
- research
- markdown
- wiki
- obsidian
- notes
- knowledge-management
- llm
- slides
- productivity

## Suggested Repo Name

- `openclaw-skill-llm-knowledge-bases`

## Publish Command

```bash
clawhub publish /absolute/path/to/llm-knowledge-bases \
  --slug llm-knowledge-bases \
  --name "LLM Knowledge Bases" \
  --version "1.0.3" \
  --changelog "Rewrite the public summary to make the Andrej Karpathy (@karpathy) attribution clearer and more marketplace-friendly." \
  --tags "knowledge-base,research,markdown,wiki,obsidian,notes,knowledge-management,llm,slides,productivity"
```
