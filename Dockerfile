# nanobot with WebBridge plugin
# AI Agent with universal web interface
# https://github.com/ramonpaolo/nanobot

FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Create non-root user
RUN groupadd --gid 1000 appgroup \
    && useradd --uid 1000 --gid 1000 --shell /bin/bash --create-home appuser

WORKDIR /app

# Install nanobot and webbridge plugin
RUN pip install --no-cache-dir \
    nanobot \
    nanobot-webbridge-plugin

# Create .nanobot directory for config
RUN mkdir -p /home/appuser/.nanobot && \
    chown -R appuser:appgroup /home/appuser

# Switch to non-root user
USER appuser

# Default config with webbridge enabled (can be overridden via volume)
CMD ["nanobot", "run"]
