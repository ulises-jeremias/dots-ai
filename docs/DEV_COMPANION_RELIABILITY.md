# Dev Companion reliability

This document defines reliability expectations for background and multi-agent runs.

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

- **Transient failures** (network, rate limits): retry with exponential backoff (runner-level).
- **Deterministic failures** (same error twice): stop and escalate; do not loop.
- **Missing credentials**: mark “skipped”, emit artifact, stop.

## Backlog management

- Prefer one queue per account pack, or encode `account` in job files and enforce allowlist before running.
- Implement a max queue size and “oldest first” policy to avoid starvation.

## Health checks

Provide a `doctor` command that verifies:
- skills/catalog present
- packs present
- worker executable
- systemd timer enabled (optional)
- provider key present when provider-backed mode enabled.

## Chaos testing (lightweight)

- Inject a failing job command and verify it lands in `queue/failed/`.
- Inject a long-running command and verify timeout behavior.
- Inject invalid JSON and verify it fails fast with a clear log line.
