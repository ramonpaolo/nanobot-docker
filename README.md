# nanobot-docker

🚀 **One command AI agent with web interface!** Everything in one container.

---

## Quick Start

```bash
# 1. Clone
git clone https://github.com/ramonpaolo/nanobot-docker.git
cd nanobot-docker

# 2. Set your LLM API key
export NANOBOT_API_KEY_PROVIDER=your_llm_api_key

# 3. Setup
./setup.sh

# 4. Start
docker-compose up -d
```

**Open:** http://localhost:8080

---

## Configuration

### Environment Variables

| Variable | Required | Default | Description |
|-----------|----------|---------|-------------|
| `NANOBOT_API_KEY_PROVIDER` | ✅ Yes | - | API key for your LLM provider |
| `NANOBOT_API_KEY` | No | auto-generated | API key for WebBridge (auto-generated if not set) |
| `NANOBOT_API_BASE` | No | `https://api.minimax.io/v1` | API base URL |
| `NANOBOT_PROVIDER` | No | `minimax` | Provider name (minimax, openai, etc.) |
| `NANOBOT_MODEL` | No | `minimax/MiniMax-M2.7-highspeed` | Model name |
| `NANOBOT_HMAC_SECRET` | No | - | HMAC secret for message signing |
| `AGENT_WS_URL` | No | `ws://localhost:18791` | WebSocket URL for agent-webbridge to connect |

### Frontend WebSocket URL

**Important:** The `AGENT_WS_URL` tells the frontend where to connect to the agent.

- For **docker run**: `ws://localhost:18791`
- For **docker-compose**: `ws://nanobot:18791`

Example:
```bash
docker run -d \
  --name nanobot \
  -p 8080:8080 \
  -e NANOBOT_API_KEY_PROVIDER=your_key \
  -e AGENT_WS_URL=ws://localhost:18791 \
  r4deu51/nanobot-webbridge:latest
```

---

## Ports

| Port | Service |
|------|---------|
| 8080 | Web Frontend |
| 18790 | nanobot Gateway (internal) |
| 18791 | WebBridge (internal) |

Only port **8080** is exposed to the host.

---

## Examples

### With OpenAI

```bash
export NANOBOT_API_KEY_PROVIDER=sk-xxx
export NANOBOT_PROVIDER=openai
export NANOBOT_MODEL=gpt-4o
export NANOBOT_API_BASE=https://api.openai.com/v1
export AGENT_WS_URL=ws://localhost:18791

./setup.sh && docker-compose up -d
```

### Manual Docker Run

```bash
docker run -d \
  --name nanobot \
  -p 8080:8080 \
  -e NANOBOT_API_KEY_PROVIDER=your_key \
  -e NANOBOT_API_KEY=your_webbridge_key \
  -e AGENT_WS_URL=ws://localhost:18791 \
  -e NANOBOT_PROVIDER=minimax \
  -e NANOBOT_MODEL=minimax/MiniMax-M2.7-highspeed \
  r4deu51/nanobot-webbridge:latest
```

---

## Troubleshooting

### "Error: Agent connection failed: Name or service not known"

- Set `AGENT_WS_URL=ws://localhost:18791` (for docker run)
- Or `AGENT_WS_URL=ws://nanobot:18791` (for docker-compose)

### "Error: Invalid API key"

- Make sure `NANOBOT_API_KEY` (or auto-generated) matches the frontend's API_KEY

### Browser WebSocket URL

- Connect to: `ws://localhost:8080/ws` (not `/`)

---

## Stop

```bash
docker-compose down
```

---

## License

MIT
