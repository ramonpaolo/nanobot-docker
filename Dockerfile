# nanobot + webbridge-agent (all-in-one)
# https://github.com/ramonpaolo/nanobot-docker

FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=8080

# Install git for cloning repos
RUN apt-get update && apt-get install -y --no-install-recommends git && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN groupadd --gid 1000 appgroup \
    && useradd --uid 1000 --gid 1000 --shell /bin/bash --create-home appuser

WORKDIR /app

# Install nanobot, plugin, and frontend dependencies
RUN pip install --no-cache-dir \
    nanobot-ai \
    nanobot-webbridge-plugin==1.1.0 \
    fastapi \
    uvicorn[standard] \
    websockets \
    python-multipart \
    aiofiles \
    pydantic

# Clone webbridge-agent frontend (repo has src/ inside, so clone to temp then move)
RUN git clone https://github.com/ramonpaolo/webbridge-agent.git /app/bridge && \
    mv /app/bridge/src /app/src && \
    rm -rf /app/bridge

# Create .nanobot directory and set permissions
RUN mkdir -p /home/appuser/.nanobot && \
    mkdir -p /app/src/static/uploads && \
    chown -R appuser:appgroup /home/appuser /app/src/static

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Switch to non-root user
USER appuser

# Expose ports
EXPOSE 8080

# Run entrypoint
ENTRYPOINT ["/entrypoint.sh"]
