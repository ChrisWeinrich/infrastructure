# Ansible Automation

This directory contains the Ansible automation for managing the OpenWrt router
and server hosts (including Atlas).

## Structure

- `inventories/`: Inventory definitions for target hosts.
- `playbooks/`: OpenWrt and host playbooks (apply, verify).
- `roles/`: Reusable roles for common configuration tasks.
- `scripts/`: Standard entry points for running automation.
- `vars/`: Shared variables and constants.

## Canonical Layout

This repository standardizes on the canonical Ansible layout documented in
`/specs/001-ansible-layout/` and mirrored under `ansible/`. All automation
assets should live beneath this directory and follow the layout contract.

## Guardrails

- `ansible/inventories/`: Inventory sources only (hosts, groups, host vars).
  Do not store playbooks, roles, or scripts here.
- `ansible/playbooks/`: Entry playbooks only (apply/verify). Keep reusable
  tasks inside roles instead of new playbooks.
- `ansible/roles/`: All reusable automation logic lives here. Role-specific
  assets stay under each role (`tasks/`, `templates/`, `files/`, `defaults/`,
  `vars/`).
- `ansible/roles/<role>/tasks/`: Task files only. Split by concern (packages,
  networking, hardware, services, containers).
- `ansible/roles/<role>/templates/`: Jinja templates only. No static files.
- `ansible/roles/<role>/files/`: Static files only. No templates or vars.
- `ansible/roles/<role>/defaults/`: Role defaults only (safe, overridable).
- `ansible/roles/<role>/vars/`: Role vars only (fixed, non-overridable).
- `ansible/vars/`: Shared constants used across roles and playbooks.
  Do not duplicate per-role vars here.
- `ansible/scripts/`: Execution entry points only (`run_*.sh`). No Ansible
  content or configuration here.
- `ansible/ansible.cfg` and `ansible/requirements.yml`: Ansible runtime
  config and role/collection dependencies only.

```text
ansible/
├── configs/
│   └── network.yml
├── inventories/
│   └── home/
│       ├── hosts.yml
│       ├── group_vars/
│       │   ├── all.yml
│       │   └── openwrt.yml
│       └── host_vars/
│           └── atlas-host.yml
├── roles/
│   ├── openwrt/
│   │   ├── tailscale/
│   │   └── uci/
│   ├── host/
│   │   ├── docker/
│   │   │   ├── compose/
│   │   │   ├── container/
│   │   │   ├── install/
│   │   │   └── vlan/
│   │   ├── hardware/
│   │   │   └── usb-drives/
│   │   └── network/
│   │       └── vlan/
│   └── apps/
│       ├── alpine/
│       └── nginx/
├── playbooks/
│   ├── apply-openwrt.yml
│   ├── apply-server.yml
│   └── verify-openwrt.yml
├── scripts/
│   ├── run_atlas.sh
│   └── run_gateway.sh
├── ansible.cfg
└── requirements.yml
```

## Application-Level Layout (Atlas Host)

Application-specific configuration should live under `ansible/roles/apps/`
so IaC (config/model files) is separated from runtime (docker/compose).

```text
ansible/
└── roles/
    └── apps/
        └── open_webui/
            ├── tasks/
            │   ├── pre.yml
            │   └── post.yml
            ├── templates/
            ├── files/
            ├── defaults/
            └── vars/
```

## Container Run Scripts

Compose templates live with each app under
`ansible/roles/apps/<app>/templates/compose.yml.j2` and are applied via the
`host/docker/compose` role.

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

# Verify OpenWrt connectivity
ansible-playbook ansible/playbooks/verify-openwrt.yml \
  -i ansible/inventories/home/hosts.yml

# Apply OpenWrt changes (includes snapshot + verify steps)
ansible-playbook ansible/playbooks/apply-openwrt.yml \
  -i ansible/inventories/home/hosts.yml
```
