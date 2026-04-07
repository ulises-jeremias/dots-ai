#!/usr/bin/env bash
set -euo pipefail

## llm-server.sh
##
## Shared functions for LLM server management using vLLM.
##
## Usage:
##     source "$HOME/.local/lib/dots-ai/llm-server.sh"
##     llm_server_install
##     llm_server_start
##

LLM_SERVER_VENV="${HOME}/.local/share/dots-ai/llm-venv"
LLM_SERVER_CONFIG="${HOME}/.local/share/dots-ai/llm/config.env"
LLM_SERVER_LOG="${HOME}/.local/share/dots-ai/llm/server.log"
LLM_SERVER_PID="${HOME}/.local/share/dots-ai/llm/server.pid"
LLM_SERVER_PORT="${VLLM_PORT:-8000}"
LLM_SERVER_HOST="${VLLM_HOST:-0.0.0.0}"

DEFAULT_MODEL_CODE="Qwen/Qwen3-Coder-Next-AWQ-4bit"
DEFAULT_MODEL_CHAT="Qwen/Qwen3-Next-80B-A3B-Instruct-AWQ-4bit"
ACTIVE_MODEL="${ACTIVE_MODEL:-${DEFAULT_MODEL_CODE}}"

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

llm_venv_activate() {
  if [[ -f "${LLM_SERVER_VENV}/bin/activate" ]]; then
    source "${LLM_SERVER_VENV}/bin/activate"
  else
    fail "venv not found at ${LLM_SERVER_VENV}"
    fail "Run: dots-llm-server install"
    return 1
  fi
}

llm_install() {
  log "Installing vLLM with uv..."

  uv venv --python 3.12 --seed --managed-python "$LLM_SERVER_VENV"
  local venv_python="${LLM_SERVER_VENV}/bin/python"
  if [[ ! -x "$venv_python" ]]; then
    fail "Failed to create venv"
    return 1
  fi

  log "Installing vllm package..."
  uv pip install vllm --torch-backend=auto

  log "Downloading default model: ${ACTIVE_MODEL}..."
  "$venv_python" -m vllm serve "$ACTIVE_MODEL" --download-dir "${HOME}/.cache/huggingface" 2>/dev/null &
  local download_pid=$!
  sleep 5
  kill "$download_pid" 2>/dev/null || true

  mkdir -p "$(dirname "$LLM_SERVER_CONFIG")"
  cat > "$LLM_SERVER_CONFIG" <<EOF
VLLM_PORT=${LLM_SERVER_PORT}
VLLM_HOST=${LLM_SERVER_HOST}
ACTIVE_MODEL=${ACTIVE_MODEL}
DEFAULT_MODEL_CODE=${DEFAULT_MODEL_CODE}
DEFAULT_MODEL_CHAT=${DEFAULT_MODEL_CHAT}
HF_TOKEN=
EOF

  ok "Installation complete"
  ok "Model downloaded: ${ACTIVE_MODEL}"
}

llm_start() {
  llm_load_config
  llm_venv_activate

  if llm_is_running; then
    warn "Server already running on port ${LLM_SERVER_PORT}"
    return 0
  fi

  local model="${1:-${ACTIVE_MODEL}}"
  log "Starting vLLM server..."
  log "Model: ${model}"
  log "Host: ${LLM_SERVER_HOST}:${LLM_SERVER_PORT}"

  nohup vllm serve "$model" \
    --dtype half \
    --host "$LLM_SERVER_HOST" \
    --port "$LLM_SERVER_PORT" \
    --api-key "not-required" \
    > "$LLM_SERVER_LOG" 2>&1 &

  local server_pid=$!
  echo "$server_pid" > "$LLM_SERVER_PID"

  sleep 3
  if kill -0 "$server_pid" 2>/dev/null; then
    ok "Server started (PID: ${server_pid})"
    ok "API available at http://${LLM_SERVER_HOST}:${LLM_SERVER_PORT}/v1"
    log "To connect from another PC:"
    log "  export OLLAMA_BASE_URL=http://${LLM_SERVER_HOST}:${LLM_SERVER_PORT}/v1"
  else
    fail "Server failed to start"
    cat "$LLM_SERVER_LOG" | tail -20
    return 1
  fi
}

llm_stop() {
  if [[ -f "$LLM_SERVER_PID" ]]; then
    local pid
    pid="$(cat "$LLM_SERVER_PID")"
    if kill -0 "$pid" 2>/dev/null; then
      log "Stopping server (PID: ${pid})..."
      kill "$pid"
      sleep 2
      ok "Server stopped"
    fi
    rm -f "$LLM_SERVER_PID"
  else
    warn "No PID file found"
  fi

  pkill -f "vllm serve" 2>/dev/null || true
}

llm_status() {
  llm_load_config

  echo
  printf '%bLLM Server Status%b\n' "$c_blue" "$c_reset"
  printf '%s\n' "────────────────────"
  echo

  if llm_is_running; then
    ok "Server: RUNNING"
    printf '  URL:    http://%s:%s/v1\n' "$LLM_SERVER_HOST" "$LLM_SERVER_PORT"
  else
    warn "Server: NOT RUNNING"
  fi

  printf '  Model:  %s\n' "$ACTIVE_MODEL"
  printf '  Port:   %s\n' "$LLM_SERVER_PORT"
  printf '  Host:   %s\n' "$LLM_SERVER_HOST"
  echo

  if [[ -f "$LLM_SERVER_LOG" ]]; then
    printf '%bRecent logs:%b\n' "$c_blue" "$c_reset"
    tail -10 "$LLM_SERVER_LOG" 2>/dev/null | sed 's/^/  /'
  fi
}

llm_is_running() {
  if [[ -f "$LLM_SERVER_PID" ]]; then
    local pid
    pid="$(cat "$LLM_SERVER_PID")"
    kill -0 "$pid" 2>/dev/null && return 0
  fi

  if command -v ss &>/dev/null; then
    ss -tlnp 2>/dev/null | grep -q ":${LLM_SERVER_PORT} " && return 0
  elif command -v netstat &>/dev/null; then
    netstat -tlnp 2>/dev/null | grep -q ":${LLM_SERVER_PORT} " && return 0
  fi

  return 1
}

llm_switch() {
  local new_model="${1:-}"
  [[ -z "$new_model" ]] && fail "Usage: llm_switch <model>" && return 1

  if llm_is_running; then
    warn "Server running. Stopping first..."
    llm_stop
  fi

  ACTIVE_MODEL="$new_model"

  mkdir -p "$(dirname "$LLM_SERVER_CONFIG")"
  cat > "$LLM_SERVER_CONFIG" <<EOF
VLLM_PORT=${LLM_SERVER_PORT}
VLLM_HOST=${LLM_SERVER_HOST}
ACTIVE_MODEL=${ACTIVE_MODEL}
DEFAULT_MODEL_CODE=${DEFAULT_MODEL_CODE}
DEFAULT_MODEL_CHAT=${DEFAULT_MODEL_CHAT}
HF_TOKEN=
EOF

  ok "Switched to model: ${ACTIVE_MODEL}"
}

llm_logs() {
  if [[ -f "$LLM_SERVER_LOG" ]]; then
    tail -f "$LLM_SERVER_LOG"
  else
    warn "No log file found"
  fi
}