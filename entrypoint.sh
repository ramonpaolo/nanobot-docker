#!/bin/bash
set -e

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
      "port": ${NANOBOT_WEBBRIDGE_PORT:-18791},
      "hmac_secret": "${NANOBOT_HMAC_SECRET:-}",
      "allowed_connections": [
        {
          "api_key": "${NANOBOT_API_KEY:-}",
          "ip": ${NANOBOT_ALLOWED_IP_NULL:-null}
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
    "port": ${NANOBOT_GATEWAY_PORT:-18790}
  }
}
EOF

echo "Config generated:"
cat /home/appuser/.nanobot/config.json

# Run nanobot
exec nanobot run
