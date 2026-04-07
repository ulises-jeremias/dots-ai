# Multi-agent orchestration (optional)

dots-ai Dev Companion policies are harness-agnostic; multi-agent runtimes are **optional**.

## When to use multi-agent

- Large changes spanning multiple components (backend + dbt + infra).
- Verification-heavy tasks (multiple test suites, CI parity).
- Time-boxed delivery where parallel exploration reduces risk.

## Recommended runtime: pi.dev teams (optional)

Why: file-based task store, auto-claim, messaging, worktrees, and hook/quality-gate support.

### Suggested team topology (dots-ai)

- **Lead**: one orchestrator session that routes via `dots-ai-assistant` + packs.
- **Workers (examples)**:
  - `data-validate` (dbt + snowflake validation evidence)
  - `forge-pr` (draft PR/MR + template)
  - `reviewer` (self-review checklist + security gate)
  - `docs-sync` (update docs pointers)

Workers should have **explicit boundaries** (allowed paths) derived from account packs.

### Worktree isolation

Prefer one git worktree per worker to keep edits isolated.

### Hook-based quality gates

Enable completion hooks so that “task completed” is only accepted once repo-documented checks pass.

High-level flow:

```mermaid
flowchart TB
  Lead[Lead_agent] --> Tasks[Shared_task_store]
  Tasks --> WorkerA[Worker_data]
  Tasks --> WorkerB[Worker_forge]
  Tasks --> WorkerC[Worker_review]
  WorkerA --> GateA[Quality_gates]
  WorkerB --> GateB[Quality_gates]
  WorkerC --> GateC[Quality_gates]
  GateA --> Lead
  GateB --> Lead
  GateC --> Lead
```

## Domain ownership enforcement

Enforce boundaries using **account packs**:

- Allowed repo roots (paths)
- Required tools/env vars for privileged actions
- Default automation level (plan-only unless explicitly opted in)

If a worker attempts to operate outside allowed paths, it should be rejected and escalated to the lead.
