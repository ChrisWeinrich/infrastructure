# Implementation Plan: Atlas USB Disk Mounts

**Branch**: `001-usb-disk-mount` | **Date**: 2025-12-24 | **Spec**:
`/Users/christianweinrich/Source/infrastructure/specs/001-usb-disk-mount/spec.md`
**Input**: Feature specification from
`/Users/christianweinrich/Source/infrastructure/specs/001-usb-disk-mount/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See
`.codex/prompts/speckit.plan.md` for the execution workflow.

## Summary

Ensure Atlas mounts both USB partitions persistently on boot by configuring the
existing server apply playbook to mount by stable identifiers, with clear
validation and rollback steps, and document the usage.

## Technical Context

<!--
  ACTION REQUIRED: Replace the content in this section with the technical details
  for the project. The structure here is presented in advisory capacity to guide
  the iteration process.
-->

**Language/Version**: YAML (Ansible playbooks)  
**Primary Dependencies**: Ansible (control node), Linux mount tooling on Atlas  
**Storage**: USB disk partitions mounted on Atlas  
**Testing**: ansible-playbook --check, ansible-lint, manual mount verification  
**Target Platform**: Atlas server host (Linux)  
**Project Type**: Single infrastructure repo  
**Performance Goals**: Mounts available within 2 minutes after reboot  
**Constraints**: Persistent identifiers, no manual steps after reboot  
**Scale/Scope**: Single server, two partitions

## Constitution Check

_GATE: Must pass before Phase 0 research. Re-check after Phase 1 design._

Status: Pass

- IaC only: changes are captured in the Ansible playbook and versioned.
- Safety-first: rollback and validation steps are included in the plan.
- Idempotency & drift: Ansible mount tasks are idempotent and re-runnable.
- Assumptions include Ansible citation; router references are not applicable to
  Atlas.
- Management access (SSH via inventory) is documented in the spec assumptions.
- Docs/README updates are included for behavior changes.
- Code/config comments and 80-column wrapping are enforced.

## Project Structure

### Documentation (this feature)

```text
specs/001-usb-disk-mount/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

<!--
  ACTION REQUIRED: Replace the placeholder tree below with the concrete layout
  for this feature. Delete unused options and expand the chosen structure with
  real paths (e.g., apps/admin, packages/something). The delivered plan must
  not include Option labels.
-->

```text
ansible/
├── playbooks/
│   └── apply-server.yml
├── inventory/
├── configs/
└── README.md

docs/
```

**Structure Decision**: Use the existing Ansible layout; changes are scoped to
`ansible/playbooks/apply-server.yml`, with docs updates as needed.

## Phase 0: Outline & Research

- Confirm mount strategy, identifiers, and mount locations for Atlas.
- Capture decisions and rationale in
  `/Users/christianweinrich/Source/infrastructure/specs/001-usb-disk-mount/research.md`.

## Phase 1: Design & Contracts

- Document the mount-related entities and validation in
  `/Users/christianweinrich/Source/infrastructure/specs/001-usb-disk-mount/data-model.md`.
- Record contract impact in
  `/Users/christianweinrich/Source/infrastructure/specs/001-usb-disk-mount/contracts/`.
- Provide operator quickstart steps in
  `/Users/christianweinrich/Source/infrastructure/specs/001-usb-disk-mount/quickstart.md`.
- Update agent context with
  `.specify/scripts/bash/update-agent-context.sh codex`.

## Constitution Check (Post-Design)

Status: Pass (no new violations introduced).

## Phase 2: Implementation Plan (KISS)

1. Update `ansible/playbooks/apply-server.yml` to:
   - Define the two partitions and mount points as variables.
   - Mount by stable identifiers.
   - Ensure mounts are present on boot and idempotent.
2. Add validation tasks to confirm mounts are available and writable.
3. Add rollback steps to unmount/remove entries if needed.
4. Update `docs/` and any relevant README content with usage and validation.
5. Validate with `ansible-playbook --check` and a live run on Atlas, then verify
   mount status.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation                  | Why Needed         | Simpler Alternative Rejected Because |
| -------------------------- | ------------------ | ------------------------------------ |
| [e.g., 4th project]        | [current need]     | [why 3 projects insufficient]        |
| [e.g., Repository pattern] | [specific problem] | [why direct DB access insufficient]  |
