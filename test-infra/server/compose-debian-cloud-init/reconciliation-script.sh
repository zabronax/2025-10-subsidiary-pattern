#!/bin/bash
set -e

# ------------------------
# - Repo synchronization -
# ------------------------

REPO_DIR="/srv/gitops/repo"

if [ ! -d "$REPO_DIR/.git" ]; then
    echo "[INFO] Initial clone of repo..."
    git clone --branch "${branch}" "${git_remote}" "$REPO_DIR"
else
    echo "[INFO] Syncing with remote repo..."
    git -C "$REPO_DIR" fetch origin "${branch}"
    git -C "$REPO_DIR" reset --hard "origin/${branch}"
    git -C "$REPO_DIR" clean -fd
fi

# ----------------------------
# - Docker Compose execution -
# ----------------------------

COMPOSE_FILE="$REPO_DIR/${compose_path}"
ENV_FILE="$(dirname "$COMPOSE_FILE")/.env"

COMPOSE_CMD="docker compose --file $COMPOSE_FILE"

if [ -f "$ENV_FILE" ]; then
    echo "[INFO] Using env file: $ENV_FILE"
    COMPOSE_CMD="$COMPOSE_CMD --env-file $ENV_FILE"
fi

echo "[INFO] Pulling and running Docker Compose..."
$COMPOSE_CMD pull
$COMPOSE_CMD up --detach --remove-orphans