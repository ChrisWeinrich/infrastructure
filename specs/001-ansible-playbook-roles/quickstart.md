# Quickstart: Playbook Role Refactor

## Prerequisites

- Run from repository root so relative paths resolve correctly.
- Use the inventory under `ansible/inventories/home/`.
- Ensure management access details are documented and available.

## Safe Run Order (Hermes gateway)

1. Snapshot (if not already captured):
   - `ansible-playbook ansible/playbooks/snapshot-openwrt.yml \
-i ansible/inventories/home/hosts.yml`
2. Verify connectivity:
   - `ansible-playbook ansible/playbooks/verify-openwrt.yml \
-i ansible/inventories/home/hosts.yml`
3. Apply changes:
   - `ansible-playbook ansible/playbooks/apply-openwrt.yml \
-i ansible/inventories/home/hosts.yml`

## Safe Run Order (Atlas host)

1. Apply server configuration:
   - `ansible-playbook -i ansible/inventories/home/hosts.yml \
ansible/playbooks/apply-server.yml`

## Script Entry Points

- `ansible/scripts/run_gateway.sh` runs the Hermes gateway entry playbook.
- `ansible/scripts/run_atlas.sh` runs the Atlas host entry playbook.
- `ansible/scripts/run_site.sh` runs the combined site entry playbook.
- `ansible/scripts/run_tag.sh` runs tagged tasks as a controlled subset.

## Validation

- Re-run the same playbook to confirm idempotency.
- Review output for changed tasks and confirm expected results.

## Rollback

- For OpenWrt changes, restore from the most recent snapshot if needed.
- For Atlas host changes, re-apply the last known good configuration.
