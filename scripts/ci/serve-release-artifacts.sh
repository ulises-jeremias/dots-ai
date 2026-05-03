#!/usr/bin/env bash
# Serve a directory over HTTP on 127.0.0.1 so hermetic CI jobs can point the
# release installers at locally-built artifacts instead of the GitHub Releases
# URL. Bound to localhost only — never expose this on a public interface.
#
# Usage:
#   scripts/ci/serve-release-artifacts.sh <dir> <port>
#
# The PID is written to ${dir}/.http-server.pid so the caller can kill it.

set -euo pipefail

DIR="${1:?usage: serve-release-artifacts.sh <dir> <port>}"
PORT="${2:?usage: serve-release-artifacts.sh <dir> <port>}"

if [ ! -d "$DIR" ]; then
  echo "serve-release-artifacts: not a directory: $DIR" >&2
  exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "serve-release-artifacts: python3 is required" >&2
  exit 1
fi

cd "$DIR"
python3 -m http.server "$PORT" --bind 127.0.0.1 >server.log 2>&1 &
echo "$!" >.http-server.pid
disown || true

# Wait for the port to actually accept connections before returning so callers
# do not race the server (max ~10s).
for _ in $(seq 1 50); do
  if curl -fsS "http://127.0.0.1:${PORT}/" >/dev/null 2>&1; then
    echo "serve-release-artifacts: ready on http://127.0.0.1:${PORT} (pid $(cat .http-server.pid))"
    exit 0
  fi
  sleep 0.2
done

echo "serve-release-artifacts: server did not become ready on port ${PORT}" >&2
cat server.log >&2 || true
exit 1
