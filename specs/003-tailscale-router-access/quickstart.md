# Quickstart: Tailscale Router Access

## Prerequisites

- Access to the router management interface and credentials.
- Ansible installed on the control host.
- Inventory configured under `ansible/inventory/`.

## Runbook

1. Take a snapshot before changes:

   ```bash
   ansible-playbook ansible/playbooks/snapshot-openwrt.yml \
     -i ansible/inventory/openwrt/hosts.yml
   ```

2. Apply the configuration:

   ```bash
   ansible-playbook ansible/playbooks/apply-openwrt.yml \
     -i ansible/inventory/openwrt/hosts.yml
   ```

3. Verify router state and connectivity:

   ```bash
   ansible-playbook ansible/playbooks/verify-openwrt.yml \
     -i ansible/inventory/openwrt/hosts.yml
   ```

4. From an external network, confirm access to 192.168.8.135 and at least one
   additional LAN host.

## Rollback

- Restore the previous snapshot if verification fails.
- Re-run the verify playbook after rollback to confirm restoration.
