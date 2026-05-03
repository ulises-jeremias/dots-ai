# Credentials Setup

> How to configure API tokens and authenticate third-party tools after installing the dots-ai workstation.

This guide walks you through setting up credentials for the tools that the dots-ai AI skills and CLI helpers rely on. None of these steps require you to commit anything — all secrets stay on your local machine.

**What's covered:**

- [Atlassian API Token (JIRA + Confluence)](#1-atlassian-api-token-jira--confluence)
- [Configure JIRA](#2-configure-jira)
- [Configure Confluence](#3-configure-confluence)
- [GitHub CLI (`gh`)](#4-github-cli-gh)
- [ClickUp CLI (`clickup`)](#5-clickup-cli-clickup)

---

## 1. Atlassian API Token (JIRA + Confluence)

JIRA and Confluence share the same Atlassian account — **one token works for both**. You only need to generate it once.

### Where to get it

1. Open [https://id.atlassian.com/manage-profile/security/api-tokens](https://id.atlassian.com/manage-profile/security/api-tokens) in your browser
   _(you must be logged in with your dots-ai Atlassian account)_
2. Click **Create API token**
3. Give it a descriptive label, for example `dots-ai Workstation`
4. Click **Create**, then **copy the token** — you will **not** be able to see it again after closing the dialog

> [!CAUTION]
> Treat this token like a password. Never paste it into chat, never commit it to Git.

---

## 2. Configure JIRA

The workstation ships with an example env file that you copy and fill in.

```bash
# Copy the example to create your live JIRA config
cp ~/.config/dots-ai/env.d/jira.env.example ~/.config/dots-ai/env.d/jira.env
```

Now open it in your editor to fill in the values:

```bash
$EDITOR ~/.config/dots-ai/env.d/jira.env
```

You will see three variables — fill in each one:

```bash
export JIRA_SITE_URL="https://your-company.atlassian.net"
export JIRA_EMAIL="you@company.com"
export JIRA_API_TOKEN="your-api-token-here"
```

| Variable | What to put |
|----------|-------------|
| `JIRA_SITE_URL` | Your Atlassian workspace URL, e.g. `https://dots-ai.atlassian.net` |
| `JIRA_EMAIL` | The email address of your Atlassian account |
| `JIRA_API_TOKEN` | The token you generated in Step 1 |

Save and close the file. Open a **new terminal** (or run `source ~/.config/dots-ai/env.d/jira.env`) for the variables to take effect.

> [!TIP]
> To temporarily disable JIRA without losing your config:
> ```bash
> mv ~/.config/dots-ai/env.d/jira.env ~/.config/dots-ai/env.d/jira.env.disabled
> # Re-enable later:
> mv ~/.config/dots-ai/env.d/jira.env.disabled ~/.config/dots-ai/env.d/jira.env
> ```

---

## 3. Configure Confluence

Same process as JIRA — same Atlassian token, different env file.

```bash
# Copy the example
cp ~/.config/dots-ai/env.d/confluence.env.example ~/.config/dots-ai/env.d/confluence.env
```

Open it in your editor:

```bash
$EDITOR ~/.config/dots-ai/env.d/confluence.env
```

Fill in the three variables:

```bash
export CONFLUENCE_SITE_URL="https://your-company.atlassian.net"
export CONFLUENCE_EMAIL="you@company.com"
export CONFLUENCE_API_TOKEN="your-api-token-here"
```

Use the same values as JIRA — the Atlassian site URL, your email, and the token from Step 1.

Open a **new terminal** (or `source ~/.config/dots-ai/env.d/confluence.env`) to apply.

---

## 4. GitHub CLI (`gh`)

The GitHub CLI is used for creating pull requests, interacting with repos, and authenticating Git operations.

### Authenticate

```bash
gh auth login
```

The CLI will ask you a few questions — here is what to choose for a typical dots-ai setup:

1. **Where do you use GitHub?** → `GitHub.com`
2. **What is your preferred protocol for Git operations?** → `HTTPS` (or `SSH` if you have an SSH key set up)
3. **How would you like to authenticate?** → `Login with a web browser`
4. The terminal will print a one-time code — **copy it**
5. Press `Enter` — a browser tab opens. Paste the code and click **Authorize GitHub CLI**

### Verify

```bash
gh auth status
```

Expected output (values will differ):

```
github.com
  ✓ Logged in to github.com account your-username (keyring)
  - Active account: true
  - Git operations protocol: https
  - Token: gho_***
  - Token scopes: 'gist', 'read:org', 'repo', 'workflow'
```

If you see `✓ Logged in`, you are done.

---

## 5. ClickUp CLI (`clickup`)

The ClickUp CLI is used by the `clickup-cli` skill to manage tasks, sprints, and Docs from the terminal.

### Authenticate

```bash
clickup auth login
```

This opens a browser window where you log in to your ClickUp account and authorize the CLI. Follow the on-screen steps.

> [!TIP]
> If the browser does not open automatically, copy the URL printed in the terminal and paste it manually.

### Verify

```bash
clickup auth status
```

Expected output:

```
✓ Authenticated as Your Name (your@email.com)
  Workspace: dots-ai
```

### (Optional) Select a default space

If you work across multiple ClickUp spaces, you can pin a default:

```bash
clickup space select
```

This stores the selection in `~/.config/clickup/config.yml`. You can override it per-directory — see [MCP_TEMPLATES.md](MCP_TEMPLATES.md) for more.

---

## Summary

| Service | Config file | Command |
|---------|-------------|---------|
| JIRA | `~/.config/dots-ai/env.d/jira.env` | `source ~/.config/dots-ai/env.d/jira.env` |
| Confluence | `~/.config/dots-ai/env.d/confluence.env` | `source ~/.config/dots-ai/env.d/confluence.env` |
| GitHub | — | `gh auth login` |
| ClickUp | — | `clickup auth login` |

After configuring everything, run `dots-doctor` to verify that your workstation baseline is healthy.

---

## See Also

- [TECHNICAL_QUICKSTART.md](TECHNICAL_QUICKSTART.md) — Full engineer onboarding
- [CLI_HELPERS.md](CLI_HELPERS.md) — `dots-*` command reference
- [MCP_TEMPLATES.md](MCP_TEMPLATES.md) — MCP provider configuration (GitHub, ClickUp, Slack)
