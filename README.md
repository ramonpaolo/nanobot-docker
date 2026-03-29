# nanobot-docker

🚀 **Docker image for nanobot AI agent with WebBridge** — Everything you need in one stack!

Includes nanobot + nanobot-webbridge-plugin + agent-webbridge frontend.

---

## Quick Start (2 minutes)

### 1. Create `.env` file

```bash
cat > .env << EOF
# Required: LLM Provider API Key
NANOBOT_API_KEY_PROVIDER=your_llm_api_key_here

# Required: WebBridge API Key (for frontend authentication)
NANOBOT_API_KEY=your_webbridge_api_key_here

# Optional
NANOBOT_PROVIDER=minimax
NANOBOT_MODEL=minimax/MiniMax-M2.7-highspeed
NANOBOT_HMAC_SECRET=
AGENT_NAME=Nanobot
EOF
```

### 2. Run!

```bash
docker-compose up -d
```

### 3. Access the frontend

Open **http://localhost:8080**

---

## What you get

| Service | Port | Description |
|---------|------|-------------|
| **nanobot** | 18790 | Gateway API |
| **nanobot** | 18791 | WebBridge WebSocket |
| **webbridge-agent** | 8080 | Web Frontend |

---

## Environment Variables

### Required

| Variable | Description |
|----------|-------------|
| `NANOBOT_API_KEY_PROVIDER` | API key for your LLM provider (Minimax, OpenAI, etc.) |
| `NANOBOT_API_KEY` | API key for WebBridge authentication |

### Optional

| Variable | Default | Description |
|----------|---------|-------------|
| `NANOBOT_PROVIDER` | `minimax` | LLM provider name |
| `NANOBOT_MODEL` | `minimax/MiniMax-M2.7-highspeed` | Model to use |
| `NANOBOT_API_BASE` | `https://api.minimax.io/v1` | API base URL |
| `NANOBOT_HMAC_SECRET` | (empty) | HMAC secret for message signing |
| `NANOBOT_MAX_TOKENS` | `8192` | Max tokens per response |
| `NANOBOT_TEMPERATURE` | `0.1` | Temperature |
| `AGENT_NAME` | `Nanobot` | Agent display name |

---

## Examples

### Minimal Setup (Minimax)

```bash
cat > .env << EOF
NANOBOT_API_KEY_PROVIDER=your_minimax_key
NANOBOT_API_KEY=your_webbridge_key
EOF

docker-compose up -d
```

### With OpenAI

```bash
cat > .env << EOF
NANOBOT_PROVIDER=openai
NANOBOT_MODEL=gpt-4o
NANOBOT_API_BASE=https://api.openai.com/v1
NANOBOT_API_KEY_PROVIDER=your_openai_key
NANOBOT_API_KEY=your_webbridge_key
AGENT_NAME=OpenAI Bot
EOF

docker-compose up -d
```

### Custom Ports

```bash
cat > .env << EOF
NANOBOT_API_KEY_PROVIDER=your_key
NANOBOT_API_KEY=webbridge_key
NANOBOT_GATEWAY_PORT=18790
NANOBOT_WEBBRIDGE_PORT=18791
EOF

docker-compose up -d
```

---

## Standalone nanobot (without frontend)

If you only want the nanobot container:

```bash
docker run -d \
  --name nanobot \
  -p 18790:18790 \
  -p 18791:18791 \
  -e NANOBOT_API_KEY_PROVIDER=your_key \
  -e NANOBOT_API_KEY=webbridge_key \
  r4deu51/nanobot-webbridge:v0.0.7
```

---

## Image Details

| Image | Description |
|-------|-------------|
| `r4deu51/nanobot-webbridge` | nanobot + webbridge plugin |
| `r4deu51/webbridge-agent` | Web frontend |

---

## Related Projects

| Project | Description |
|---------|-------------|
| [nanobot](https://github.com/ramonpaolo/nanobot) | AI agent framework |
| [agent-webbridge](https://github.com/ramonpaolo/webbridge-agent) | Web frontend |
| [nanobot-webbridge-plugin](https://github.com/ramonpaolo/nanobot-webbridge-plugin) | Plugin for nanobot |

---

## License

MIT
