---
name: dots-ai-prd
description: >-
  WHAT — Draft and review a Product Requirements Document (PRD) using the dots-ai template in ClickUp. Business-level requirements, acceptance criteria, and traceability. Does not replace the product owner. English for tickets, PRs, and client-facing text unless the user asks otherwise.
---

# PRD — Product Requirements (WHAT)

**Canonical source:** the PRD template in ClickUp (not duplicated here). See `references/clickup-urls.md`.

## Default guardrails (before any final content)

1. Apply **`dots-ai-output-handshake`**: confirm **where** the final PRD will be stored (path, Doc page, task, paste-only, etc.) and that a **human** will review. Engagements may store PRDs in different places; do not assume.
2. Then follow the steps below.

## When to use

- A feature or product increment needs a **shared agreement** on scope, users, and acceptance.
- The team must **trace** work from PRD → implementation → tests.
- An engagement uses an **Operations**-style doc hub (see the workspace pack) with linked requirements documents.

## Instructions

1. **Open the canonical page** in ClickUp and keep section headings **aligned** with the template: Objective, User flow / Personas, Entities & use cases, Acceptance criteria, Edge cases, Integrations, Timeline, Approvals.
2. For **discovery** in an existing repository, delegate repository inspection to **`dots-ai-assistant`**; cite `AGENTS.md` and test/lint commands from the project.
3. **Acceptance criteria** must be testable and in **English** for work items/PRs (match `dots-ai-workflow-generic-project`).
4. Link **stakeholder approval** to your engagement process (ClickUp lists, tasks, or client sign-off). Do not invent sign-off if not agreed.
5. If the work item lives in **ClickUp**, use **`clickup-cli`** to post a short plan comment or to attach links — do not paste the full document into a task; link the Doc or page when possible.

## What not to do

- Do not copy the full text of the ClickUp template into this skill (avoid drift; single source of truth in ClickUp).
- Do not skip **edge cases** or **integrations** when the PRD is meant for handoff to a TRD.

## References

- `dots-ai-output-handshake` — destination and review (required first for final output)
- `references/clickup-urls.md` — stable Doc URLs
- `dots-ai-workflow-generic-project` — delivery phases and ticket traceability
- `dots-ai-trd` — next step for technical design from an approved PRD
- `dots-ai-planning` — estimation and capacity before commitment
- `dots-ai-epic`, `dots-ai-user-story`, `dots-ai-task` — downstream breakdown
- `clickup-cli` — task / comment operations
