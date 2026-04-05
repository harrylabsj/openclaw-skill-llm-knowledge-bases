# LLM Knowledge Bases

Use this guide when Codex should operate a Vault managed by the `LLM Knowledge Bases` MCP server.

Core model:

- `raw/` stores captured source material
- `wiki/` stores the persistent knowledge layer
- `wiki/sources/` stores compiled source pages
- `wiki/outputs/` stores archived answers
- `wiki/concepts/`, `wiki/entities/`, and `wiki/syntheses/` store durable derived pages
- `wiki/_indexes/`, `wiki/index.md`, and `wiki/log.md` keep the vault navigable
- `.llm-kb/representations/` stores runtime-managed OCR, vision, metadata, and profiling artifacts for non-text assets

Boundaries:

- treat the Vault as runtime-managed
- use MCP tools for all Vault reads and writes
- never modify `raw/`
- never write directly into `wiki/` or `.llm-kb/representations/` with generic file tools
- never invent IDs, hashes, representation paths, or `source_refs`
- use `kb_read_raw` only for text-readable raw files
- use the representation-first path for PDFs and images

Required MCP tools:

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

Canonical actions:

1. `ingest-source`
   - `kb_status`
   - `kb_list_raw(changed_only=true)`
   - for text/data: `kb_prepare_source` -> `kb_read_raw`
   - for PDFs/images: `kb_prepare_source_bundle` -> `kb_get_raw_asset` -> representation tools -> `kb_read_representations`
   - write one grounded source page
   - `kb_upsert_source_note`
   - `kb_rebuild_indexes`

2. `ask-and-file`
   - `kb_search`
   - `kb_read_notes`
   - answer only from retrieved notes
   - use `kb_upsert_output` for query-specific archives
   - use `kb_upsert_derived_note` for durable concept/entity/synthesis pages

3. `maintain-wiki`
   - `kb_lint`
   - inspect indexes and relevant pages
   - use `kb_repair_source_ids` first when source ids, manifest entries, source note paths, or raw hashes have drifted
   - repair narrowly through runtime tools
   - `kb_rebuild_indexes`

4. `map-gaps`
   - `kb_search`
   - `kb_read_notes`
   - `kb_map_gaps`
   - optionally `kb_promote_gap` when the best current candidate should be landed immediately

Writing rules:

- source pages need `Summary`, `Key Points`, `Evidence`, `Open Questions`, `Related Links`
- multimodal source pages should keep `raw_kind`, `mime_type`, and `asset_paths` aligned with the reviewed asset trail
- PDF/image source pages should usually include `Visual Notes` when the review evidence is not already obvious from stored representations
- output pages need `Answer`, `Sources Used`, `Follow-up Questions`
- concept pages need `Summary`, `Definition`, `Key Points`, `Evidence`, `Open Questions`, `Related Notes`
- entity pages need `Summary`, `Who or What`, `Key Facts`, `Evidence`, `Open Questions`, `Related Notes`
- synthesis pages need `Summary`, `Thesis`, `Supporting Evidence`, `Tensions`, `Open Questions`, `Related Notes`

Finish by stating:

- what was ingested, answered, or maintained
- which MCP tools were used
- which pages were created or updated
- any unresolved ambiguity or weak evidence
