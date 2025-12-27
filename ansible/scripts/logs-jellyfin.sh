#!/usr/bin/env bash
set -euo pipefail

# Show recent Jellyfin container logs over SSH.

SSH_TARGET="${SSH_TARGET:-atlas-host}"
JELLYFIN_CONTAINER="${JELLYFIN_CONTAINER:-vlan40-jellyfin}"
LOG_TAIL_LINES="${LOG_TAIL_LINES:-200}"
FOLLOW_LOGS="${FOLLOW_LOGS:-0}"

log_args=(--tail "${LOG_TAIL_LINES}")
if [[ "${FOLLOW_LOGS}" == "1" ]]; then
  log_args+=("--follow")
fi

ssh "${SSH_TARGET}" "docker logs ${log_args[*]} ${JELLYFIN_CONTAINER}"
