# Maintenance Playbook

Use this playbook when the knowledge base has grown enough that quality drift starts to matter.

## When To Run A Health Check

Run a pass when:
- a large batch of sources landed
- several new concept pages were created quickly
- the user reports contradictory notes
- the wiki feels hard to navigate
- answer quality is dropping because the corpus has become noisy

## Core Checks

### 1. Source Coverage

Check whether new files in `raw/` are missing corresponding pages in `wiki/sources/`.

Look for:
- unprocessed raw items
- missing provenance
- source pages that only restate titles without substance

### 2. Concept Integrity

Check whether concept pages:
- merge unrelated ideas under one name
- split the same concept across multiple names
- cite too few source pages
- make unsupported claims

### 3. Backlink Integrity

Check for:
- source pages with no links into the wiki
- concept pages with no inbound links
- map pages that point to renamed or missing files

### 4. Map Freshness

Check whether `wiki/maps/` still reflects the current corpus.

Typical stale signals:
- major themes missing from the overview
- new sources added without any update to the maps
- outdated reading order or frontier framing

### 5. Output Capture

Check whether useful answers in `outputs/` should be promoted into the wiki.

Good promotion candidates:
- repeated answers to similar questions
- stable comparisons
- concise explainers
- generated figures that clarify recurring ideas

### 6. Gap Filling

Look for missing but valuable knowledge:
- empty metadata fields
- unnamed entities that recur across sources
- unexplained terminology
- thin concept pages that deserve more source coverage

If web research is used to fill a gap, record the exact source and access date.

## Cleanup Strategy

Prefer small targeted passes over dramatic rewrites.

Recommended order:
1. restore provenance
2. repair broken links and orphans
3. merge or rename duplicate concepts
4. update map pages
5. promote durable outputs
6. suggest the next source batch or question batch

## Improvement Ideas

Once the basics are healthy, useful next upgrades include:
- a simple local search CLI over `wiki/`
- an index file for concepts and source coverage
- a query queue that tracks question status
- a missing-backlinks checker
- a stale-page report based on last update dates

Only build tools that remove repeated manual work for the agent.

## Deliverable Format

When reporting a health check, include:
- the highest-signal issues found
- the files that were updated
- unresolved ambiguity
- the next one to three improvement steps
