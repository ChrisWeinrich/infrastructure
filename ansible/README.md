# Ansible Automation

This directory contains the Ansible automation for managing the OpenWrt router.

## Structure

- `inventory/`: Inventory definitions for target hosts.
- `playbooks/`: OpenWrt playbooks (apply, snapshot, verify).
- `roles/`: Reusable roles for common configuration tasks.

## Single-Source Configuration Policy

All Ansible configuration values must live in the single main YAML file at
`ansible/configs/base-config.yml`. Playbooks and documentation must reference
that file instead of duplicating hostnames, IP addresses, or MAC addresses.

## Notes

- Run from repo root so relative paths resolve correctly.
- Keep changes idempotent and safe to re-run.
- Document assumptions and cite sources when needed.

## Common Commands

```bash
ansible-playbook ansible/playbooks/verify-openwrt.yml \
  -i ansible/inventory/openwrt/hosts.yml

ansible-playbook ansible/playbooks/snapshot-openwrt.yml \
  -i ansible/inventory/openwrt/hosts.yml

ansible-playbook ansible/playbooks/apply-openwrt.yml \
  -i ansible/inventory/openwrt/hosts.yml
```
