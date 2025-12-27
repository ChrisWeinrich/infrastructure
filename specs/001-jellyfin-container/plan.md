# Implementation Plan: Jellyfin First Container

**Branch**: `001-jellyfin-container` | **Date**: 2025-12-27 | **Spec**: /Users/christianweinrich/Source/infrastructure/specs/001-jellyfin-container/spec.md
**Input**: Feature specification from `/specs/001-jellyfin-container/spec.md`

## Summary

Remove the existing nginx app deployment and introduce Jellyfin as the first
production container on VLAN 40 with fixed addressing (192.168.40.3), media from
exactly two USB disks, centralized metadata persistence, and an OpenWrt firewall
rule that allows access only from the Achilles MAC address.

## Technical Context

**Language/Version**: Ansible (YAML), Bash (POSIX shell)  
**Primary Dependencies**: Ansible, OpenWrt UCI, Docker/Container runtime on host  
**Storage**: Host filesystem paths for USB mounts and persistent metadata  
**Testing**: Pre-commit linting (ansible-lint, yamllint, markdownlint)  
**Target Platform**: Linux server host + OpenWrt gateway  
**Project Type**: Infrastructure automation  
**Performance Goals**: N/A (single service, home-scale)  
**Constraints**: No risky/destructive changes without explicit approval; MAC-only
access for Jellyfin; 192.168.40.0/24 addressing  
**Scale/Scope**: Single host, single app container, two media disks

## Constitution Check

_GATE: Must pass before Phase 0 research. Re-check after Phase 1 design._

- No-risk posture: avoid irreversible/destructive actions without explicit approval.
- SOC/SRP compliance: each module or role has one clear responsibility.
- Documentation updates required for behavior, usage, or runbook changes.
- Comments required for non-obvious logic to explain intent.
- Constitution governs; `AGENTS.md` is implementation guidance.

**Gate status**: PASS (plan uses additive changes, isolates roles, and updates docs).
**Post-design check**: PASS (design outputs align with constitution principles).

## Project Structure

### Documentation (this feature)

```text
specs/001-jellyfin-container/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
ansible/
├── playbooks/
│   ├── apply-server.yml         # Host automation (update apps section)
│   └── apply-openwrt.yml         # Gateway automation (firewall rule)
├── roles/
│   ├── apps/
│   │   ├── jellyfin/             # New app role (to add)
│   │   └── nginx/                # Existing role (to remove/disable for this use)
│   ├── host/
│   │   ├── docker/               # Container runtime setup
│   │   └── hardware/             # USB disks/mounts if needed
│   └── openwrt/uci/              # Firewall/UCI changes
├── configs/                      # Shared config inputs
└── inventories/home/hosts.yml    # Inventory

docs/
├── runbooks/                     # Operational runbooks
└── index.md
```

**Structure Decision**: Use existing Ansible playbooks and roles; introduce a
single app role for Jellyfin and update OpenWrt UCI role for MAC allowlist.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
| --------- | ---------- | ------------------------------------ |
| N/A       | N/A        | N/A                                  |
