# Implementation Plan: Tailscale Router Access

**Branch**: `003-tailscale-router-access` | **Date**: 2025-12-23
**Spec**: `specs/003-tailscale-router-access/spec.md`
**Input**: Feature specification from
`/specs/003-tailscale-router-access/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See
`.codex/prompts/speckit.plan.md` for the execution workflow.

## Summary

Configure the OpenWrt router via Ansible to provide Tailscale-based remote
access to the 192.168.8.0/24 LAN, including 192.168.8.135, with persistent
settings, clear validation steps, and documented management access and
rollback.

## Technical Context

**Language/Version**: YAML (Ansible playbooks), OpenWrt UCI syntax
**Primary Dependencies**: Ansible, gekmihesg.openwrt role, Tailscale package
**Storage**: OpenWrt UCI configuration and repo-managed YAML files
**Testing**: ansible-lint, yamllint, pre-commit, playbook verify run
**Target Platform**: OpenWrt router (GL-MT6000), control host running Ansible
**Project Type**: Infrastructure-as-Code repository
**Performance Goals**: Remote access usable within 1 minute per connection
**Constraints**: Avoid lockout, keep idempotent, include rollback steps
**Scale/Scope**: Single router, one LAN subnet (192.168.8.0/24), small user set

## Constitution Check

_GATE: Must pass before Phase 0 research. Re-check after Phase 1 design._

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
- Code comments and documentation are in English; Markdown prose hard-wraps at
  80 characters.

Result: Pass

## Project Structure

### Documentation (this feature)

```text
specs/003-tailscale-router-access/
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
├── inventory/
├── playbooks/
├── requirements.yml
└── README.md

docs/

snapshots/
```

**Structure Decision**: Use the existing Ansible-based layout under
`ansible/` for router configuration and keep feature documentation in
`specs/003-tailscale-router-access/`.

## Phase 0: Research

- Confirm OpenWrt and Tailscale configuration best practices for subnet
  routing and LAN access.
- Confirm safe rollback and validation steps that prevent lockout.
- Document security considerations for authorized access control.

## Phase 1: Design & Contracts

- Define the minimal data model for authorized users, router node, and LAN
  resources.
- Produce an API contract used for validation/verification automation.
- Draft quickstart steps aligned with current Ansible playbooks.
- Update agent context after design artifacts are created.
- Re-check constitution compliance after design updates.

## Phase 2: Planning

- Identify playbook updates for Tailscale installation and route advertising.
- Add validation and rollback steps to documentation.
- Update docs and README as required by the constitution.

## Constitution Check (Post-Design)

Result: Pass
