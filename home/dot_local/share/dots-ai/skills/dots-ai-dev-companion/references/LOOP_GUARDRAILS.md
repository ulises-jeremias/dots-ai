# Autonomous loop guardrails (dots-ai distilled)

Distilled from operational patterns (including ideas aligned with upstream “loop operator” style agents). Use when running **optional** background workers or multi-step agent loops—not for normal interactive IDE sessions.

## Preconditions

- Explicit **stop conditions** (time budget, max iterations, or single task completion).
- **Rollback path**: branch or worktree isolation; never force-push shared defaults.
- **Quality gate**: repo-documented tests or checks before treating work as done.

## During execution

- **Checkpoints**: after each major step, record what changed and what is next.
- **Stall detection**: if two consecutive checkpoints show no progress, stop and surface to the user.
- **Retry storms**: cap retries; identical stack traces twice → escalate, do not loop blindly.

## Escalate (stop and ask human)

- Cost or token use outside an agreed window (if API-backed).
- Merge conflicts blocking the queue.
- Missing credentials for Snowflake/dbt or any “cannot verify” boundary from HOW skills.

## Related verbatim reference

After `chezmoi apply`, see `~/.local/share/dots-ai/third-party/everything-claude-code/agents/loop-operator.md` (MIT; **`NOTICE.md`** in that directory). In the **dots-ai** git checkout, the same files live under `home/dot_local/share/dots-ai/third-party/everything-claude-code/`.
