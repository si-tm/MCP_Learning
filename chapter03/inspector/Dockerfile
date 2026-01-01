# ---------- build stage ----------
FROM node:22-bookworm AS inspector-builder

WORKDIR /build/inspector
COPY inspector .

RUN npm install
RUN npm run build


# ---------- runtime stage ----------
FROM node:20-bookworm

RUN apt-get update && apt-get install -y \
    python3 \
    python3-venv \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY calculator_server.py /app/calculator_server.py

RUN python3 -m venv /app/.venv && \
    /app/.venv/bin/pip install --upgrade pip && \
    /app/.venv/bin/pip install fastmcp

# build 成果物だけコピー
COPY --from=inspector-builder /build/inspector /app/inspector

WORKDIR /app/inspector
RUN npm link

EXPOSE 6274 6277
ENV DANGEROUSLY_OMIT_AUTH=true

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

CMD ["/app/start.sh"]
