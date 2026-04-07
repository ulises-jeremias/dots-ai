"""
LLM dispatcher for dev-companion runner.

Automatically selects the best available LLM provider based on:
1. Priority (local/free providers preferred)
2. Availability (installed, configured, credentials)
"""

import logging
import os
from pathlib import Path
from typing import Optional

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent))

from providers import (
    LLMProvider,
    LLMResponse,
    OpenCodeProvider,
    OllamaProvider,
    AnthropicProvider,
    OpenAIProvider,
)

logger = logging.getLogger(__name__)


class LLMDispatcher:
    def __init__(self):
        self._providers: list[LLMProvider] = []
        self._selected: Optional[LLMProvider] = None
        self._initialize_providers()

    def _initialize_providers(self) -> None:
        self._providers = [
            OpenCodeProvider(),
            OllamaProvider(),
            AnthropicProvider(),
            OpenAIProvider(),
        ]
        self._providers.sort(key=lambda p: p.get_priority())

    def get_available_provider(self) -> Optional[LLMProvider]:
        for provider in self._providers:
            if provider.is_available():
                logger.info(
                    f"Selected provider: {provider.name} (model: {provider.get_model_name()})"
                )
                self._selected = provider
                return provider
        logger.warning("No LLM provider available, falling back to skeleton")
        return None

    def get_selected(self) -> Optional[LLMProvider]:
        return self._selected

    def list_providers(self) -> list[dict]:
        return [
            {
                "name": p.name,
                "model": p.get_model_name(),
                "available": p.is_available(),
                "is_local": p.is_local,
                "is_free": p.is_free,
                "priority": p.get_priority(),
            }
            for p in self._providers
        ]

    def generate(
        self,
        prompt: str,
        system_prompt: Optional[str] = None,
        repo_path: Optional[Path] = None,
        timeout_sec: int = 300,
    ) -> tuple[Optional[LLMResponse], Optional[str]]:
        provider = self.get_selected()
        if not provider:
            return None, "no_provider"

        try:
            response = provider.generate(
                prompt=prompt,
                system_prompt=system_prompt,
                repo_path=repo_path,
                timeout_sec=timeout_sec,
            )
            return response, None
        except Exception as e:
            logger.error(f"Provider {provider.name} failed: {e}")
            return None, str(e)


def create_dispatcher() -> LLMDispatcher:
    debug = os.environ.get("NAN_LLM_DEBUG", "").lower() in ("1", "true", "yes")
    if debug:
        logging.basicConfig(level=logging.DEBUG)
    return LLMDispatcher()
