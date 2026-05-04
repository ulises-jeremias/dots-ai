# GitHub Integration

> GitHub repo access, issues, pull requests, and review workflows.

---

## Best path

Use `gh` for day-to-day work. Use GitHub MCP only when an AI tool needs live repository context.

## Setup

```bash
gh auth login
gh auth status
```

## What to use it for

- Create and review PRs
- Inspect issues and actions
- Let AI tools query repositories through MCP

## AI workflows

- `github-cli-workflow` for PRs and repo automation
- `gh-address-comments` for PR review comments
- `gh-fix-ci` for failing workflows

## Verify

```bash
gh auth status
dots-doctor
```

## See also

- [MCP Templates](MCP)
- [CLI Reference](CLI)
