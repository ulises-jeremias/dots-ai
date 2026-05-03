---
name: dots-ai-workstation-triage
description: Workstation health triage — validate tooling, directory layout, and run dots-doctor with remediation suggestions.
metadata:
  author: dots-ai
  version: "1.0"
---

# Workstation Triage Skill

1. Validate required tooling.
2. Validate expected dots-ai directory layout.
3. Run `dots-doctor` (default) or `dots-doctor --issue` for a **Markdown block** to paste into GitHub / Slack; use `dots-doctor --json` only if automation needs a single-line summary (requires `python3`).
4. Propose remediations with lowest risk first.
