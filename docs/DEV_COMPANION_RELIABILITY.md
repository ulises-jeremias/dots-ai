# Dev Companion Reliability

This document defines reliability expectations for background and multi-agent runs.

> [!IMPORTANT]
> These invariants apply to **all** background and multi-agent execution — both the `dots-devcompanion` queue runner and any multi-agent runtime (e.g. pi.dev teams). Violations should be treated as bugs.

## Invariants (must hold)

1. **Single-flight** per machine per queue (lock) to avoid overlapping runs.
2. **Bounded** execution for every job:
   - max wall time
   - max steps/iterations (runner-level)
   - optional max cost budget (provider-level)
3. **Resumable**:
   - runner writes checkpoints/state so jobs can resume or fail fast deterministically.
4. **Observable**:
   - logs + artifacts per job
   - clear failure reason and next action.
5. **Safe defaults**:
   - plan-only unless explicitly allowed by job + pack
   - no auto-merge to shared defaults
   - no cross-account path access.

## Failure policy

> [!WARNING]
> Deterministic failures (same error twice) must **stop and escalate** immediately. Retrying a deterministic failure wastes resources and risks data corruption.

- **Transient failures** (network, rate limits): retry with exponential backoff (runner-level).
- **Deterministic failures** (same error twice): stop and escalate; do not loop.
- **Missing credentials**: mark “skipped”, emit artifact, stop.

## Backlog management

- Prefer one queue per account pack, or encode `account` in job files and enforce allowlist before running.
- Implement a max queue size and “oldest first” policy to avoid starvation.

## Health checks

> [!TIP]
> Run `dots-doctor` to verify your workstation meets all requirements. It covers skill catalog, packs, worker, and provider key checks.

Provide a `doctor` command that verifies:
- skills/catalog present
- packs present
- worker executable
- systemd timer enabled (optional)
- provider key present when provider-backed mode enabled.

## Chaos testing (lightweight)

> [!CAUTION]
> Run chaos tests in an **isolated queue directory** — never against the active production queue.

- Inject a failing job command and verify it lands in `queue/failed/`.
- Inject a long-running command and verify timeout behavior.
- Inject invalid JSON and verify it fails fast with a clear log line.

---

## See Also

- [DEV_COMPANION.md](DEV_COMPANION.md) — Dev companion layers and architecture
- [DEV_COMPANION_LLM.md](DEV_COMPANION_LLM.md) — LLM provider integration
- [DEV_COMPANION_PLATFORM.md](DEV_COMPANION_PLATFORM.md) — Platform architecture and packs
- [MULTI_AGENT_ORCHESTRATION.md](MULTI_AGENT_ORCHESTRATION.md) — Multi-agent runtime policies
- [wiki/CLI.md](wiki/CLI.md) — `dots-devcompanion` CLI reference
