# Changelog

## 1.0.7 - 2026-04-03

- Realigned the skill around the plugin-backed `compile-changed`, `ask-and-archive`, and `lint-check` workflows
- Rewrote the scaffold and reference docs to match the plugin 1.0 Vault layout and boundaries
- Updated marketplace metadata and publish scripts to reflect the new plugin-aligned scope

## 1.0.6 - 2026-04-03

- Rewrote the SKILL frontmatter description so ClawHub uses the intended hero summary instead of the old workflow-first technical description
- Put the Andrej Karpathy (`@karpathy`) attribution and the product promise directly into the source description field

## 1.0.5 - 2026-04-03

- Refined the public summary into a two-line hero format
- Kept the Andrej Karpathy (`@karpathy`) attribution as the first line and moved the product promise into the second line

## 1.0.4 - 2026-04-03

- Changed the public summary to show the exact attribution sentence: `Inspired by a public workflow shared by Andrej Karpathy (@karpathy).`
- Kept the marketplace-facing summary as a two-sentence abstract so the attribution appears verbatim first

## 1.0.3 - 2026-04-03

- Rewrote the public summary to make the Andrej Karpathy (`@karpathy`) attribution clearer and more marketplace-friendly
- Updated marketplace-facing short copy to emphasize a compounding Markdown knowledge base

## 1.0.2 - 2026-04-03

- Moved the Andrej Karpathy (`@karpathy`) inspiration attribution into the top-level summary and marketplace-facing short description
- Made the public abstract clearer by surfacing the attribution in the first sentence

## 1.0.1 - 2026-04-03

- Added public inspiration attribution to Andrej Karpathy (`@karpathy`) in outward-facing release docs
- Clarified that the workflow lineage comes from a public knowledge-base workflow rather than implying endorsement

## 1.0.0 - 2026-04-03

- Initial public release of `LLM Knowledge Bases`
- Added the core skill workflow for ingest, compile, answer, and maintenance modes
- Positioned the release explicitly as workflow-first, not a mature standalone CLI
- Added English-first outward documentation policy
- Added repository layout and maintenance reference documents
- Added `scripts/init_llm_kb_repo.sh` to scaffold a new knowledge-base repository
- Added release-facing documentation and ClawHub metadata
