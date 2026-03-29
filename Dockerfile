# nanobot + webbridge-agent (all-in-one)
# https://github.com/ramonpaolo/nanobot-docker

FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=8080

# Create non-root user
RUN groupadd --gid 1000 appgroup \
    && useradd --uid 1000 --gid 1000 --shell /bin/bash --create-home appuser

WORKDIR /app

# Install nanobot, plugin, and frontend dependencies
RUN pip install --no-cache-dir \
    nanobot-ai \
    nanobot-webbridge-plugin==1.0.1 \
    fastapi \
    uvicorn[standard] \
    websockets \
    python-multipart \
    aiofiles \
    pydantic

# Copy webbridge-agent frontend
COPY src/ /app/src/

# Create .nanobot directory and set permissions
RUN mkdir -p /home/appuser/.nanobot && \
    mkdir -p /app/src/static/uploads && \
    chown -R appuser:appgroup /home/appuser /app/src/static

# Switch to non-root user
USER appuser

# Expose ports
EXPOSE 18790 18791 8080

# Run both nanobot gateway and frontend
CMD nanobot gateway & sleep 2 && python -m uvicorn src.main:app --host 0.0.0.0 --port 8080
