# LLM Providers

Provider priority and configuration for the dev companion runner. For full details, see [docs/DEV_COMPANION_LLM.md](https://github.com/ulises-jeremias/dots-ai/blob/main/docs/DEV_COMPANION_LLM.md).

## Provider priority

The LLM layer selects providers in this order:

| Priority | Provider | Type | Speed | Cost |
|----------|----------|------|-------|------|
| 1 | OpenCode `big-pickle` | Built-in | Fast | Free |
| 2 | Ollama | Local GPU | ~26 tok/s | Free |
| 3 | Claude (Anthropic) | Cloud | Fast | Paid |
| 4 | OpenAI | Cloud | Fast | Paid |

## Zero-config setup

If OpenCode is installed, the `big-pickle` model works **out of the box** — no API keys, no GPU required.

## Local GPU setup

For machines with NVIDIA GPUs:

```bash
dots-llm-server install                # pull images + models
dots-llm-server start coding           # vLLM on port 8000
dots-llm-server start reasoning        # Ollama on port 11434
```

> [!TIP]
> Use `dots-llm-server switch` to toggle between coding and reasoning profiles.

## Cloud provider setup

Store API keys in the opt-in env mechanism:

```bash
mkdir -p ~/.config/dots-ai/env.d
$EDITOR ~/.config/dots-ai/env.d/llm.env
```

Example `llm.env`:

```bash
export ANTHROPIC_API_KEY="sk-ant-..."
export OPENAI_API_KEY="sk-..."
```

## See also

- [Dev Companion](DEV_COMPANION) — how the runner uses LLM providers
- [CLI Reference](CLI) — `dots-llm-server` subcommands
