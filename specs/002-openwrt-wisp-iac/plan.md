# Implementation Plan: OpenWrt WISP IaC

**Branch**: `002-openwrt-wisp-iac` | **Date**: 2025-12-20 | **Spec**: \
`specs/002-openwrt-wisp-iac/spec.md`
**Input**: Feature specification from `specs/002-openwrt-wisp-iac/spec.md`

## Summary

Migrate the existing GL-MT6000 WISP/repeater configuration into a Git-managed
IaC workflow that preserves current connectivity, captures a baseline snapshot,
and applies staged changes safely. Use Ansible with the
`gekmihesg.openwrt` role to manage OpenWrt configuration without installing
Python on the router, with explicit verification and recovery steps for each
change.

## Technical Context

**Language/Version**: YAML (Ansible playbooks), OpenWrt UCI syntax
**Primary Dependencies**: `gekmihesg.openwrt` role, OpenWrt UCI management
**Storage**: Git repository files and snapshots
**Testing**: pre-commit, yamllint, ansible-lint
**Target Platform**: GL.iNet GL-MT6000 (OpenWrt-based firmware), operator host
**Project Type**: infrastructure automation
**Performance Goals**: restore upstream Wi-Fi and LAN internet within\n+2
minutes
**Constraints**: no router-side Python, avoid lockouts, staged apply with
physical access fallback
**Scale/Scope**: single router, single upstream Wi-Fi uplink

## Constitution Check

_GATE: Must pass before Phase 0 research. Re-check after Phase 1 design._

- IaC only: router/network changes expressed in Ansible/OpenWrt configs and
  committed to version control. **Pass**
- Safety-first: rollback steps, pre/post validation, and safe access path are
  defined for network changes. **Pass**
- Idempotency: automation is idempotent. **Pass**
- Assumptions are documented with citations for router/OpenWrt/Ansible
  specifics. **Pass**
- Router-specific assumptions consult the primary router reference first.
  **Pass**

  ```
  https://github.com/gl-inet/docs4.x/blob/master/docs/user_guide/gl-mt6000/index.md
  ```

- Core Ansible/OpenWrt reference. **Pass**

  ```
  https://github.com/gekmihesg/ansible-openwrt
  ```

- Management access endpoints and methods are documented (IP/hostname,
  protocol, authentication, location). **Pass**
- Code comments and documentation are in English; Markdown prose hard-wraps at
  80 columns. **Pass**

## Project Structure

### Documentation (this feature)

```text
specs/002-openwrt-wisp-iac/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
└── tasks.md
```

### Source Code (repository root)

```text
ansible/
├── ansible/playbooks/
├── roles/
└── inventory/

ansible/playbooks/
└── snapshot-openwrt.yml

ansible/inventory/
└── openwrt/
    └── hosts.yml
```

**Structure Decision**: Use the existing `ansible/` scaffold for shared roles
and inventory defaults, and add top-level `ansible/playbooks/` and `ansible/inventory/`
entries for feature-specific automation as requested in the deliverables.

## Complexity Tracking

None.

## Post-Design Constitution Check

- IaC-only workflow preserved with repository-based configuration. **Pass**
- Safety-first validation and recovery documentation included. **Pass**
- Idempotency controls documented and planned. **Pass**
- Assumptions and sources cited in spec and research. **Pass**
- Management access documentation included in quickstart. **Pass**
- English documentation with 80-column wrap in generated docs. **Pass**
