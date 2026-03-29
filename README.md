# nanobot + WebBridge

Docker image for [nanobot](https://github.com/ramonpaolo/nanobot) AI agent with [nanobot-webbridge-plugin](https://github.com/ramonpaolo/nanobot-webbridge-plugin) pre-installed.

Includes the WebBridge channel for connecting to the [agent-webbridge](https://github.com/ramonpaolo/webbridge-agent) frontend.

---

## Quick Start

### 1. Create config file

```bash
cp config.example.json config.json
```

Edit `config.json`:
- Set your `apiKey` for the LLM provider (e.g., Minimax)
- Generate and set your API key: `openssl rand -hex 16`
- Set your `hmac_secret` if desired

### 2. Run with Docker

```bash
# Build
docker build -t nanobot-webbridge .

# Run
docker run -d \
  --name nanobot \
  -p 18790:18790 \
  -p 18791:18791 \
  -v $(pwd)/config.json:/home/appuser/.nanobot/config.json:ro \
  nanobot-webbridge
```

### 3. Run the frontend

```bash
docker run -d \
  --name webbridge-agent \
  -p 8080:8080 \
  -e API_KEY=YOUR_API_KEY \
  -e AGENT_WS_URL=ws://nanobot:18791 \
  r4deu51/webbridge-agent:v0.0.1
```

Open **http://localhost:8080**

---

## Docker Compose (Recommended)

```bash
# Set environment variables
export API_KEY=your_api_key
export HMAC_SECRET=your_hmac_secret  # optional
export AGENT_NAME=Nanobot

# Start both services
docker-compose up -d
```

---

## Configuration

Edit `config.json`:

```json
{
  "channels": {
    "webbridge": {
      "enabled": true,
      "host": "0.0.0.0",
      "port": 18791,
      "hmac_secret": "",
      "allowed_connections": [
        {
          "api_key": "YOUR_API_KEY",
          "ip": null
        }
      ]
    }
  }
}
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
