#!/bin/bash
set -e

# Generate random API_KEY if not provided
if [ -z "$NANOBOT_API_KEY" ]; then
    NANOBOT_API_KEY=$(openssl rand -hex 16)
    echo "Generated API_KEY: $NANOBOT_API_KEY"
fi

# Generate config.json from environment variables
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
echo "  nanobot is ready!"
echo "=============================================="
echo ""
echo "  API Key: $NANOBOT_API_KEY"
echo "  Frontend: http://localhost:8080"
echo ""
echo "  (The frontend is already configured with this API_KEY)"
echo "=============================================="
echo ""

# Run nanobot gateway
exec nanobot gateway
