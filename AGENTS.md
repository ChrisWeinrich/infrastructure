# infrastructure Development Guidelines

Auto-generated from all feature plans. Last updated: 2025-12-20

## Active Technologies

- YAML (Ansible playbooks) + Ansible control node, Docker Engine, Docker Compose (001-docker-vlan-nginx)
- Repo-managed YAML configs and OpenWrt UCI snapshots (001-docker-vlan-nginx)
- YAML (Ansible playbooks), shell scripts (POSIX sh/bash) + Ansible, OpenWrt UCI tooling, gekmihesg.openwrt role, pre-commit, ansible-lint, yamllin (001-ansible-layout)
- Git repository files (YAML, templates, scripts, snapshots) (001-ansible-layout)
- Ansible playbooks (YAML) and shell scripts (POSIX sh/bash) + Ansible, ansible-lint, yamllint, pre-commi (001-ansible-playbook-roles)
- Repository files (YAML, templates, scripts, docs) (001-ansible-playbook-roles)

- YAML (Ansible playbooks) + Ansible (control node), Linux mount tooling on Atlas (001-usb-disk-mount)
- USB disk partitions mounted on Atlas (001-usb-disk-mount)

- YAML (Ansible playbooks), OpenWrt UCI syntax + Ansible, gekmihesg.openwrt role, pre-commit, (001-static-ip-hostnames)
- Repository-managed configuration files (YAML) and snapshots (001-static-ip-hostnames)

- YAML (Ansible playbooks), OpenWrt UCI syntax + `gekmihesg.openwrt`\n+ role,
  OpenWrt UCI management (002-openwrt-wisp-iac)\n+- Git repository files and
  snapshots (002-openwrt-wisp-iac)
- YAML (Ansible playbooks), OpenWrt UCI syntax + Ansible, gekmihesg.openwrt role, Tailscale package (003-tailscale-router-access)
- OpenWrt UCI configuration and repo-managed YAML files (003-tailscale-router-access)

- N/A (repo-level tooling) + pre-commit, yamllint, ansible-lint, (001-repo-
  foundation)

## Project Structure

```text
src/
tests/
```

## Commands

# Add commands for N/A (repo-level tooling)

## Code Style

N/A (repo-level tooling): Follow standard conventions

## Recent Changes

- 001-ansible-playbook-roles: Added Ansible playbooks (YAML) and shell scripts (POSIX sh/bash) + Ansible, ansible-lint, yamllint, pre-commi
- 001-ansible-layout: Added YAML (Ansible playbooks), shell scripts (POSIX sh/bash) + Ansible, OpenWrt UCI tooling, gekmihesg.openwrt role, pre-commit, ansible-lint, yamllin

- 001-docker-vlan-nginx: Added YAML (Ansible playbooks) + Ansible control node, Docker Engine, Docker Compose

  `gekmihesg.openwrt` role, OpenWrt UCI management

  ansible-lint,

<!-- MANUAL ADDITIONS START -->

- OpenWrt router configuration MUST be applied via repo-managed config files;
do not mix config sync with UCI write changes in automation (UCI is read-only
for verification or emergency recovery).
<!-- MANUAL ADDITIONS END -->
