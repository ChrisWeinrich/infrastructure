# Implementation Plan: Ansible Server Baseline

**Branch**: `001-ansible-server-baseline` | **Date**: 2025-12-21 | **Spec**:
`specs/001-ansible-server-baseline/spec.md`
**Input**: Feature specification from `/specs/001-ansible-server-baseline/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See
`.codex/prompts/speckit.plan.md` for the execution workflow.

## Summary

Establish a documented server baseline and a single YAML source of truth for
all Ansible configuration. The base configuration YAML is a required pre-step
before router registration and automation validation, ensuring all values are
defined in one place and used consistently across documentation, router
registration, and the Ansible "Hello World" check.

## Technical Context

**Language/Version**: Ansible (YAML), OpenWrt UCI
**Primary Dependencies**: `gekmihesg.openwrt` role
**Storage**: YAML files in repository
**Testing**: ansible-lint, yamllint, pre-commit checks
**Target Platform**: OpenWrt GL-MT6000 router, Linux server on LAN
**Project Type**: single
**Performance Goals**: N/A (administrative automation)
**Constraints**: single-source main YAML file for all Ansible configuration
**Scale/Scope**: small fleet (1-5 servers, single router)

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- IaC only: router/network changes expressed in Ansible/OpenWrt configs and
  committed to version control.
- Single-source config: all Ansible configuration values live in the single
  main YAML file with no hidden or external values.
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

## Project Structure

### Documentation (this feature)

```text
specs/001-ansible-server-baseline/
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
├── configs/
├── inventory/
├── playbooks/
└── requirements.yml

docs/
README.md
```

**Structure Decision**: Use `ansible/` for all automation assets and store the
single main configuration YAML in `ansible/configs/`, referenced by playbooks
and inventory while keeping documentation in `docs/` and README files.

## Phase Plan

### Phase 0: Research

- Confirm baseline assumptions for OpenWrt configuration workflows and Ansible
  role usage.
- Define the single main configuration YAML location and ownership rules.
- Capture expectations for "Hello World" validation and router registration
  workflows.

### Phase 1: Design

- Define data model for server records, router entries, and the base config
  YAML.
- Document the contract boundary as "no API contracts" for this feature.
- Provide a quickstart outlining the required order: documentation, base config
  YAML pre-step, router registration, and Ansible validation.

### Phase 2: Planning (this feature)

- Pre-step: create the base configuration YAML as the first required artifact
  after documentation, before router registration or any Ansible runs.
- Ensure the README and YAML use the same recorded MAC, hostname, and IP values.
- Use the hostname from the YAML to drive the Ansible "Hello World" run.

## Post-Design Constitution Check

All constitution gates remain satisfied with the single-source configuration
rule and documentation requirements applied in the design artifacts.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

No violations.
