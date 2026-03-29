# nanobot-docker

🚀 **Docker image for nanobot AI agent with WebBridge** — Configure everything via environment variables!

Includes nanobot + nanobot-webbridge-plugin pre-installed.

---

## Quick Start (2 minutes)

### 1. Create `.env` file

```bash
cat > .env << EOF
# Required: LLM Provider
NANOBOT_API_KEY_PROVIDER=your_llm_api_key_here
NANOBOT_PROVIDER=minimax
NANOBOT_MODEL=minimax/MiniMax-M2.7-highspeed

# Required: WebBridge
NANOBOT_API_KEY=your_webbridge_api_key_here

# Optional
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

## Environment Variables

### Required

| Variable | Description |
|----------|-------------|
| `NANOBOT_API_KEY_PROVIDER` | API key for your LLM provider (Minimax, OpenAI, etc.) |
| `NANOBOT_API_KEY` | API key for WebBridge authentication |

### LLM Provider (Optional)

| Variable | Default | Description |
|----------|---------|-------------|
| `NANOBOT_PROVIDER` | `minimax` | LLM provider name |
| `NANOBOT_MODEL` | `minimax/MiniMax-M2.7-highspeed` | Model to use |
| `NANOBOT_API_BASE` | `https://api.minimax.io/v1` | API base URL |
| `NANOBOT_MAX_TOKENS` | `8192` | Max tokens per response |
| `NANOBOT_TEMPERATURE` | `0.1` | Sampling temperature |
| `NANOBOT_CONTEXT_WINDOW` | `196000` | Context window size |

### WebBridge (Optional)

| Variable | Default | Description |
|----------|---------|-------------|
| `NANOBOT_HMAC_SECRET` | (empty) | HMAC secret for message signing |
| `NANOBOT_ALLOWED_IP_NULL` | `null` | IP whitelist (null = any IP) |
| `NANOBOT_WEBBRIDGE_PORT` | `18791` | WebBridge port |

### Ports (Optional)

| Variable | Default | Description |
|----------|---------|-------------|
| `NANOBOT_GATEWAY_PORT` | `18790` | Gateway port |

---

## Examples

### Minimal Setup (Minimax)

```bash
docker run -d \
  --name nanobot \
  -p 18790:18790 \
  -p 18791:18791 \
  -e NANOBOT_API_KEY_PROVIDER=your_minimax_key \
  -e NANOBOT_API_KEY=your_webbridge_key \
  r4deu51/nanobot-webbridge:v0.0.1
```

### With OpenAI

```bash
docker run -d \
  --name nanobot \
  -p 18790:18790 \
  -p 18791:18791 \
  -e NANOBOT_PROVIDER=openai \
  -e NANOBOT_MODEL=gpt-4o \
  -e NANOBOT_API_BASE=https://api.openai.com/v1 \
  -e NANOBOT_API_KEY_PROVIDER=your_openai_key \
  -e NANOBOT_API_KEY=your_webbridge_key \
  r4deu51/nanobot-webbridge:v0.0.1
```

### With HMAC and IP Restriction

```bash
docker run -d \
  --name nanobot \
  -p 18790:18790 \
  -p 18791:18791 \
  -e NANOBOT_API_KEY_PROVIDER=your_key \
  -e NANOBOT_API_KEY=your_webbridge_key \
  -e NANOBOT_HMAC_SECRET=secure_secret \
  -e NANOBOT_ALLOWED_IP_NULL="null" \
  r4deu51/nanobot-webbridge:v0.0.1
```

---

## Docker Compose Full Stack

```yaml
version: '3.8'

services:
  nanobot:
    image: r4deu51/nanobot-webbridge:v0.0.1
    ports:
      - "18790:18790"
      - "18791:18791"
    environment:
      - NANOBOT_PROVIDER=${NANOBOT_PROVIDER:-minimax}
      - NANOBOT_MODEL=${NANOBOT_MODEL:-minimax/MiniMax-M2.7-highspeed}
      - NANOBOT_API_KEY_PROVIDER=${NANOBOT_API_KEY_PROVIDER}
      - NANOBOT_API_KEY=${NANOBOT_API_KEY}
      - NANOBOT_HMAC_SECRET=${NANOBOT_HMAC_SECRET:-}
    restart: unless-stopped

  webbridge-agent:
    image: r4deu51/webbridge-agent:v0.0.1
    ports:
      - "8080:8080"
    environment:
      - API_KEY=${NANOBOT_API_KEY}
      - AGENT_WS_URL=ws://nanobot:18791
      - HMAC_SECRET=${NANOBOT_HMAC_SECRET:-}
    depends_on:
      - nanobot
    restart: unless-stopped
```

---

## Image Details

- **Base**: python:3.12-slim
- **User**: Non-root (appuser:appgroup)
- **Ports**:
  - `18790` — Gateway API
  - `18791` — WebBridge WebSocket

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
