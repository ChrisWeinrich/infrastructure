# Jellyfin Runbook

## Scope

This runbook covers deploying Jellyfin on VLAN 40 and enforcing Achilles-only
access via the OpenWrt firewall.

## Prerequisites

- USB media disks are mounted at `/mnt/usb_disk_1` and `/mnt/usb_disk_2`.
- Persistent metadata directory exists at `/srv/containers/volumes/jellyfin`.
- Achilles MAC address allowlist is configured for Jellyfin access.

## Apply

1. Apply host changes (container and volumes):

   ```bash
   /Users/christianweinrich/Source/infrastructure/ansible/scripts/run_atlas.sh
   ```

2. Apply gateway changes (firewall rules):

   ```bash
   /Users/christianweinrich/Source/infrastructure/ansible/scripts/run_gateway.sh
   ```

## Verify

- From Achilles, open `http://192.168.40.3`.
- From any other client, access must be blocked.
- Media from both USB disks appears in the Jellyfin library.
- Metadata persists after a container restart.
