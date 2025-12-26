# Implementation Plan: Playbook Role Refactor

**Branch**: `001-ansible-playbook-roles` | **Date**: 2025-12-25 | **Spec**:

```text
/Users/christianweinrich/Source/infrastructure/specs/001-ansible-playbook-roles/spec.md
```

**Input**: Feature specification from

```text
/Users/christianweinrich/Source/infrastructure/specs/001-ansible-playbook-roles/spec.md
```

## Summary

Refactor Atlas host and Hermes gateway automation so playbooks only orchestrate
roles, tasks live under the correct roles, scripts are clearly mapped to their
playbooks, and documentation matches the canonical Ansible layout with clear,
separated responsibilities (SOC).

## Technical Context

**Language/Version**: Ansible playbooks (YAML) and shell scripts (POSIX sh/bash)
**Primary Dependencies**: Ansible, ansible-lint, yamllint, pre-commit
**Storage**: Repository files (YAML, templates, scripts, docs)
**Testing**: ansible-lint, yamllint, idempotent re-runs
**Target Platform**: OpenWrt router (Hermes gateway) and Linux host (Atlas)
**Project Type**: Infrastructure-as-code repository (Ansible automation)
**Performance Goals**: Safe, repeatable runs; minimize manual steps
**Constraints**: Idempotency, safe rollback, documentation hard-wrap at 80 cols
**Scale/Scope**: Atlas host and Hermes gateway automation in this repository

## Constitution Check

_GATE: Must pass before Phase 0 research. Re-check after Phase 1 design._

- IaC only: router/network changes expressed in Ansible/OpenWrt configs and
  committed to version control. PASS
- Safety-first: rollback steps, pre/post validation, and safe access path are
  defined for network changes. PASS (plan includes rollback + validation steps)
- Idempotency & drift: automation is idempotent and includes drift detection
  or remediation. PASS (role tasks must be idempotent; re-run checks planned)
- Assumptions are documented with citations for router/OpenWrt/Ansible
  specifics. PASS (spec + plan cite required sources)
- Router-specific assumptions consult the primary router reference first:
  https://github.com/gl-inet/docs4.x/blob/master/docs/user_guide/gl-mt6000/
  index.md
  PASS
- Core Ansible/OpenWrt reference:
  https://github.com/gekmihesg/ansible-openwrt PASS
- Management access endpoints and methods are documented (IP/hostname,
  protocol, authentication, location). PASS (doc updates required)
- Changes that affect behavior or usage update `docs/`, README.md, and
  `ansible/README.md` for automation layout or entry point updates. PASS
- Code, scripts, configs, and YAML files are commented in English so each
  step, function, class, or block is immediately understandable; Markdown
  prose hard-wraps at 80 characters. PASS

## Project Structure

### Documentation (this feature)

```text
specs/001-ansible-playbook-roles/
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
├── inventories/
├── playbooks/
├── roles/
├── scripts/
├── vars/
├── ansible.cfg
└── requirements.yml
```

**Structure Decision**: Use the canonical Ansible layout under `ansible/` per
`ansible/README.md`, with playbooks as orchestration entry points and roles as
the unit of responsibility (SOC).

## Complexity Tracking

No constitution violations.

## Phase 0: Outline & Research

### Research Tasks

- Confirm canonical layout, entry points, and script conventions from
  `ansible/README.md` for Atlas host and Hermes gateway.
- Confirm router guidance sources and documentation requirements from the
  constitution and `ansible/README.md`.

### Output

- `research.md` with decisions, rationale, and alternatives.

## Phase 1: Design & Contracts

### Data Model

- Identify repository entities (scripts, playbooks, roles, docs) and required
  fields for traceability and documentation.

### Contracts

- Document that there are no external API contracts; repository automation is
  file-driven. Provide a stub contract note in `contracts/`.

### Quickstart

- Provide safe run guidance and entry points for Atlas host and Hermes gateway.

### Output

- `data-model.md`, `contracts/README.md`, `quickstart.md`.

## Phase 2: Implementation Plan (SOC-focused, clear steps)

### Step 1: Inventory and Mapping

- Enumerate all scripts under `ansible/scripts/` and playbooks under
  `ansible/playbooks/` for Atlas host and Hermes gateway.
- Build a script-to-playbook mapping table and identify missing or stale links.
- Record the mapping in documentation (new or updated docs under `docs/`).

### Step 2: Playbook Decomposition

- For each playbook, locate embedded task logic and move tasks into the
  appropriate role task files (packages, networking, hardware, services,
  containers).
- Keep playbooks to orchestration only (role includes, tags, vars).

### Step 3: Role SOC Enforcement

- For each role, ensure a single responsibility and split tasks by concern.
- Align task file names with `ansible/README.md` conventions.
- Add clear English comments to non-obvious task blocks.

### Step 4: Script Integration

- Ensure each `run_*.sh` script targets the correct playbook and inventory.
- Add or update container run scripts to match container definitions.
- Document safe usage, inputs, and expected outcomes in English.

### Step 5: Documentation Sync

- Update `ansible/README.md` and any relevant `docs/` and README files to
  reflect the refactor, mapping, and entry points.
- Hard-wrap Markdown prose at 80 characters.

### Step 6: Validation and Safety

- Run lint checks (ansible-lint, yamllint) and address violations.
- Perform idempotent re-runs where feasible.
- Document rollback steps and validation checks for network-affecting changes.

## Post-Design Constitution Check

Re-check after Phase 1 outputs are complete.
