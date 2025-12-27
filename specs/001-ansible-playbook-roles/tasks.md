---
description: "Task list for Playbook Role Refactor"
---

# Tasks: Playbook Role Refactor

**Input**: Design documents from
`/Users/christianweinrich/Source/infrastructure/specs/001-ansible-playbook-roles/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md,
contracts/README.md, quickstart.md

**Tests**: Not requested; no test tasks included.

**Organization**: Tasks are grouped by user story to enable independent
implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Establish working artifacts to guide the refactor

- [ ] T001 Create inventory workspace in
      `/Users/christianweinrich/Source/infrastructure/specs/001-ansible-playbook-roles/inventory.md`
      with tables for scripts, playbooks, roles, and containers

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Baseline inventory and scope confirmation required for all stories

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T002 Populate
      `/Users/christianweinrich/Source/infrastructure/specs/001-ansible-playbook-roles/inventory.md`
      with current Atlas host and Hermes gateway scripts, playbooks, roles, and
      container definitions

**Checkpoint**: Foundation ready - user story implementation can begin

---

## Phase 3: User Story 1 - Traceable Script Usage (Priority: P1) 🎯 MVP

**Goal**: Provide a clear, documented mapping between scripts and playbooks for
Atlas host and Hermes gateway.

**Independent Test**: Pick any script in scope and confirm the documentation
and script header identify the target playbook and intended usage.

### Implementation for User Story 1

- [ ] T003 [US1] Create the script-to-playbook mapping table in
      `/Users/christianweinrich/Source/infrastructure/docs/ansible/automation-map.md`
      using the inventory as the source of truth
- [ ] T004 [P] [US1] Update header comments in
      `/Users/christianweinrich/Source/infrastructure/ansible/scripts/run_gateway.sh`
      to name the target playbook, inventory, and safe usage notes
- [ ] T005 [P] [US1] Update header comments in
      `/Users/christianweinrich/Source/infrastructure/ansible/scripts/run_atlas.sh`
      to name the target playbook, inventory, and safe usage notes
- [ ] T006 [P] [US1] Update header comments in
      `/Users/christianweinrich/Source/infrastructure/ansible/scripts/run_site.sh`
      to name the target playbook, inventory, and safe usage notes
- [ ] T007 [P] [US1] Update header comments in
      `/Users/christianweinrich/Source/infrastructure/ansible/scripts/run_tag.sh`
      to name the target playbook, inventory, and safe usage notes
- [ ] T008 [P] [US1] For each container definition under
      `/Users/christianweinrich/Source/infrastructure/ansible/roles/atlas_host/containers/`,
      add or update the matching run script in
      `/Users/christianweinrich/Source/infrastructure/ansible/scripts/`
      as `run_container_<name>.sh` with documented playbook linkage

**Checkpoint**: Script usage is traceable end-to-end for Atlas host and Hermes
gateway.

---

## Phase 4: User Story 2 - Clear Role-Based Structure (Priority: P2)

**Goal**: Ensure playbooks orchestrate roles only and tasks live in the
appropriate role task files with SOC.

**Independent Test**: Open each playbook and confirm it contains only role
includes and orchestration logic, with tasks located under role task files.

### Implementation for User Story 2

- [ ] T009 [US2] Refactor
      `/Users/christianweinrich/Source/infrastructure/ansible/playbooks/gateway.yml`
      to include roles only and move inline tasks into
      `/Users/christianweinrich/Source/infrastructure/ansible/roles/hermes_gateway/tasks/`
- [ ] T010 [US2] Split Hermes gateway tasks by concern in
      `/Users/christianweinrich/Source/infrastructure/ansible/roles/hermes_gateway/tasks/`
      (`main.yml`, `packages.yml`, `networking.yml`, `dhcp.yml`, `hardware.yml`)
- [ ] T011 [US2] Refactor
      `/Users/christianweinrich/Source/infrastructure/ansible/playbooks/atlas.yml`
      to include roles only and move inline tasks into
      `/Users/christianweinrich/Source/infrastructure/ansible/roles/atlas_host/tasks/`
- [ ] T012 [US2] Split Atlas host tasks by concern in
      `/Users/christianweinrich/Source/infrastructure/ansible/roles/atlas_host/tasks/`
      (`main.yml`, `packages.yml`, `docker_config.yml`, `hardware.yml`,
      `services.yml`, `containers.yml`)
- [ ] T013 [US2] Refactor
      `/Users/christianweinrich/Source/infrastructure/ansible/playbooks/site.yml`
      to orchestrate the base, Atlas host, and Hermes gateway roles only
- [ ] T014 [P] [US2] Add clear English responsibility comments in
      `/Users/christianweinrich/Source/infrastructure/ansible/roles/hermes_gateway/tasks/main.yml`
      and `/Users/christianweinrich/Source/infrastructure/ansible/roles/atlas_host/tasks/main.yml`

**Checkpoint**: Roles own the task logic and playbooks act only as orchestration
entry points.

---

## Phase 5: User Story 3 - Reliable Documentation (Priority: P3)

**Goal**: Provide reliable, safe, and current documentation for Atlas host and
Hermes gateway automation.

**Independent Test**: Follow the documentation for a selected playbook and
identify prerequisites, run order, expected outcomes, and rollback steps.

### Implementation for User Story 3

- [ ] T015 [US3] Document prerequisites, run order, expected outcomes,
      validation, and rollback in
      `/Users/christianweinrich/Source/infrastructure/docs/ansible/atlas-hermes-runbook.md`
- [ ] T016 [US3] Update
      `/Users/christianweinrich/Source/infrastructure/ansible/README.md` to reflect
      the SOC task split, entry playbooks, and the script mapping reference
- [ ] T017 [US3] Update
      `/Users/christianweinrich/Source/infrastructure/README.md` to link to the
      Atlas host and Hermes gateway automation docs in `docs/ansible/`

**Checkpoint**: Documentation clearly explains safe usage and reflects the
current automation layout.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Quality, safety, and consistency across all stories

- [ ] T018 [P] Ensure English comments are present and clear in all touched
      automation files under `/Users/christianweinrich/Source/infrastructure/ansible/`
- [ ] T019 Run `ansible-lint` and `yamllint` against
      `/Users/christianweinrich/Source/infrastructure/ansible/` and fix findings
- [ ] T020 Update
      `/Users/christianweinrich/Source/infrastructure/specs/001-ansible-playbook-roles/inventory.md`
      with completion notes and any remaining follow-ups

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - blocks all stories
- **User Stories (Phases 3-5)**: Depend on Foundational completion
- **Polish (Phase 6)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: No dependencies after Foundational
- **User Story 2 (P2)**: No dependencies after Foundational
- **User Story 3 (P3)**: No dependencies after Foundational

### Parallel Execution Examples

- **US1**: T004, T005, T006, T007, T008 can run in parallel after T003
- **US2**: T010, T012, T014 can run in parallel once T009 and T011 define
  role boundaries
- **US3**: T015, T016, T017 can run in parallel once the refactor is complete

## Implementation Strategy

- Deliver MVP by completing User Story 1 first to establish traceable script
  usage and reduce operational risk early.
- Proceed with User Story 2 to enforce SOC and reduce maintenance risk.
- Finish with User Story 3 to ensure documentation matches the new structure
  and safe run procedures.
