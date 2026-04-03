# Repository Layout

This skill works best when the knowledge base stays easy to navigate for both humans and agents, and when the plugin has a stable place for controlled reads and writes.

## Default Layout

```text
<vault>/
  raw/
    inbox/
    web/
    notes/
    papers/
    repos/
    datasets/
    images/
  wiki/
    sources/
    outputs/
    _indexes/
  .llm-kb/
    manifest.json
    runs.jsonl
```

## Folder Contract

- `raw/`: source-of-truth artifacts captured from the outside world. Preserve filenames, provenance, and local assets. Plugin 1.0 only compiles `.md` and `.txt`.
- `wiki/sources/`: one Markdown source note per raw source, written only through the plugin.
- `wiki/outputs/`: archived answer notes written only through the plugin.
- `wiki/_indexes/`: plugin-generated index notes such as sources and outputs.
- `.llm-kb/manifest.json`: canonical mapping of raw files to source notes and hashes.
- `.llm-kb/runs.jsonl`: lightweight run log for audit and debugging.

## Recommended Page Shapes

### Source Page

Store source pages in `wiki/sources/` with the plugin-issued `doc_id`.

Recommended sections:
- `Summary`
- `Key Points`
- `Evidence`
- `Open Questions`
- `Related Links`

Always include plugin-required frontmatter:
- `id`
- `type: source`
- `title`
- `raw_path`
- `raw_hash`
- `source_kind`
- `created_at`
- `updated_at`
- `status`

### Output Page

Store archived answer notes in `wiki/outputs/`.

Recommended sections:
- `Answer`
- `Sources Used`
- `Follow-up Questions`

Always include plugin-required frontmatter:
- `id`
- `type: output`
- `title`
- `query`
- `source_refs`
- `created_at`
- `updated_at`

## Output Naming

Plugin 1.0 uses date-stamped output notes:

- `wiki/outputs/2026-04-03-agent-memory-qa.md`
- `wiki/outputs/2026-04-03-retrieval-vs-memory.md`

Source notes use canonical ids:

- `wiki/sources/src-agent-memory-systems.md`
- `wiki/sources/src-example-note.md`

## Suggested Growth Rule

Start with the minimal plugin-backed structure.

Only add extra top-level folders when repeated real usage justifies them. In particular:

- do not add concept pages, maps, briefs, or query queues by default in Plugin 1.0
- do not create a large taxonomy up front
- let structure grow after the source-note and output-note loop is healthy

## Optional Extensions

If the corpus grows, later extensions may include:

- `wiki/briefs/`
- `wiki/maps/`
- `wiki/entities/`
- `raw/audio/`
- `raw/video/`
- helper tools around plugin workflows

Treat those as future layers, not part of the default 1.0 contract.
