# Ansible Automation

This directory contains the Ansible automation for managing the OpenWrt router.

## Structure

- `inventory/`: Inventory definitions for target hosts.
- `playbooks/`: OpenWrt playbooks (apply, snapshot, verify).
- `roles/`: Reusable roles for common configuration tasks.

## Notes

- Run from repo root so relative paths resolve correctly.
- Keep changes idempotent and safe to re-run.
- Document assumptions and cite sources when needed.
- Store the Tailscale auth key in dcli at
  `openwrt/mt6000/tailscale/auth_key` and retrieve it on the control host
  with `dcli p --output console title=openwrt/mt6000/tailscale/auth_key`.

## Common Commands

```bash
# Hello-world connectivity check
ansible-playbook ansible/playbooks/verify-openwrt.yml \
  -i ansible/inventory/openwrt/hosts.yml

# Snapshot is only needed once at the beginning
ansible-playbook ansible/playbooks/snapshot-openwrt.yml \
  -i ansible/inventory/openwrt/hosts.yml

# Apply automatically captures a snapshot before changes
ansible-playbook ansible/playbooks/apply-openwrt.yml \
  -i ansible/inventory/openwrt/hosts.yml
```
