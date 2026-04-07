#!/usr/bin/env bash
set -euo pipefail

# Runtime: vLLM via Docker (nvidia-container-toolkit required)
# GPU tested: RTX 3060 12GB — model must fit in available VRAM minus display usage

LLM_SERVER_CONFIG="${HOME}/.local/share/dots-ai/llm/config.env"
LLM_SERVER_LOG="${HOME}/.local/share/dots-ai/llm/server.log"

VLLM_IMAGE="${VLLM_IMAGE:-vllm/vllm-openai:v0.19.0-cu130}"
VLLM_PORT="${VLLM_PORT:-8000}"
VLLM_MAX_MODEL_LEN="${VLLM_MAX_MODEL_LEN:-16384}"
VLLM_CONTAINER="${VLLM_CONTAINER:-vllm-server}"

# 7B AWQ fits in 12GB GPU even with display running (~4.5GB model + 4GB KV cache)
# 14B AWQ needs 9.4GB — too tight when display uses ~800MB
DEFAULT_MODEL_CODE="Qwen/Qwen2.5-Coder-7B-Instruct-AWQ"
DEFAULT_MODEL_CHAT="Qwen/Qwen2.5-Coder-7B-Instruct-AWQ"
VLLM_MODEL="${VLLM_MODEL:-${DEFAULT_MODEL_CODE}}"

_colors() {
  if [[ -t 1 && -z "${NO_COLOR:-}" ]]; then
    c_reset=$'\033[0m'
    c_blue=$'\033[1;34m'
    c_green=$'\033[1;32m'
    c_red=$'\033[1;31m'
    c_yellow=$'\033[1;33m'
  else
    c_reset='' c_blue='' c_green='' c_red='' c_yellow=''
  fi
}
_colors

log()   { printf '%b[llm-server]%b %s\n' "$c_blue" "$c_reset" "$*"; }
ok()    { printf '  %b✓%b %s\n' "$c_green" "$c_reset" "$*"; }
warn()  { printf '  %b!%b %s\n' "$c_yellow" "$c_reset" "$*"; }
fail()  { printf '  %b✗%b %s\n' "$c_red" "$c_reset" "$*"; }

llm_load_config() {
  if [[ -f "$LLM_SERVER_CONFIG" ]]; then
    set -a
    source "$LLM_SERVER_CONFIG"
    set +a
  fi
}

llm_install() {
  log "Pulling vLLM Docker image: ${VLLM_IMAGE}..."

  if ! command -v docker &>/dev/null; then
    fail "docker not found in PATH"
    return 1
  fi

  docker pull "$VLLM_IMAGE"

  mkdir -p "$(dirname "$LLM_SERVER_CONFIG")"
  cat > "$LLM_SERVER_CONFIG" <<EOF
VLLM_IMAGE=${VLLM_IMAGE}
VLLM_PORT=${VLLM_PORT}
VLLM_MAX_MODEL_LEN=${VLLM_MAX_MODEL_LEN}
VLLM_MODEL=${VLLM_MODEL}
VLLM_CONTAINER=${VLLM_CONTAINER}
DEFAULT_MODEL_CODE=${DEFAULT_MODEL_CODE}
DEFAULT_MODEL_CHAT=${DEFAULT_MODEL_CHAT}
EOF

  ok "Image pulled. Run: dots-llm-server start"
}

llm_start() {
  llm_load_config

  if llm_is_running; then
    warn "Container ${VLLM_CONTAINER} already running"
    return 0
  fi

  local model="${1:-${VLLM_MODEL}}"
  log "Starting vLLM server..."
  log "Model: ${model}"
  log "Port:  ${VLLM_PORT}"

  docker rm -f "$VLLM_CONTAINER" 2>/dev/null || true

  docker run -d --gpus all \
    --name "$VLLM_CONTAINER" \
    -v "${HOME}/.cache/huggingface:/root/.cache/huggingface" \
    -p "${VLLM_PORT}:8000" \
    --ipc=host \
    "$VLLM_IMAGE" \
    "$model" \
    --max-model-len "$VLLM_MAX_MODEL_LEN" > /dev/null

  log "Waiting for server to be ready..."
  local retries=60
  while [[ $retries -gt 0 ]]; do
    if curl -sf "http://localhost:${VLLM_PORT}/v1/models" >/dev/null 2>&1; then
      ok "Server ready"
      ok "API available at http://0.0.0.0:${VLLM_PORT}/v1"
      log "To connect from another PC:"
      log "  OLLAMA_BASE_URL=http://colibri.skypiea.local:${VLLM_PORT}/v1"
      return 0
    fi
    sleep 5
    retries=$((retries - 1))
  done

  fail "Server did not start in time"
  docker logs "$VLLM_CONTAINER" 2>&1 | tail -20
  return 1
}

llm_stop() {
  llm_load_config
  if docker ps -q --filter "name=${VLLM_CONTAINER}" | grep -q .; then
    docker stop "$VLLM_CONTAINER" >/dev/null
    ok "Server stopped"
  else
    warn "Server not running"
  fi
}

llm_status() {
  llm_load_config

  echo
  printf '%bLLM Server Status%b\n' "$c_blue" "$c_reset"
  printf '%s\n' "────────────────────"
  echo

  if llm_is_running; then
    ok "Server: RUNNING"
    printf '  URL:   http://0.0.0.0:%s/v1\n' "$VLLM_PORT"
    printf '  LAN:   http://colibri.skypiea.local:%s/v1\n' "$VLLM_PORT"
    curl -s "http://localhost:${VLLM_PORT}/v1/models" 2>/dev/null \
      | python3 -c "import json,sys; d=json.load(sys.stdin); [print('  Model: ' + m['id']) for m in d.get('data',[])]" 2>/dev/null || true
  else
    warn "Server: NOT RUNNING"
    printf '  Model: %s\n' "$VLLM_MODEL"
  fi

  printf '  Port:  %s\n' "$VLLM_PORT"
  printf '  Image: %s\n' "$VLLM_IMAGE"
  echo
}

llm_is_running() {
  docker ps -q --filter "name=${VLLM_CONTAINER}" 2>/dev/null | grep -q . && return 0
  return 1
}

llm_switch() {
  local new_model="${1:-}"
  [[ -z "$new_model" ]] && fail "Usage: llm_switch <model>" && return 1

  VLLM_MODEL="$new_model"

  mkdir -p "$(dirname "$LLM_SERVER_CONFIG")"
  cat > "$LLM_SERVER_CONFIG" <<EOF
VLLM_IMAGE=${VLLM_IMAGE}
VLLM_PORT=${VLLM_PORT}
VLLM_MAX_MODEL_LEN=${VLLM_MAX_MODEL_LEN}
VLLM_MODEL=${VLLM_MODEL}
VLLM_CONTAINER=${VLLM_CONTAINER}
DEFAULT_MODEL_CODE=${DEFAULT_MODEL_CODE}
DEFAULT_MODEL_CHAT=${DEFAULT_MODEL_CHAT}
EOF

  ok "Config updated to: ${VLLM_MODEL}"
  warn "Run 'dots-llm-server restart' to apply"
}

llm_logs() {
  llm_load_config
  if docker ps -q --filter "name=${VLLM_CONTAINER}" | grep -q .; then
    docker logs -f "$VLLM_CONTAINER"
  else
    warn "Container not running"
  fi
}
