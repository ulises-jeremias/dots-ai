---
name: dots-ai-work-item
description: >-
  WHAT - Router for creating and refining epics, user stories, tasks, bugs, and incidents using dots-ai Best Practices work item hierarchy.
---

# Work Item Router (WHAT)

Use this skill when the user asks to create, refine, or evaluate work items.

## Default guardrails

1. Apply **`dots-ai-output-handshake`** before producing final content or writing to a tool.
2. Use the smallest applicable skill:
   - Epic -> `dots-ai-epic`
   - User story -> `dots-ai-user-story`
   - Technical task -> `dots-ai-task`
   - Bug -> `dots-ai-bug`
   - Incident -> `dots-ai-incident`
3. Use **`dots-ai-planning`** when the item needs breakdown, estimation, prioritization, or capacity checks.
4. Use **`clickup-cli`** for ClickUp writes only after user approval.

## Hierarchy

Epic -> Story/Task/Bug -> Subtasks. Not every methodology uses every level; follow the engagement pack and ticket system.

## References

- `references/clickup-urls.md`
- `references/default-template.md`
