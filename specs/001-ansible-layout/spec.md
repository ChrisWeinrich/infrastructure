# Feature Specification: Ansible Repository Layout

**Feature Branch**: `001-ansible-layout`  
**Created**: 2025-12-25  
**Status**: Draft  
**Input**: User description: "You are responsible for generating and maintaining the Ansible repository layout. All automation code MUST exist inside: ./ansible/. The structure below is the canonical reference and must be created exactly. All existing files must be migrated into this structure. No file, playbook, inventory, role or script may exist outside ./ansible. Legacy structure must be refactored accordingly. Folders must exist even if empty. Files listed must exist at least as placeholders. Comments define purpose and MUST be followed. It is allowed and expected to split tasks further or add new task files when it is logically meaningful — modularity and clean separation of concerns is REQUIRED. Container deployments may grow inside the containers folder. The goal is maintainability and scalability over time."

## Clarifications

### Session 2025-12-25

- Q: What naming convention should container run scripts use? → A: `run_container_<name>.sh` in `ansible/scripts/`.

## User Scenarios & Testing _(mandatory)_

### User Story 1 - Canonical Layout Enforcement (Priority: P1)

As a repository maintainer, I want a single canonical layout for all automation assets so that the repository is consistent, discoverable, and easy to maintain.

**Why this priority**: This is the core requirement that unlocks every other workflow and prevents fragmented automation.

**Independent Test**: Can be fully tested by verifying the canonical directory tree exists and that no automation files live outside `./ansible/`.

**Acceptance Scenarios**:

1. **Given** a repository with legacy automation files outside `./ansible/`, **When** the layout is enforced, **Then** all automation files are located under the canonical `./ansible/` structure and no automation files remain outside it.
2. **Given** the canonical structure definition, **When** the repository is checked, **Then** every required directory and listed file exists, including empty placeholders.

---

### User Story 2 - Safe Migration of Existing Content (Priority: P2)

As a maintainer, I want existing automation content to be relocated into the new structure without losing information so that history and functionality are preserved.

**Why this priority**: Migration protects existing work and prevents regressions while adopting the new layout.

**Independent Test**: Can be fully tested by validating that all pre-existing automation files are present in new locations with unchanged content.

**Acceptance Scenarios**:

1. **Given** existing automation files and directories outside the canonical structure, **When** migration is complete, **Then** each file is placed into its appropriate location under `./ansible/` with identical content.

---

### User Story 3 - Standardized Entry Points (Priority: P3)

As a maintainer, I want standard entry point scripts and playbooks in predictable locations so that common operations are repeatable and easy to run.

**Why this priority**: Consistent entry points reduce operational errors and documentation burden.

**Independent Test**: Can be fully tested by verifying the standard scripts and playbooks exist under `./ansible/` and reference only the canonical layout.

**Acceptance Scenarios**:

1. **Given** the canonical layout, **When** standard run scripts and playbooks are inspected, **Then** they exist at the specified paths and do not rely on files outside `./ansible/`.
2. **Given** container deployments under the canonical layout, **When** I look for container-specific entry points, **Then** each container has a corresponding run script.

---

### Edge Cases

- What happens when a legacy file name conflicts with a required placeholder file?
- How does the system handle automation files that do not clearly map to a canonical location?

## Requirements _(mandatory)_

### Functional Requirements

- **FR-001**: The repository MUST contain the full canonical `./ansible/` directory tree, including all required empty directories.
- **FR-002**: All automation-related files (playbooks, inventories, roles, scripts, templates, files, variables) MUST reside under `./ansible/`.
- **FR-003**: Existing automation files outside `./ansible/` MUST be migrated into the canonical structure without loss of content.
- **FR-004**: Each required file listed in the canonical structure MUST exist, at least as a placeholder.
- **FR-005**: Standard run scripts and playbooks MUST exist at the canonical paths and MUST not depend on files outside `./ansible/`.
- **FR-006**: The canonical layout MUST allow adding new task files and container deployment files within the designated containers area without breaking the structure.
- **FR-007**: The migration MUST preserve the logical separation of concerns across inventories, roles, playbooks, scripts, and variables.
- **FR-008**: Each container deployment MUST have a corresponding run script under the canonical scripts area.
- **FR-009**: Container run scripts MUST follow the naming pattern `run_container_<name>.sh` under `ansible/scripts/`.

### Functional Requirements Acceptance Criteria

- **FR-001**: A full directory tree inspection shows every required folder exists, including empty directories.
- **FR-002**: A scan of the repository shows no automation assets outside the canonical automation directory.
- **FR-003**: Migrated files match their source content and are found only in canonical locations.
- **FR-004**: Each required file path exists and is committed, even when it is a placeholder.
- **FR-005**: Standard entry points are present and reference only canonical locations.
- **FR-006**: Adding a new container deployment file within the containers area requires no new top-level directories.
- **FR-007**: Inventories, roles, playbooks, scripts, and variables are separated into their canonical folders with no cross-category mixing.
- **FR-008**: Each container deployment has a run script present in the canonical scripts directory.
- **FR-009**: Container run scripts match the required naming convention and live under `ansible/scripts/`.

### Key Entities _(include if feature involves data)_

- **Canonical Layout**: The defined directory and file structure under `./ansible/` that all automation assets must follow.
- **Automation Asset**: Any playbook, inventory, role, script, template, file, or variable file used to operate the infrastructure.
- **Entry Point Script**: A standard script used to execute a common automation task from the canonical structure.
- **Container Deployment**: A collection of task files and related assets placed under the containers area of the layout.

## Assumptions & Sources _(mandatory)_

- Router/OpenWrt behavior and constraints will be aligned with the GL-MT6000 reference: https://github.com/gl-inet/docs4.x/blob/master/docs/user_guide/gl-mt6000/index.md
- OpenWrt automation conventions will follow the ansible-openwrt role reference: https://github.com/gekmihesg/ansible-openwrt
- Management access endpoints (hostnames/IPs, protocol, authentication method, and location) are already documented in existing inventory or host variable files and will be preserved during migration.
- Any changes that affect usage or behavior will update `docs/` and any relevant README.md in the repository.
- All code, scripts, configs, and YAML files will include English comments explaining non-obvious steps or blocks.

## Success Criteria _(mandatory)_

### Measurable Outcomes

- **SC-001**: 100% of automation assets in the repository are located under the canonical automation directory.
- **SC-002**: 100% of required directories and listed files in the canonical structure exist after migration.
- **SC-003**: Standard entry point scripts and playbooks are available at their canonical paths and can be executed without referencing files outside the canonical automation directory.
- **SC-004**: A random sample of 10 migrated automation files matches their pre-migration content byte-for-byte.
- **SC-005**: 100% of container deployments have corresponding run scripts under the canonical scripts directory.
