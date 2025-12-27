#!/usr/bin/env bash
set -euo pipefail

# Restart the Jellyfin container over SSH.

SSH_TARGET="${SSH_TARGET:-atlas-host}"
JELLYFIN_CONTAINER="${JELLYFIN_CONTAINER:-vlan40-jellyfin}"

ssh "${SSH_TARGET}" "docker restart ${JELLYFIN_CONTAINER}"
