# Maintenance Playbook

Use this playbook when the knowledge base has grown enough that structure drift starts to matter.

## When To Run A Health Check

Run a pass when:
- a large batch of sources landed
- source notes were compiled quickly and may be inconsistent
- the user reports stale or broken source references
- the wiki feels hard to trust
- answer quality is dropping because the corpus has become noisy

## Core Checks

### 1. Source Coverage

Check whether new files in `raw/` are missing corresponding pages in `wiki/sources/`.

Look for:
- unprocessed raw items
- raw files with no manifest record
- raw files with no source note
- source pages that only restate titles without substance

### 2. Source Note Validity

Check whether source notes:

- are missing required frontmatter
- are missing required headings
- have `raw_hash` values that no longer match the raw file
- live at non-canonical paths

### 3. Output Integrity

Check whether output notes:

- reference missing source ids
- cite source ids that were not actually used
- are missing required headings
- live at non-canonical paths

### 4. Index Freshness

Check whether `wiki/_indexes/` still reflects the current Vault.

Typical stale signals:

- a source note exists but does not appear in `sources.md`
- an output note exists but does not appear in `outputs.md`
- indexes are missing after a compile or archive batch

### 5. Trust And Grounding

Check whether the knowledge base is still well grounded:

- summaries that drift beyond the raw source
- evidence sections with weak or missing support
- answer notes that overstate confidence
- repeated ambiguity that should be captured as open questions

## Cleanup Strategy

Prefer small targeted passes over dramatic rewrites.

Recommended order:
1. run `kb_lint`
2. restore missing source notes or missing indexes
3. repair hash drift and bad source references
4. refresh summaries that no longer match the raw material
5. suggest the next compile or archive batch

## Improvement Ideas

Once the basics are healthy, useful next upgrades include:
- a stronger local search UI over plugin search results
- better compile prompts for different source types
- a missing-backlinks helper inside source notes
- a stale-page report based on last update dates
- higher-level workflow wrappers around `compile-changed` and `ask-and-archive`

Only build tools that remove repeated manual work for the agent.

## Deliverable Format

When reporting a health check, include:
- the highest-signal issues found
- the files that were updated
- unresolved ambiguity
- the next one to three improvement steps
