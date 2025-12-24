# Implementation Plan: Static IP and Hostnames

**Branch**: `001-static-ip-hostnames` | **Date**: 2025-12-24 | **Spec**:
[spec.md](spec.md)
**Input**: Feature specification from
`/specs/001-static-ip-hostnames/spec.md`

## Summary

Deliver a deterministic LAN address and consistent hostnames for the router and
server, plus a central, readable configuration file structured by network
topology. The approach uses repo-managed configuration values, idempotent
automation, conflict checks, and updated management endpoint documentation.

## Technical Context

**Language/Version**: YAML (Ansible playbooks), OpenWrt UCI syntax
**Primary Dependencies**: Ansible, gekmihesg.openwrt role, pre-commit,
yamllint, ansible-lint
**Storage**: Repository-managed configuration files (YAML) and snapshots
**Testing**: ansible-lint, yamllint, pre-commit hooks
**Target Platform**: OpenWrt GL-MT6000 router and LAN-attached server
**Project Type**: Infrastructure automation (single repository)
**Performance Goals**: N/A (configuration delivery and validation)
**Constraints**: Safety-first change path, rollback steps, LAN 192.168.1.0/24
addressing, idempotent runs
**Scale/Scope**: Single site, router + one server

## Constitution Check

_GATE: Must pass before Phase 0 research. Re-check after Phase 1 design._

- IaC only: Pass. All changes are expressed in repo-managed Ansible/OpenWrt
  configuration.
- Safety-first: Pass. Plan includes rollback and validation steps for network
  changes.
- Idempotency & drift: Pass. Runs are idempotent with conflict checks.
- Assumptions are documented with citations for router/OpenWrt/Ansible
  specifics: Pass. Spec and research cite primary sources.
- Router-specific assumptions consult the primary router reference first:
  https://github.com/gl-inet/docs4.x/blob/master/docs/user_guide/gl-mt6000/index.md
- Core Ansible/OpenWrt reference:
  https://github.com/gekmihesg/ansible-openwrt
- Management access endpoints and methods are documented (IP/hostname,
  protocol, authentication, location): Pass. Spec includes endpoints.
- Changes that affect behavior or usage update `docs/` and any README.md:
  Pass. Plan includes documentation updates.
- Code, scripts, configs, and YAML files are commented in English so each
  step, function, class, or block is immediately understandable; Markdown
  prose hard-wraps at 80 characters: Pass. Plan enforces English comments and
  wrap.

## Project Structure

### Documentation (this feature)

```text
specs/001-static-ip-hostnames/
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
  group_vars/
  host_vars/
  inventory/
  playbooks/
  roles/

docs/

scripts/

snapshots/

specs/
```

**Structure Decision**: Infrastructure repository with `ansible/` as the
primary delivery surface. No application code paths are required.

## Constitution Check (Post-Design)

- IaC only: Pass.
- Safety-first: Pass.
- Idempotency & drift: Pass.
- Cited assumptions: Pass.
- Documentation and README sync: Pass.
- English comments and 80-column wrap: Pass.

## Complexity Tracking

> No constitution violations requiring justification.
