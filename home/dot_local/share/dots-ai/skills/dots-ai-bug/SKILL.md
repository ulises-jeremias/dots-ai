---
name: dots-ai-bug
description: >-
  WHAT - Draft and review bugs using the dots-ai Bug Template; classifies whether an issue should be escalated to incident based on production/user impact.
---

# Bug (WHAT)

Use for defects that can be handled through the normal development workflow.

## Bug vs incident rule

Route to **`dots-ai-incident`** instead if the problem impacts production or live users now, degrades service, blocks critical business operations, creates client-reported urgency, or needs immediate response outside planning cycles.

## Default guardrails

1. Apply **`dots-ai-output-handshake`** before final output.
2. Capture reproduction steps and environment details.
3. Use **`clickup-cli`** for ClickUp writes only after approval.

## References

- `references/default-template.md` — bug template
- `references/example-search-filter-bug.md` — example bug with environment details, diagnostics, and severity assessment
- `dots-ai-incident` — when to escalate to incident
