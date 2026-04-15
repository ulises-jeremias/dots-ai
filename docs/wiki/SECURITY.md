# Security

Security practices for dots-ai. See also [SECURITY.md](https://github.com/ulises-jeremias/dots-ai/blob/main/SECURITY.md).

## Core principles

- **Never commit credentials, tokens, private keys, or local secrets**
- Use environment variables in all examples
- MCP templates are examples — they require explicit local configuration

## Credential management

Use the opt-in env mechanism:

```bash
mkdir -p ~/.config/dots-ai/env.d
$EDITOR ~/.config/dots-ai/env.d/my-service.env
```

> [!WARNING]
> Files in `~/.config/dots-ai/env.d/` should **never** be committed to any repository. They stay local to your machine.

## CI security scanning

The repository runs automated security checks:

| Check | Tool | Frequency |
|-------|------|-----------|
| Vulnerability scan | Trivy | Every push |
| Secret detection | pre-commit `detect-private-key` | Every commit |
| Dependency updates | Dependabot | Weekly |
| Shell security | ShellCheck | Every push |

## MCP security

- MCP templates ship without credentials
- API tokens must be configured locally per provider
- Use `dots-loadenv` to manage env vars safely

## Reporting vulnerabilities

If you discover a security vulnerability, please follow the process in [SECURITY.md](https://github.com/ulises-jeremias/dots-ai/blob/main/SECURITY.md).

## See also

- [MCP Templates](MCP) — provider configuration
- [CLI Reference](CLI) — `dots-loadenv` for credential loading
