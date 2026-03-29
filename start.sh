#!/bin/bash
set -e

# Generate config.json from environment variables
if [ -z "$NANOBOT_API_KEY" ]; then
    NANOBOT_API_KEY=$(openssl rand -hex 16)
fi

cat > /home/appuser/.nanobot/config.json << EOF
{
  "agents": {
    "defaults": {
      "workspace": "~/.nanobot/workspace",
      "model": "${NANOBOT_MODEL:-minimax/MiniMax-M2.7-highspeed}",
      "provider": "${NANOBOT_PROVIDER:-minimax}",
      "maxTokens": ${NANOBOT_MAX_TOKENS:-8192},
      "contextWindowTokens": ${NANOBOT_CONTEXT_WINDOW:-196000},
      "temperature": ${NANOBOT_TEMPERATURE:-0.1},
      "maxToolIterations": ${NANOBOT_MAX_TOOL_ITERATIONS:-40}
    }
  },
  "channels": {
    "webbridge": {
      "enabled": true,
      "host": "0.0.0.0",
      "port": 18791,
      "hmac_secret": "${NANOBOT_HMAC_SECRET:-}",
      "allowed_connections": [
        {
          "api_key": "${NANOBOT_API_KEY}",
          "ip": null
        }
      ]
    }
  },
  "providers": {
    "${NANOBOT_PROVIDER:-minimax}": {
      "apiKey": "${NANOBOT_API_KEY_PROVIDER:-}",
      "apiBase": "${NANOBOT_API_BASE:-https://api.minimax.io/v1}"
    }
  },
  "gateway": {
    "host": "0.0.0.0",
    "port": 18790
  }
}
EOF

echo "=============================================="
echo "  nanobot-docker is ready!"
echo "=============================================="
echo ""
echo "  API Key: $NANOBOT_API_KEY"
echo "  Frontend: http://localhost:8080"
echo ""
echo "=============================================="

# Install webbridge-agent
pip install --no-cache-dir git+https://github.com/ramonpaolo/webbridge-agent.git

# Start nanobot in background
echo "Starting nanobot..."
nanobot gateway &
NANOBOT_PID=$!

# Wait a moment for nanobot to start
sleep 2

# Start webbridge-agent in background
echo "Starting webbridge-agent..."
cd /app
uvicorn src.main:app --host 0.0.0.0 --port 8080 &
WEBBRIDGE_PID=$!

echo ""
echo "  nanobot PID: $NANOBOT_PID"
echo "  webbridge-agent PID: $WEBBRIDGE_PID"
echo ""

# Wait for both processes
wait $NANOBOT_PID $WEBBRIDGE_PID
