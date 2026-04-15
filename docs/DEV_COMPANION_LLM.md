# LLM Integration for Dev Companion

> How the dev-companion runner uses AI models to generate intelligent plans.

## Overview

The dev-companion runner includes a **provider-agnostic LLM layer** that automatically selects the best available AI model. By default, it uses **OpenCode with `big-pickle`** — a free, local model that works out-of-the-box for all dots-ai developers.

> [!TIP]
> Most developers need zero configuration — install OpenCode and the LLM layer works immediately with `big-pickle`.

## Provider Priority

The runner automatically selects providers in this order:

| Priority | Provider | Type | Cost | Requirements |
|----------|----------|------|------|--------------|
| 1 | **OpenCode (big-pickle)** | Local | Free | `opencode` installed |
| 2 | Ollama | Local | Free | `ollama` installed + models |
| 3 | Anthropic (Claude) | Cloud | Paid | `ANTHROPIC_API_KEY` |
| 4 | OpenAI | Cloud | Paid | `OPENAI_API_KEY` |

## Zero-Config Experience

For most developers:

1. Install OpenCode → Done
2. Run jobs → Works immediately with `big-pickle`

No API keys required. No configuration files. No setup.

## For Advanced Users

### Using Ollama (Local GPU)

```bash
# Install ollama
brew install ollama  # macOS
curl -fsSL https://ollama.com/install.sh | sh  # Linux

# Pull a model
ollama pull llama3.2

# The runner will auto-detect and use it
```

### Using Claude API

```bash
export ANTHROPIC_API_KEY="sk-ant-..."
# Runner picks this up automatically if OpenCode/Ollama unavailable
```

### Using OpenAI API

```bash
export OPENAI_API_KEY="sk-..."
# Last fallback if no free providers available
```

## How It Works

```
┌─────────────────────────────────────────────────────────────┐
│  nan_devcompanion_runner.py                                 │
│                                                              │
│  1. Reads job JSON                                          │
│  2. Initializes LLM dispatcher                              │
│  3. Dispatcher checks providers in priority order           │
│  4. First available provider is selected                    │
│  5. Prompt is built from template                          │
│  6. LLM generates plan                                      │
│  7. Artifacts written to output directory                   │
└─────────────────────────────────────────────────────────────┘
```

## Job JSON Enhancement

Add `"llm": true` to enable LLM generation (default is true):

```json
{
  "id": "my-task",
  "created_at": "2026-03-31T12:00:00Z",
  "request": "Analyze and improve error handling",
  "repo_path": "/path/to/repo",
  "llm": true,
  "limits": {
    "timeout_sec": 300
  }
}
```

## Debugging

```bash
# Enable debug logging
NAN_LLM_DEBUG=1 dots-devcompanion run-once

# Check which providers are detected
opencode --version
ollama list
```

## Artifacts Generated

When LLM generation succeeds:

- `plan.md` — Full LLM-generated plan
- `result.json` — Metadata with provider info:

```json
{
  "job_id": "my-task",
  "status": "planned_via_llm",
  "planned_at": "2026-03-31T12:01:00Z",
  "provider": "opencode",
  "model": "opencode/big-pickle",
  "duration_sec": 15.3
}
```

## Fallback Behavior

| Scenario | Behavior |
|----------|----------|
| No providers available | Generates skeleton plan |
| Provider times out | Writes error in artifacts |
| Provider returns invalid response | Falls back to skeleton |

## Extending Providers

Add new providers by implementing `LLMProvider`:

```python
from providers.base import LLMProvider, LLMResponse

class MyProvider(LLMProvider):
    name = "myprovider"
    is_local = True
    is_free = True

    def is_available(self) -> bool:
        return shutil.which("my-cli") is not None

    def get_priority(self) -> int:
        return 1  # Lower = higher priority

    def generate(self, prompt, system_prompt, repo_path, timeout_sec) -> LLMResponse:
        # Implement LLM call
        pass
```

Then register in `llm_dispatcher.py`.

## Provider Selection Logic

```python
# Simplified dispatcher logic
providers = [OpenCode(), Ollama(), Anthropic(), OpenAI()]
providers.sort(key=lambda p: p.get_priority())

for provider in providers:
    if provider.is_available():
        return provider  # Use first available
```

## FAQ

**Q: Does it work offline?**
A: Yes, if OpenCode or Ollama is installed. Cloud providers require internet.

**Q: Can I force a specific provider?**
A: Not currently. The priority order is fixed. Open an issue if you need configuration.

**Q: What's `big-pickle`?**
A: OpenCode's default model. It's optimized for code tasks and runs locally.

**Q: My job failed with timeout. What do I do?**
A: Increase `timeout_sec` in the job JSON, or check if your LLM provider is responsive.

**Q: Can I use a custom Ollama model?**
A: Set `OLLAMA_MODEL` env var, or modify `ollama_provider.py`.

---

## See Also

- [DEV_COMPANION.md](DEV_COMPANION.md) — Dev companion overview and layers
- [DEV_COMPANION_PLATFORM.md](DEV_COMPANION_PLATFORM.md) — Multi-harness platform design
- [DEV_COMPANION_RELIABILITY.md](DEV_COMPANION_RELIABILITY.md) — Reliability invariants
- [CLI_HELPERS.md](CLI_HELPERS.md) — `dots-llm-server` command reference
