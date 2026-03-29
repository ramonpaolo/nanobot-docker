# nanobot-docker

🚀 **One-command AI agent with web interface!** No configuration needed - it auto-generates everything.

---

## Quick Start (30 seconds!)

### 1. Run setup (generates API key automatically)

```bash
cd nanobot-docker

# Set your LLM API key
export NANOBOT_API_KEY_PROVIDER=your_llm_api_key

# Run setup (generates everything)
./setup.sh
```

### 2. Start!

```bash
docker-compose up -d
```

### 3. Access

Open **http://localhost:8080**

The frontend is already configured with the auto-generated API key!

---

## What you get

| Service | Port | Access |
|---------|------|--------|
| **Frontend** | 8080 | http://localhost:8080 ✅ |
| **nanobot** | internal | Not exposed to internet |

All connections stay local inside Docker network.

---

## Setup Script

The `setup.sh` script:
- ✅ Auto-generates a secure API key
- ✅ Creates `.env` file
- ✅ Configures everything automatically

---

## Configuration

### Required

```bash
export NANOBOT_API_KEY_PROVIDER=your_llm_api_key
```

### Optional

```bash
export NANOBOT_PROVIDER=minimax      # Provider (default: minimax)
export NANOBOT_MODEL=minimax/MiniMax-M2.7-highspeed
export NANOBOT_API_BASE=https://api.minimax.io/v1
export AGENT_NAME=Nanobot
export NANOBOT_HMAC_SECRET=          # Optional HMAC
```

Then run:
```bash
./setup.sh
docker-compose up -d
```

---

## Manual Setup

If you prefer to set the API key yourself:

```bash
# Create .env manually
cat > .env << EOF
NANOBOT_API_KEY_PROVIDER=your_llm_api_key
NANOBOT_API_KEY=your_preferred_key
NANOBOT_PROVIDER=minimax
NANOBOT_MODEL=minimax/MiniMax-M2.7-highspeed
AGENT_NAME=Nanobot
EOF

docker-compose up -d
```

---

## Docker Network Security

Only port **8080** (frontend) is exposed to the host.

Ports 18790 and 18791 (nanobot) are:
- Only accessible inside the Docker network
- Not exposed to the internet
- Not accessible from outside Docker

---

## Stopping

```bash
docker-compose down
```

To remove everything (including data):
```bash
docker-compose down -v
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
