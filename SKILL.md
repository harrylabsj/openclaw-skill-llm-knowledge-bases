---
name: llm-knowledge-bases
description: Inspired by a public workflow shared by Andrej Karpathy (@karpathy). Use when the user wants to operate an Obsidian-based Markdown knowledge base through the LLM Knowledge Bases plugin: compile changed raw notes into source notes, search and read the wiki, answer questions from the wiki, archive outputs, or run deterministic lint.
---

# LLM Knowledge Bases

Use this skill to operate a Vault that is managed by the `LLM Knowledge Bases` plugin.

The operating model is:

- `raw/` stores captured Markdown or text source material
- `wiki/sources/` stores compiled source notes
- `wiki/outputs/` stores archived answer notes
- `wiki/_indexes/` stores plugin-generated indexes
- `.llm-kb/` stores plugin state

The plugin owns Vault I/O. The agent owns understanding and writing.

## Important Model

- The Obsidian Vault may be outside the current workspace.
- Do not assume generic file tools can safely access the Vault.
- Treat the Vault as managed by the plugin.
- Use plugin tools for all Vault reads and writes.
- The plugin performs deterministic execution; the LLM performs the actual compile and answer writing.

## Required Tools

- `kb_status`
- `kb_list_raw`
- `kb_read_raw`
- `kb_prepare_source`
- `kb_upsert_source_note`
- `kb_search`
- `kb_read_notes`
- `kb_prepare_output`
- `kb_upsert_output`
- `kb_rebuild_indexes`
- `kb_lint`

If these tools are unavailable, say so clearly instead of pretending the workflow can proceed.

## High-Level Actions

Treat the following as the three canonical high-level actions for this skill.

### `compile-changed`

Use this when the user says things like:

- compile changed sources
- update the wiki
- ingest the new raw notes
- compile the new material

This is the closest high-level action to the original Karpathy-style "call the LLM to compile" step.

The sequence is:

1. call `kb_status`
2. call `kb_list_raw` with `changed_only=true`
3. for each returned raw file:
   - call `kb_prepare_source`
   - call `kb_read_raw`
   - use the LLM to convert the raw content into one valid source note
   - call `kb_upsert_source_note`
4. after the batch, call `kb_rebuild_indexes`
5. report successes, failures, and remaining changed files

Important:

- the actual LLM compile happens between `kb_read_raw` and `kb_upsert_source_note`
- never guess `doc_id`, `source_note_path`, or `raw_hash` without `kb_prepare_source`
- never write source notes with generic file tools
- prefer small incremental batches over rewriting many notes at once

### `ask-and-archive`

Use this when the user wants an answer grounded in the wiki and may want it saved.

The sequence is:

1. call `kb_search`
2. select the most relevant 3 to 8 notes
3. call `kb_read_notes`
4. answer only from the retrieved notes
5. if the user wants the answer saved:
   - call `kb_prepare_output`
   - use the LLM to write one valid output note
   - call `kb_upsert_output`

Important:

- search before answering
- do not cite notes you did not read
- keep `source_refs` aligned with the source notes actually used

### `lint-check`

Use this when the user wants a deterministic health check of the knowledge base.

The sequence is:

1. call `kb_lint`
2. report the issues clearly
3. do not auto-fix unless the user explicitly asks
4. if asked to fix, keep the repair narrow and controlled

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

Required headings:

```md
# Summary

# Key Points

# Evidence

# Open Questions

# Related Links
```

Writing guidance:

- `Summary`: short grounded summary of the raw material
- `Key Points`: concrete takeaways
- `Evidence`: only claims supported by the raw content
- `Open Questions`: unresolved uncertainty or follow-up work
- `Related Links`: only plausible internal links or references, never invented pages

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

```md
# Answer

# Sources Used

# Follow-up Questions
```

Writing guidance:

- `Answer`: directly answer the user's question
- `Sources Used`: list only source ids actually used
- `Follow-up Questions`: note worthwhile next questions
- never fabricate `source_refs`

## Safety Boundaries

- Never modify files under `raw/`.
- Never use generic file-writing tools to modify `wiki/` directly.
- Never assume a Vault path is valid unless it came from the plugin or matches the plugin's documented read boundaries.
- Never fabricate source ids, output ids, or Vault paths.
- Never claim a compile or write succeeded unless the plugin confirms it.
- Never bypass the plugin after a tool failure.

## Failure Handling

If a plugin tool fails:

- explain the failure in plain language
- keep the user context intact
- propose the next executable step
- do not work around the error by writing directly to the Vault

## Language Policy

- Write outward-facing artifacts in English by default.
- Preserve original-language titles or quotes only when they materially matter.
- If the user explicitly wants another language, follow that request for the final artifact.

## Finish Standard

When you finish a task with this skill, report:

- what was compiled, answered, or checked
- which plugin tools were used
- which files were created or updated
- any unresolved ambiguity or weak evidence
- the best next one to three follow-up steps
