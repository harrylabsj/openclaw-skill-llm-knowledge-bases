---
name: llm-knowledge-bases
description: Inspired by a public workflow shared by Andrej Karpathy (@karpathy). Use when the user wants to operate a Markdown wiki backed by the LLM Knowledge Bases runtime: ingest text, PDF, image, or structured-data raw sources; maintain concept/entity/synthesis pages; answer questions from the wiki; archive outputs; or run deterministic multimodal wiki lint.
---

# LLM Knowledge Bases

Use this skill to operate a Vault that is managed by the `LLM Knowledge Bases` runtime.

The operating model is:

- `raw/` stores captured source material from the outside world
- `wiki/sources/` stores compiled source notes
- `wiki/outputs/` stores archived answer notes
- `wiki/concepts/` stores durable concept pages
- `wiki/entities/` stores durable entity pages
- `wiki/syntheses/` stores cross-source synthesis pages
- `wiki/_indexes/` stores generated collection indexes
- `wiki/index.md` stores the generated home index
- `wiki/log.md` stores the generated run log page
- `.llm-kb/` stores runtime state
- `.llm-kb/representations/` stores runtime-managed OCR, vision, metadata, and profiling artifacts for non-text raw assets

The runtime owns Vault I/O.
The agent owns understanding, synthesis, linking, and deciding which pages the wiki should gain or improve.

## Important Model

- Treat the Vault as runtime-managed.
- Use `kb_*` tools for all Vault reads and writes.
- Never modify files under `raw/`.
- Never write directly into `wiki/` or `.llm-kb/representations/` with generic file tools.
- Never fabricate IDs, canonical paths, raw hashes, representation paths, or `source_refs`.
- For text and structured-data raw files, use the direct source compile path.
- For PDF and image raw files, use the representation-first path: bundle the asset context, create any missing representations, then compile the source note.
- When a source note summarizes a PDF or image, keep `asset_paths` accurate and include visible review notes, usually `# Visual Notes`, whenever the source depends on a human or model review pass outside the stored representation files.
- The goal is not only to answer questions.
- The goal is to leave the wiki better structured after each meaningful interaction.

## Required Tools

- `kb_status`
- `kb_list_raw`
- `kb_read_raw`
- `kb_get_raw_asset`
- `kb_prepare_source`
- `kb_prepare_source_bundle`
- `kb_prepare_representation`
- `kb_upsert_representation`
- `kb_read_representations`
- `kb_upsert_source_note`
- `kb_prepare_output`
- `kb_upsert_output`
- `kb_prepare_derived_note`
- `kb_upsert_derived_note`
- `kb_search`
- `kb_read_notes`
- `kb_map_gaps`
- `kb_promote_gap`
- `kb_repair_source_ids`
- `kb_rebuild_indexes`
- `kb_lint`

If these tools are unavailable, say so clearly instead of pretending the workflow can proceed.

## Canonical Actions

Treat the following as the four canonical high-level actions for this skill.

### `ingest-source`

Use this when the user wants to ingest, compile, or refresh changed raw material.

Sequence:

1. call `kb_status`
2. call `kb_list_raw` with `changed_only=true`
3. for each changed raw file:
   - if the raw file is text or structured data:
     - call `kb_prepare_source`
     - call `kb_read_raw`
     - compile the raw content into one grounded source note
   - if the raw file is a PDF or image:
     - call `kb_prepare_source_bundle`
     - call `kb_get_raw_asset`
     - if `compile_readiness` is not `ready`, create the missing representation trail with:
       - `kb_prepare_representation`
       - `kb_upsert_representation`
     - call `kb_read_representations`
     - compile the source note from the raw metadata plus the reviewed representations
   - call `kb_upsert_source_note`
4. after the batch, call `kb_rebuild_indexes`
5. report what was compiled, what remains partial, and which raw assets still need representation work

Important:

- the actual LLM compile happens between the read/bundle steps and `kb_upsert_source_note`
- `kb_read_raw` is only for text-readable raw files
- PDFs usually become compile-ready once there is `native_text`, `ocr_text`, or `page_notes`
- images usually become compile-ready once there is `vision_notes`
- structured data is already text-readable, but `metadata` or `data_profile` can still improve later maintenance
- one raw file may later justify new `concept`, `entity`, or `synthesis` pages
- prefer incremental passes over giant rewrites

### `ask-and-file`

Use this when the user wants a grounded answer and the answer may deserve a durable artifact.

Sequence:

1. call `kb_search`
2. read only the most relevant notes with `kb_read_notes`
3. answer only from retrieved notes
4. decide the best write-back target:
   - use `kb_prepare_output` + `kb_upsert_output` for question-specific answer archives
   - use `kb_prepare_derived_note` + `kb_upsert_derived_note` when the answer should become a durable `concept`, `entity`, or `synthesis` page
5. call `kb_rebuild_indexes` if the wiki changed materially

Important:

- search before answering
- do not cite notes you did not read
- do not answer directly from non-text raw assets when the runtime already expects the grounded source note or stored representation trail
- choose `output` when preserving the exact query matters
- choose `concept/entity/synthesis` when the answer is reusable beyond the original query

### `maintain-wiki`

Use this when the user wants cleanup, organization, or a quality pass.

Sequence:

1. call `kb_lint`
2. inspect `wiki/index.md`, `wiki/log.md`, and the most relevant collection indexes with `kb_read_notes`
3. identify weak pages, missing derived pages, stale navigation, or grounding gaps
4. if source note ids, manifest entries, source note paths, or stored raw hashes have drifted, call `kb_repair_source_ids` first as a dry run and only apply it when the plan is correct
5. if the user wants fixes, repair narrowly through the appropriate `kb_*` write tools
6. call `kb_rebuild_indexes`

Important:

- prefer small targeted improvements
- keep source grounding visible
- use `concept/entity/synthesis` pages to absorb recurring structure instead of repeating the same reasoning in outputs
- treat `kb_lint` warnings as signals about wiki health, not only schema correctness
- pay special attention when `kb_lint` surfaces `missing_representation`, `representation_stale`, `unreviewed_asset_source`, stale source coverage, unresolved research gaps, unsupported claims, contradiction candidates, or missing high-value pages
- use `kb_repair_source_ids` for deterministic source-note/manifest repair instead of hand-editing ids, paths, or raw hashes

### `map-gaps`

Use this when the user wants to know what the wiki is missing.

Sequence:

1. call `kb_search`
2. read the relevant source, output, and derived pages
3. call `kb_map_gaps`
4. identify:
   - repeated ideas that deserve a `concept` page
   - repeated named items that deserve an `entity` page
   - cross-source themes that deserve a `synthesis` page
5. if the user wants the page landed immediately, call `kb_promote_gap` with the candidate `note_id`
6. otherwise propose the best next pages in priority order

Important:

- prefer candidates with stronger `source_refs` coverage
- use `kb_promote_gap` when a current candidate should be landed as-is into the wiki
- use the returned draft template as the starting point when you want to refine the page before calling `kb_upsert_derived_note`
- treat the returned suggested opening and evidence summary as scaffolding, not final prose

## Writing Rules

### Source Notes

Required frontmatter fields:

- `id`
- `type: source`
- `title`
- `raw_path`
- `raw_hash`
- `source_kind`
- `tags`
- `created_at`
- `updated_at`
- `status`

Strongly recommended frontmatter fields:

- `raw_kind`
- `mime_type`
- `asset_paths`

Required headings:

- `# Summary`
- `# Key Points`
- `# Evidence`
- `# Open Questions`
- `# Related Links`

Multimodal guidance:

- for PDF and image source notes, `asset_paths` should include the primary reviewed raw asset
- add `# Visual Notes` when the note depends on multimodal review details that are not already obvious from the stored representation files
- do not claim a non-text asset was reviewed if neither the representation trail nor the visible review notes support that claim

### Output Notes

Required frontmatter fields:

- `id`
- `type: output`
- `title`
- `query`
- `source_refs`
- `created_at`
- `updated_at`

Required headings:

- `# Answer`
- `# Sources Used`
- `# Follow-up Questions`

### Derived Notes

Derived pages are for durable wiki structure, not ephemeral chat residue.

Supported kinds:

- `concept`
- `entity`
- `synthesis`

Shared frontmatter fields:

- `id`
- `type`
- `title`
- `aliases`
- `source_refs`
- `tags`
- `created_at`
- `updated_at`
- `status`

Required headings by kind:

- `concept`: `# Summary`, `# Definition`, `# Key Points`, `# Evidence`, `# Open Questions`, `# Related Notes`
- `entity`: `# Summary`, `# Who or What`, `# Key Facts`, `# Evidence`, `# Open Questions`, `# Related Notes`
- `synthesis`: `# Summary`, `# Thesis`, `# Supporting Evidence`, `# Tensions`, `# Open Questions`, `# Related Notes`

Guidance:

- `concept` pages capture reusable ideas or frames
- `entity` pages capture named things that recur
- `synthesis` pages capture higher-level cross-source conclusions that should survive beyond any one query
- `synthesis` pages capture multi-source analysis, tradeoffs, or contested views
- keep `source_refs` aligned with real source notes

## Safety Boundaries

- Never modify files under `raw/`.
- Never use generic file-writing tools to modify `wiki/` directly.
- Never invent note IDs, output IDs, or paths.
- Never claim a write succeeded unless the runtime confirms it.
- Never bypass the runtime after a tool failure.

## Failure Handling

If a runtime tool fails:

- explain the failure plainly
- keep the user context intact
- propose the next executable step
- do not work around the error by writing directly to the Vault

## Language Policy

- Write outward-facing artifacts in English by default.
- Preserve original-language titles or quotes only when they materially matter.
- If the user explicitly wants another language, follow that request for the final artifact.

## Finish Standard

When you finish a task with this skill, report:

- what was ingested, answered, maintained, or mapped
- which `kb_*` tools were used
- which files were created or updated
- any unresolved ambiguity or weak evidence
- the best next one to three follow-up steps
