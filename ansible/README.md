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

## Guardrails

- `ansible/inventories/`: Inventory sources only (hosts, groups, host vars).
  Do not store playbooks, roles, or scripts here.
- `ansible/playbooks/`: Entry playbooks only (`site.yml`, `gateway.yml`,
  `atlas.yml`). Keep reusable tasks inside roles instead of new playbooks.
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
├── inventories/
│   └── home/
│       ├── hosts.yml
│       ├── group_vars/
│       │   ├── all.yml
│       │   ├── gateways.yml
│       │   └── hosts.yml
│       └── host_vars/
│           ├── hermes-gateway.yml
│           └── atlas-host.yml
├── roles/
│   ├── base/
│   │   ├── tasks/
│   │   ├── defaults/
│   │   └── vars/
│   ├── hermes-gateway/
│   │   ├── tasks/
│   │   │   ├── main.yml
│   │   │   ├── packages.yml
│   │   │   ├── networking.yml
│   │   │   ├── dhcp.yml
│   │   │   └── hardware.yml
│   │   ├── templates/
│   │   ├── files/
│   │   ├── defaults/
│   │   └── vars/
│   └── atlas_host/
│       ├── tasks/
│       │   ├── main.yml
│       │   ├── packages.yml
│       │   ├── docker_config.yml
│       │   ├── hardware.yml
│       │   ├── services.yml
│       │   └── containers.yml
│       ├── containers/
│       │   ├── *.yml
│       │   └── README.md
│       ├── templates/
│       ├── files/
│       ├── defaults/
│       └── vars/
├── vars/
│   └── constants.yml
├── playbooks/
│   ├── site.yml
│   ├── gateway.yml
│   └── atlas.yml
├── scripts/
│   ├── run_site.sh
│   ├── run_atlas.sh
│   ├── run_gateway.sh
│   └── run_tag.sh
├── ansible.cfg
└── requirements.yml
```

## Application-Level Layout (Atlas Host)

Application-specific configuration under the Atlas host role should be nested
under `ansible/roles/atlas_host/roles/` so it is clear what belongs to a
single application.

```text
ansible/
└── roles/
    └── atlas_host/
        └── roles/
            └── open_webui/
                ├── tasks/
                │   ├── main.yml
                │   ├── config.yml
                │   ├── prompts.yml
                │   └── mcp.yml
                ├── templates/
                ├── files/
                ├── defaults/
                └── vars/
```

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
