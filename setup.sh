#!/bin/bash
set -e

# Generate API_KEY if not provided
if [ -z "$NANOBOT_API_KEY" ]; then
    export NANOBOT_API_KEY=$(openssl rand -hex 16)
fi

# Create .env file
cat > .env << EOF
NANOBOT_API_KEY_PROVIDER=${NANOBOT_API_KEY_PROVIDER:-}
NANOBOT_API_KEY=${NANOBOT_API_KEY}
NANOBOT_PROVIDER=${NANOBOT_PROVIDER:-minimax}
NANOBOT_MODEL=${NANOBOT_MODEL:-minimax/MiniMax-M2.7-highspeed}
NANOBOT_API_BASE=${NANOBOT_API_BASE:-https://api.minimax.io/v1}
NANOBOT_HMAC_SECRET=${NANOBOT_HMAC_SECRET:-}
EOF

echo ""
echo "=============================================="
echo "  nanobot-docker is ready!"
echo "=============================================="
echo ""
echo "  API Key: $NANOBOT_API_KEY"
echo "  Frontend: http://localhost:8080"
echo ""
echo "  Run: docker-compose up -d"
echo "=============================================="
