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

## What you get

| Port | Service |
|------|---------|
| 8080 | Web Frontend ✅ |

nanobot gateway and webbridge run internally.

---

## Required

```bash
export NANOBOT_API_KEY_PROVIDER=your_llm_api_key
```

## Optional

```bash
export NANOBOT_PROVIDER=minimax
export NANOBOT_MODEL=minimax/MiniMax-M2.7-highspeed
export NANOBOT_HMAC_SECRET=
```

Then run `./setup.sh && docker-compose up -d`

---

## Manual Setup

```bash
cat > .env << EOF
NANOBOT_API_KEY_PROVIDER=your_key
NANOBOT_API_KEY=auto-generated
EOF

docker-compose up -d
```

---

## Stop

```bash
docker-compose down
```

---

## License

MIT
