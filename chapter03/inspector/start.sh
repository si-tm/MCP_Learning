#!/usr/bin/env bash
set -euo pipefail

echo "Starting MCP Inspector..."
python3 --version

echo "FastMCP version:"
/app/.venv/bin/python - << 'PY'
import fastmcp
print(fastmcp.__version__)
PY

echo "Launching MCP Inspector..."
exec node /app/inspector/server/build/index.js \
  --host 0.0.0.0 \
  --proxy-host 0.0.0.0 \
  -- \
  /app/.venv/bin/python \
  /app/calculator_server.py
