# ECC patterns (reference only)

`everything-claude-code` is used as a **pattern library**, not a dependency.

## What we borrow conceptually

- Loop guardrails: checkpoints, stall detection, retry caps, and explicit escalation.
- Hooks-as-quality-gates: deterministic checks on task completion.
- Configuration-driven orchestration: keep policy in files; keep runtime pluggable.

## What we vendored (bounded)

We intentionally vendor only a **tiny** subset (MIT) for reference:

- `~/.local/share/dots-ai/third-party/everything-claude-code/NOTICE.md`
- `~/.local/share/dots-ai/third-party/everything-claude-code/agents/loop-operator.md`
- `~/.local/share/dots-ai/third-party/everything-claude-code/rules/common/security.md`

## What we avoid

- Vendoring the entire plugin (maintenance + harness mismatch).
- Depending on ECC install flows to use dots-ai policies.

## Attribution

Small verbatim excerpts (MIT) are kept under:

`~/.local/share/dots-ai/third-party/everything-claude-code/`

See `NOTICE.md` in that directory.
