# Quickstart: Jellyfin First Container

## Prerequisites

- Both USB media disks are attached and mounted on the host.
- The persistent metadata base path exists on the host filesystem.
- Inventory is up to date in `ansible/inventories/home/hosts.yml`.

## Apply changes

1. Run host automation (Jellyfin container, storage wiring):

   ```bash
   /Users/christianweinrich/Source/infrastructure/ansible/scripts/run_atlas.sh
   ```

2. Run gateway automation (MAC-only firewall rule):

   ```bash
   /Users/christianweinrich/Source/infrastructure/ansible/scripts/run_gateway.sh
   ```

## Verify

- From Achilles, load Jellyfin at `http://192.168.40.3`.
- From any other device, access must be blocked.
- Confirm media from both USB disks is visible and playable.
- Confirm metadata persists after container restart.
