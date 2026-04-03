# Repository Layout

This skill works best when the knowledge base is easy to navigate for both humans and agents.

## Default Layout

```text
<repo>/
  raw/
    articles/
    papers/
    repos/
    datasets/
    images/
  wiki/
    index.md
    sources/
    concepts/
    maps/
    briefs/
  outputs/
    answers/
    slides/
    figures/
  queries/
    open/
    archive/
  tools/
```

## Folder Contract

- `raw/`: source-of-truth artifacts captured from the outside world. Preserve filenames, provenance, and local assets.
- `wiki/sources/`: one Markdown page per raw source. These pages summarize evidence without pretending to be the evidence.
- `wiki/concepts/`: concept pages that connect multiple source pages and accumulate durable synthesis.
- `wiki/maps/`: orienting documents such as topic maps, reading sequences, timelines, and research frontier overviews.
- `wiki/briefs/`: durable outputs that should stay in the long-term memory of the repo.
- `outputs/`: user-requested deliverables that may later be promoted into the wiki.
- `queries/open/`: queued questions, experiments, and research prompts.
- `queries/archive/`: answered, canceled, or superseded questions.
- `tools/`: local scripts or small apps that make the knowledge base easier to operate.

## Recommended Page Shapes

### Source Page

Store source pages in `wiki/sources/` with a stable slug.

Recommended sections:
- `Metadata`
- `Summary`
- `Key evidence`
- `Related concepts`
- `Open questions`

Always include:
- title
- author or organization when known
- source type
- original location
- access date

### Concept Page

Store concept pages in `wiki/concepts/`.

Recommended sections:
- `Definition`
- `Why this matters`
- `Evidence from sources`
- `Related concepts`
- `Open questions`

Concept pages should point back to multiple source pages whenever possible.

### Map Page

Store map pages in `wiki/maps/`.

Good map pages answer orientation questions such as:
- what are the core themes
- what is well understood
- what is still uncertain
- which sources are foundational

## Output Naming

Prefer date-stamped outputs for user-driven deliverables:

- `outputs/answers/2026-04-03-agent-memory-qa.md`
- `outputs/slides/2026-04-03-agent-memory-briefing.md`
- `outputs/figures/2026-04-03-retrieval-landscape.png`

Use stable names for long-lived wiki pages and changing names only for one-off outputs.

## Suggested Promotion Rule

Start in `outputs/` when the work is tied to a specific question.

Promote into `wiki/briefs/` or link from `wiki/concepts/` when the result has long-term reuse value, such as:
- a frontier overview
- a recurring comparison
- a glossary or taxonomy
- a decision memo that becomes part of the corpus

## Optional Extensions

Add folders only when there is clear repeated value. Common examples:
- `wiki/timelines/`
- `wiki/entities/`
- `wiki/methods/`
- `raw/audio/`
- `raw/video/`
- `tools/search/`

Do not create a large taxonomy on day one. Let the structure grow from real usage.
