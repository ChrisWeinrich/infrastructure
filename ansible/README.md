# Ansible Automation

This directory contains the Ansible automation for managing the OpenWrt router
and server hosts (including Atlas).

## Structure

- `inventories/`: Inventory definitions for target hosts.
- `playbooks/`: OpenWrt playbooks (apply, snapshot, verify).
- `roles/`: Reusable roles for common configuration tasks.
- `scripts/`: Standard entry points for running automation.
- `vars/`: Shared variables and constants.

## Canonical Layout

This repository standardizes on the canonical Ansible layout documented in
`/specs/001-ansible-layout/` and mirrored under `ansible/`. All automation
assets should live beneath this directory and follow the layout contract.

## Container Run Scripts

For each container definition in
`ansible/roles/atlas_host/containers/<name>.yml`, create a matching run script
named `ansible/scripts/run_container_<name>.sh`.

## Notes

- Run from repo root so relative paths resolve correctly.
- Keep changes idempotent and safe to re-run.
- Document assumptions and cite sources when needed.
- Store the Tailscale auth key in dcli at
  `openwrt/mt6000/tailscale/auth_key` and retrieve it on the control host
  with `dcli p --output console title=openwrt/mt6000/tailscale/auth_key`.

## Common Commands

```bash
# Apply server configuration to Atlas
ansible-playbook -i ansible/inventories/home/hosts.yml \
  ansible/playbooks/apply-server.yml

# Hello-world connectivity check
ansible-playbook ansible/playbooks/verify-openwrt.yml \
  -i ansible/inventories/home/hosts.yml

# Snapshot is only needed once at the beginning
ansible-playbook ansible/playbooks/snapshot-openwrt.yml \
  -i ansible/inventories/home/hosts.yml

# Apply automatically captures a snapshot before changes
ansible-playbook ansible/playbooks/apply-openwrt.yml \
  -i ansible/inventories/home/hosts.yml
```
