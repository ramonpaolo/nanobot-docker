# nanobot-docker

🚀 **One container with everything!** AI agent + web interface in a single Docker image.

---

## Quick Start (30 seconds!)

### 1. Create `.env` file

```bash
cat > .env << EOF
NANOBOT_API_KEY_PROVIDER=your_llm_api_key_here
EOF
```

### 2. Run!

```bash
docker run -d \
  --name nanobot \
  -p 8080:8080 \
  --env-file .env \
  r4deu51/nanobot-webbridge:v0.0.12
```

### 3. Access

Open **http://localhost:8080**

---

## What you get

| Service | Port | Status |
|---------|------|--------|
| **Frontend** | 8080 | ✅ Exposed |
| **nanobot** | internal | ✅ Running |
| **webbridge** | internal | ✅ Running |

Everything in one container!

---

## Environment Variables

### Required

| Variable | Description |
|----------|-------------|
| `NANOBOT_API_KEY_PROVIDER` | API key for your LLM provider |

### Optional

| Variable | Default | Description |
|----------|---------|-------------|
| `NANOBOT_API_KEY` | auto-generated | API key for webbridge |
| `NANOBOT_PROVIDER` | `minimax` | LLM provider |
| `NANOBOT_MODEL` | `minimax/MiniMax-M2.7-highspeed` | Model |
| `NANOBOT_API_BASE` | `https://api.minimax.io/v1` | API base URL |
| `NANOBOT_HMAC_SECRET` | (empty) | HMAC secret |
| `NANOBOT_MAX_TOKENS` | `8192` | Max tokens |
| `NANOBOT_TEMPERATURE` | `0.1` | Temperature |
| `AGENT_NAME` | `Nanobot` | Agent display name |

---

## Examples

### With OpenAI

```bash
docker run -d \
  --name nanobot \
  -p 8080:8080 \
  -e NANOBOT_PROVIDER=openai \
  -e NANOBOT_MODEL=gpt-4o \
  -e NANOBOT_API_BASE=https://api.openai.com/v1 \
  -e NANOBOT_API_KEY_PROVIDER=your_openai_key \
  r4deu51/nanobot-webbridge:v0.0.12
```

### With Custom API Key

```bash
docker run -d \
  --name nanobot \
  -p 8080:8080 \
  -e NANOBOT_API_KEY_PROVIDER=your_key \
  -e NANOBOT_API_KEY=my_custom_key \
  r4deu51/nanobot-webbridge:v0.0.12
```

---

## Ports

Only port **8080** is exposed (frontend).

Internal ports 18790 (gateway) and 18791 (webbridge) are not accessible from outside.

---

## Stopping

```bash
docker stop nanobot
docker rm nanobot
```

---

## Image Details

- **Base**: python:3.12-slim
- **User**: Non-root (appuser)
- **Includes**: nanobot-ai + webbridge plugin + agent-webbridge

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
