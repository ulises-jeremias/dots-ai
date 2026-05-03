---
name: dots-ai-trd
description: >-
  WHAT — Draft and review a Technical Requirements Document (TRD) using the dots-ai template in ClickUp, typically from an agreed PRD. Covers architecture, data contracts, technical decisions, risks, and test strategy. English for technical artifacts and tickets unless the user asks otherwise.
---

# TRD — Technical Requirements (WHAT)

**Canonical source:** the TRD template in ClickUp. See `references/clickup-urls.md`.

## Default guardrails (before any final content)

1. Apply **`dots-ai-output-handshake`**: confirm **where** the final TRD will live and that a **human** will review.
2. Then follow the steps below.

## When to use

- A **PRD is approved** (or the task is technical-only) and the team needs design-level agreement before build.
- You need **API/data contracts**, component boundaries, and **test strategy** aligned to dots-ai standards.
- A client doc hub (e.g. **Operations** with PRD/TRD cross-links) requires **matching** document structure.

## Instructions

1. **Open the canonical TRD page** in ClickUp. Align sections: Scope, Architecture overview, Data model / API contracts, Technical decisions (link **ADRs** and spikes), Dependencies, Risks & constraints, Testing strategy, Implementation plan.
2. **Map from PRD:** user stories and AC from the PRD should appear as **addressed** in the TRD with clear technical response; if no PRD exists, state that explicitly and list assumptions.
3. For **ADRs** that block or explain design, use **`dots-ai-adr`** to structure the decision, then **link** the task or ADR in ClickUp/GitHub per your engagement.
4. Delegate **repo facts** to **`dots-ai-assistant`** (conventions, CI, existing patterns); cite sources.
5. For **ClickUp** updates, use **`clickup-cli`**; keep task comments **short** with links to the Doc (per `dots-ai-workflow-generic-project`).

## What not to do

- Do not dump the full template from ClickUp into the skill (drift risk).
- Do not skip **risks** and **testing** when the TRD is a handoff artifact.

## References

- `dots-ai-output-handshake` — destination and review
- `references/clickup-urls.md` — TRD and related pages
- `dots-ai-prd` — when work starts from product requirements
- `dots-ai-spike` — research findings used as design evidence
- `dots-ai-adr` — decision records linked from the TRD
- `dots-ai-development-workflow` — validation and traceability expectations
- `dots-ai-incident` — failure handling / incident implications when relevant
- `dots-ai-workflow-generic-project` — delivery gates and traceability
- `clickup-cli` — task / comment operations
