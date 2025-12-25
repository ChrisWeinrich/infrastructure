# Feature Specification: Playbook Role Refactor

**Feature Branch**: `001-ansible-playbook-roles`  
**Created**: 2025-12-25  
**Status**: Draft  
**Input**: User description: "bitte verkn\u00a8pfe die scripte mit den playbooks. Bitte zerlege die playoboks in tasks und packe sie in die passenden roles. mache sie richtig SOC und dokumentiere gut"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Traceable Script Usage (Priority: P1)

As an infrastructure maintainer, I can see which scripts are used by which playbooks and how they relate for the Atlas host and Hermes gateway, so I can understand safe execution paths and avoid running the wrong automation.

**Why this priority**: Clear linkage reduces operational risk and makes troubleshooting faster.

**Independent Test**: Can be fully tested by picking any script in scope for Atlas host or Hermes gateway and confirming the documentation and playbooks show its usage and purpose.

**Acceptance Scenarios**:

1. **Given** a script in the repository for Atlas host or Hermes gateway, **When** I look up its documentation, **Then** I can identify the playbook(s) that use it and the intended execution purpose.
2. **Given** a playbook for Atlas host or Hermes gateway, **When** I review its documentation, **Then** I can identify every script it depends on and why each is needed.

---

### User Story 2 - Clear Role-Based Structure (Priority: P2)

As an infrastructure maintainer, I can find the work of each playbook split into tasks within appropriate roles for the Atlas host and Hermes gateway, so the system is easier to maintain and change safely.

**Why this priority**: Separation of concerns reduces regressions and makes changes more localized.

**Independent Test**: Can be tested by inspecting a playbook and confirming its tasks are delegated to roles that each have a single, clear responsibility.

**Acceptance Scenarios**:

1. **Given** a playbook for Atlas host or Hermes gateway, **When** I open it, **Then** I see only orchestration and role inclusion rather than embedded task logic.
2. **Given** a role used by Atlas host or Hermes gateway, **When** I review its tasks, **Then** I can describe its responsibility without referencing other roles.

---

### User Story 3 - Reliable Documentation (Priority: P3)

As an infrastructure maintainer, I can follow documentation that explains what each automation component does and how to use it safely for the Atlas host and Hermes gateway.

**Why this priority**: Accurate documentation reduces onboarding time and prevents incorrect usage.

**Independent Test**: Can be tested by following the docs for a selected playbook and successfully understanding prerequisites and intended outcomes.

**Acceptance Scenarios**:

1. **Given** a playbook for Atlas host or Hermes gateway, **When** I read its documentation, **Then** I can identify prerequisites, run order, and expected outcomes.
2. **Given** a role for Atlas host or Hermes gateway, **When** I read its documentation, **Then** I understand what changes it makes and any constraints.

---

### Edge Cases

- What happens when a script is no longer referenced by any Atlas host or Hermes gateway playbook?
- How does the system handle a playbook that still contains inline task logic after refactoring?
- What happens if two roles appear to own the same responsibility?
- How does documentation stay accurate if automation changes frequently?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The system MUST provide a documented mapping between each script and the playbook(s) that use it.
- **FR-002**: Each playbook MUST be decomposed into tasks located in role-appropriate task groups.
- **FR-003**: Each role MUST have a single, clearly documented responsibility (separation of concerns).
- **FR-004**: Playbooks MUST focus on orchestration and include roles rather than embedding task logic.
- **FR-005**: Documentation MUST explain the purpose, prerequisites, and safe usage of each playbook and role.
- **FR-006**: Documentation updates MUST accompany any change that affects automation behavior or usage.

### Key Entities *(include if feature involves data)*

- **Script**: An executable automation component with a defined purpose and usage context.
- **Playbook**: An orchestration entry point that sequences roles and defines execution intent.
- **Role**: A cohesive group of tasks responsible for a single domain concern.
- **Documentation Artifact**: Written guidance describing linkage, purpose, prerequisites, and expected outcomes.

## Assumptions & Sources *(mandatory)*

- The repository already contains playbooks, scripts, and roles for Atlas host and Hermes gateway that need to be aligned and documented.
- Scope includes all playbooks, roles, and scripts for Atlas host and Hermes gateway tracked in this repository; external automation outside this repository is out of scope.
- Router-specific behavior or constraints will follow the primary router reference first: https://github.com/gl-inet/docs4.x/blob/master/docs/user_guide/gl-mt6000/index.md
- Core guidance for Ansible and OpenWrt usage will follow: https://github.com/gekmihesg/ansible-openwrt
- Management access endpoints and methods (IP/hostname, protocol, authentication, location) are documented or will be documented as part of this work.
- Changes affecting behavior or usage will update `docs/` and any `README.md`.
- Code, scripts, configs, and YAML files will include clear English comments for non-obvious steps or blocks.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% of Atlas host and Hermes gateway scripts in scope have a documented mapping to their playbook usage.
- **SC-002**: 100% of Atlas host and Hermes gateway playbooks in scope contain only orchestration and role inclusion, with no inline task logic.
- **SC-003**: A maintainer can locate an Atlas host or Hermes gateway playbook's purpose, prerequisites, and expected outcomes in under 5 minutes.
- **SC-004**: Documentation coverage includes purpose, prerequisites, run order, and safe usage for every Atlas host and Hermes gateway playbook and role in scope.
