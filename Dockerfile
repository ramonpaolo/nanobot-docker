# nanobot with WebBridge plugin
# AI Agent with universal web interface
# https://github.com/ramonpaolo/nanobot-docker

FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Create non-root user
RUN groupadd --gid 1000 appgroup \
    && useradd --uid 1000 --gid 1000 --shell /bin/bash --create-home appuser

WORKDIR /app

# Install nanobot-ai and webbridge plugin
RUN pip install --no-cache-dir \
    nanobot-ai \
    nanobot-webbridge-plugin

# Create .nanobot directory
RUN mkdir -p /home/appuser/.nanobot && \
    chown -R appuser:appgroup /home/appuser

# Switch to non-root user
USER appuser

# Expose ports
EXPOSE 18790 18791

# Run nanobot gateway
CMD ["nanobot", "gateway"]
