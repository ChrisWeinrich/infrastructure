# Implementation Plan: Atlas Host Container VLAN

**Branch**: `001-docker-vlan-nginx` | **Date**: 2025-12-24 | **Spec**:
`/Users/christianweinrich/Source/infrastructure/specs/001-docker-vlan-nginx/spec.md`
**Input**: Feature specification from
`/Users/christianweinrich/Source/infrastructure/specs/001-docker-vlan-nginx/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See
`.codex/prompts/speckit.plan.md` for the execution workflow.

## Summary

Provision Docker and Docker Compose on atlas-host, configure VLAN 40
(192.168.40.0/24), deploy a hello world nginx container on that isolated
network, and update OpenWrt routing/firewall/DNS so the service is reachable
from 192.168.8.0/24 and Tailscale, with clear validation and rollback steps.

## Technical Context

**Language/Version**: YAML (Ansible playbooks)  
**Primary Dependencies**: Ansible control node, Docker Engine, Docker Compose
plugin, Linux VLAN tooling, OpenWrt UCI via gekmihesg.openwrt  
**Storage**: Repo-managed YAML configs and OpenWrt UCI snapshots  
**Testing**: ansible-lint, yamllint, ansible-playbook --check, HTTP reachability
validation  
**Target Platform**: atlas-host (Linux), OpenWrt router (GL-MT6000)  
**Project Type**: Infrastructure-as-Code repository  
**Performance Goals**: Service reachable within 10 minutes after apply  
**Constraints**: Avoid lockout, keep idempotent, preserve management access,
isolate container network  
**Scale/Scope**: Single server, VLAN 40, one sample service

## Constitution Check

_GATE: Must pass before Phase 0 research. Re-check after Phase 1 design._

Status: Pass

- IaC only: changes will be captured in Ansible/OpenWrt configs and versioned.
- Safety-first: plan includes rollback and pre/post validation steps.
- Idempotency & drift: Ansible tasks will be safe to re-run.
- Assumptions include Ansible/OpenWrt citations where needed.
- Router assumptions consult the GL-MT6000 reference first.
- Management access endpoints are documented in the spec.
- Docs/README updates are included for behavior changes.
- English comments and 80-column wrapping will be enforced.

## Project Structure

### Documentation (this feature)

```text
specs/001-docker-vlan-nginx/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command)
```

### Source Code (repository root)

```text
ansible/
├── configs/
│   ├── network.yml
│   └── openwrt/
│       ├── dhcp/
│       ├── firewall/
│       └── system/
├── inventory/
├── playbooks/
│   ├── apply-server.yml
│   ├── apply-openwrt.yml
│   └── verify-openwrt.yml
└── README.md

docs/
├── runbooks/
│   ├── network-config.md
│   └── openwrt-tailscale.md
└── index.md
```

**Structure Decision**: Use existing Ansible playbooks for atlas-host and
OpenWrt, store new network and hostname data in `ansible/configs/`, and update
runbooks in `docs/`.

## Phase 0: Outline & Research

- Confirm atlas-host OS package strategy for Docker and Docker Compose based on
  existing apt usage.
- Determine the persistent VLAN configuration approach for atlas-host (host
  networking tooling) and document rollback.
- Identify OpenWrt UCI changes needed for VLAN 40 routing/firewall and DNS
  hostnames, plus Tailscale subnet route updates.
- Capture decisions with rationale in
  `/Users/christianweinrich/Source/infrastructure/specs/001-docker-vlan-nginx/research.md`.

## Phase 1: Design & Contracts

- Document network/service entities in
  `/Users/christianweinrich/Source/infrastructure/specs/001-docker-vlan-nginx/data-model.md`.
- Record contract impact in
  `/Users/christianweinrich/Source/infrastructure/specs/001-docker-vlan-nginx/contracts/`.
- Provide operator quickstart steps in
  `/Users/christianweinrich/Source/infrastructure/specs/001-docker-vlan-nginx/quickstart.md`.
- Update agent context with
  `.specify/scripts/bash/update-agent-context.sh codex`.
- Re-check constitution compliance after design updates.

## Phase 2: Implementation Plan (KISS)

1. Extend `ansible/configs/network.yml` with VLAN 40 and service hostname data.
2. Update `ansible/playbooks/apply-openwrt.yml` to configure VLAN 40,
   inter-VLAN routing, firewall rules, DHCP/DNS hostnames, and Tailscale subnet
   routes.
3. Update `ansible/playbooks/verify-openwrt.yml` to validate routing, DNS, and
   reachability from LAN and Tailscale.
4. Update `ansible/playbooks/apply-server.yml` to install Docker/Compose,
   configure VLAN interface on atlas-host, and deploy the hello world nginx
   container in an isolated network.
5. Add validation and rollback tasks for server network and container changes.
6. Update `docs/runbooks/network-config.md`, `docs/runbooks/openwrt-tailscale.md`,
   and any README.md files to document the new VLAN and service access.
7. Validate with `ansible-playbook --check`, then apply changes and confirm
   access from LAN and Tailscale using the configured hostname.

## Constitution Check (Post-Design)

Status: Pass (no new violations introduced).

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation                  | Why Needed         | Simpler Alternative Rejected Because |
| -------------------------- | ------------------ | ------------------------------------ |
| [e.g., 4th project]        | [current need]     | [why 3 projects insufficient]        |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient]  |
