# Implementation Plan: Ansible Repository Layout

**Branch**: `001-ansible-layout` | **Date**: 2025-12-25 | **Spec**: /Users/christianweinrich/Source/infrastructure/specs/001-ansible-layout/spec.md
**Input**: Feature specification from `/specs/001-ansible-layout/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See
`.codex/prompts/speckit.plan.md` for the execution workflow.

## Summary

Deliver a canonical Ansible repository layout where all automation assets live
under `./ansible/`, all required folders and placeholder files exist, and legacy
content is migrated without loss. Ensure every container deployment has a
matching run script. Produce a layout contract and migration plan artifacts
(research, data model, contracts, quickstart) to support safe rollout.

## Technical Context

**Language/Version**: YAML (Ansible playbooks), shell scripts (POSIX sh/bash)  
**Primary Dependencies**: Ansible, OpenWrt UCI tooling, gekmihesg.openwrt role, pre-commit, ansible-lint, yamllint  
**Storage**: Git repository files (YAML, templates, scripts, snapshots)  
**Testing**: ansible-lint, yamllint, pre-commit hooks  
**Target Platform**: Ansible control node (Linux/macOS), OpenWrt routers, Linux host (Atlas)  
**Project Type**: single repository (infrastructure IaC)  
**Performance Goals**: N/A (layout and migration)  
**Constraints**: All automation assets under `./ansible/`; directories and files must match canonical tree; preserve content fidelity; every container has a run script  
**Scale/Scope**: Home infrastructure automation repository; multiple roles and inventories

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- IaC only: router/network changes expressed in Ansible/OpenWrt configs and
  committed to version control.
- Safety-first: rollback steps, pre/post validation, and safe access path are
  defined for network changes.
- Idempotency & drift: automation is idempotent and includes drift detection
  or remediation.
- Assumptions are documented with citations for router/OpenWrt/Ansible
  specifics.
- Router-specific assumptions consult the primary router reference first:
  https://github.com/gl-inet/docs4.x/blob/master/docs/user_guide/gl-mt6000/index.md
- Core Ansible/OpenWrt reference:
  https://github.com/gekmihesg/ansible-openwrt
- Management access endpoints and methods are documented (IP/hostname,
  protocol, authentication, location).
- Changes that affect behavior or usage update `docs/` and any README.md.
- Code, scripts, configs, and YAML files are commented in English so each
  step, function, class, or block is immediately understandable; Markdown
  prose hard-wraps at 80 characters.

Status: Pass. This change is a repository layout migration with no direct
runtime device changes. The plan includes migration verification, rollback
steps, and documentation updates.

## Project Structure

### Documentation (this feature)

```text
specs/001-ansible-layout/
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
│   └── hermes-gateway/
│       ├── tasks/
│       │   ├── main.yml
│       │   ├── packages.yml
│       │   ├── networking.yml
│       │   ├── dhcp.yml
│       │   └── hardware.yml
│       ├── templates/
│       ├── files/
│       ├── defaults/
│       └── vars/
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

**Structure Decision**: Single repository layout with a dedicated `ansible/`
root containing inventories, roles, playbooks, scripts, and shared variables.

## Phase 0: Outline & Research

- Capture decisions for tooling and references already established in the
  repository (Ansible, OpenWrt role, linting, pre-commit).
- Record rationale and alternatives in `research.md`.

## Phase 1: Design & Contracts

- Model the canonical layout and migration entities in `data-model.md`.
- Document filesystem-level contracts in `/contracts/`.
- Provide a `quickstart.md` for running standard entry points within the new
  layout.
- Update agent context via the Codex update script.

## Constitution Check (Post-Design)

Status: Pass. No violations introduced; design artifacts align with IaC-only
principles, documentation requirements, and cited sources.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
