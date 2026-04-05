# LLM Knowledge Bases

Use this guide when Codex should operate a Vault managed by the `LLM Knowledge Bases` MCP server.

Core model:

- `raw/` stores captured source material
- `wiki/` stores the persistent knowledge layer
- `wiki/sources/` stores compiled source pages
- `wiki/outputs/` stores archived answers
- `wiki/concepts/`, `wiki/entities/`, and `wiki/syntheses/` store durable derived pages
- `wiki/_indexes/`, `wiki/index.md`, and `wiki/log.md` keep the vault navigable

Boundaries:

- treat the Vault as runtime-managed
- use MCP tools for all Vault reads and writes
- never modify `raw/`
- never write directly into `wiki/` with generic file tools
- never invent IDs, hashes, or `source_refs`

Required MCP tools:

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

Canonical actions:

1. `ingest-source`
   - `kb_status`
   - `kb_list_raw(changed_only=true)`
   - `kb_prepare_source`
   - `kb_read_raw`
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
   - repair narrowly through runtime tools
   - `kb_rebuild_indexes`

4. `map-gaps`
   - `kb_search`
   - `kb_read_notes`
   - `kb_map_gaps`
   - optionally `kb_promote_gap` when the best current candidate should be landed immediately

Writing rules:

- source pages need `Summary`, `Key Points`, `Evidence`, `Open Questions`, `Related Links`
- output pages need `Answer`, `Sources Used`, `Follow-up Questions`
- concept pages need `Summary`, `Definition`, `Key Points`, `Evidence`, `Open Questions`, `Related Notes`
- entity pages need `Summary`, `Who or What`, `Key Facts`, `Evidence`, `Open Questions`, `Related Notes`
- synthesis pages need `Summary`, `Thesis`, `Supporting Evidence`, `Tensions`, `Open Questions`, `Related Notes`

Finish by stating:

- what was ingested, answered, or maintained
- which MCP tools were used
- which pages were created or updated
- any unresolved ambiguity or weak evidence
