# Stage 1 - Build using uv
FROM python:3.11-slim AS builder
WORKDIR /app

# Install build tools only (no need for curl or bash)
RUN apt-get update && apt-get install -y build-essential && rm -rf /var/lib/apt/lists/*

# Add uv binary directly from the official container
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# Copy project files
COPY pyproject.toml uv.lock ./

# Install dependencies using uv
RUN uv venv && \
    uv pip compile pyproject.toml -o requirements.txt && \
    uv pip install -r requirements.txt

# Copy app source code
COPY app.py .


# Stage 2 - Production image
FROM python:3.11-slim
WORKDIR /app

# Copy uv and app from builder
COPY --from=builder /usr/local/bin/uv /usr/local/bin/uv
COPY --from=builder /app /app

EXPOSE 8002
HEALTHCHECK CMD curl --fail http://localhost:8002/ping || exit 1

CMD ["uv", "run", "app.py"]
