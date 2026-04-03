# LLM Knowledge Bases Release Notes

## Short Description

Workflow-first 1.0 release for building a living Markdown knowledge base where raw sources become linked wiki pages, durable answer artifacts, and continuously improving research memory.

## Marketplace Card Copy

Title:
- LLM Knowledge Bases

Slug:
- llm-knowledge-bases

Short description:
- Workflow-first skill for turning raw research material into a maintained Markdown wiki with reusable outputs and health checks

Install hook:
- Stop treating research as disposable chat context and start growing a durable knowledge base that compounds over time

## Announcement Copy

`LLM Knowledge Bases` packages a workflow that many power users already approximate with ad hoc scripts:

- capture raw sources locally
- compile them into linked Markdown pages
- answer questions by writing files back into the repo
- keep the corpus clean with health checks and incremental maintenance

This release is designed for people who want a practical, local-first knowledge system instead of a fragile pile of notes or a heavyweight retrieval stack too early.

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
  --version "1.0.0" \
  --changelog "Initial workflow-first 1.0 release of LLM Knowledge Bases: turn raw research material into a maintained Markdown wiki with reusable outputs, health checks, and an Obsidian-friendly workflow." \
  --tags "knowledge-base,research,markdown,wiki,obsidian,notes,knowledge-management,llm,slides,productivity"
```
