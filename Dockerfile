# nanobot with WebBridge and Frontend
# All-in-one AI agent with web interface
# https://github.com/ramonpaolo/nanobot-docker

FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=8080

# Create non-root user
RUN groupadd --gid 1000 appgroup \
    && useradd --uid 1000 --gid 1000 --shell /bin/bash --create-home appuser

WORKDIR /app

# Install nanobot-ai and webbridge plugin
RUN pip install --no-cache-dir \
    nanobot-ai \
    nanobot-webbridge-plugin==1.0.1 \
    git+https://github.com/ramonpaolo/agent-webbridge.git

# Create .nanobot directory
RUN mkdir -p /home/appuser/.nanobot && \
    chown -R appuser:appgroup /home/appuser

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Switch to non-root user
USER appuser

# Expose frontend port
EXPOSE 8080

# Run start script
CMD ["/start.sh"]
