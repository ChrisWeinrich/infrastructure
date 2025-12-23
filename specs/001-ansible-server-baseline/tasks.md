---

description: "Task list for Ansible server baseline"
---

# Tasks: Ansible Server Baseline

**Input**: Design documents from `/specs/001-ansible-server-baseline/`
**Prerequisites**: plan.md (required), spec.md (required for user stories),
research.md, data-model.md, contracts/

**Tests**: Tests are OPTIONAL and are not required for this feature.

**Organization**: Tasks are grouped by user story to enable independent
implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Single project**: `ansible/` and `docs/` at repository root
- Paths shown below assume the structure in plan.md

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [X] T001 Create server baseline docs index in `docs/servers/README.md`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story
can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [X] T002 Document single-source config policy in `ansible/README.md`

**Checkpoint**: Foundation ready - user story implementation can now begin in
parallel

---

## Phase 3: User Story 1 - Document the server baseline (Priority: P1) 🎯 MVP

**Goal**: Capture the server MAC address and baseline details in a minimal
README

**Independent Test**: `docs/servers/<hostname>.md` contains MAC address, server
configuration summary, and base server information

### Implementation for User Story 1

- [ ] T003 [US1] Create baseline README at `docs/servers/<hostname>.md`
- [ ] T004 [US1] Record MAC address and baseline details in
  `docs/servers/<hostname>.md`

**Checkpoint**: User Story 1 is fully functional and independently testable

---

## Phase 4: User Story 2 - Define a single configuration source of truth
(Priority: P2)

**Goal**: Create the single main YAML file with per-machine and router
configuration

**Independent Test**: `ansible/configs/base-config.yml` contains hostname, IP,
and MAC entries for each server plus router network configuration

### Implementation for User Story 2

- [ ] T005 [US2] Create main configuration file at
  `ansible/configs/base-config.yml`
- [ ] T006 [P] [US2] Populate per-machine entries in
  `ansible/configs/base-config.yml`
- [ ] T007 [P] [US2] Add router network configuration section in
  `ansible/configs/base-config.yml`

**Checkpoint**: User Story 2 is fully functional and independently testable

---

## Phase 5: User Story 3 - Register the server on the router (Priority: P3)

**Goal**: Register the server and assign a hostname on the OpenWrt router

**Independent Test**: Router registration playbook reads from the main YAML and
creates the MAC-to-hostname mapping

### Implementation for User Story 3

- [ ] T008 [US3] Add router registration playbook at
  `ansible/playbooks/openwrt-register-server.yml` using
  `ansible/configs/base-config.yml`
- [ ] T009 [US3] Add hostname assignment logic in
  `ansible/playbooks/openwrt-register-server.yml`

**Checkpoint**: User Story 3 is fully functional and independently testable

---

## Phase 6: User Story 4 - Run a baseline automation check (Priority: P4)

**Goal**: Run an Ansible "Hello World" using the hostname from the main YAML

**Independent Test**: The "Hello World" playbook targets the hostname from the
main YAML and completes successfully

### Implementation for User Story 4

- [ ] T010 [US4] Add "Hello World" playbook at
  `ansible/playbooks/hello-world.yml` using `ansible/configs/base-config.yml`
- [ ] T011 [P] [US4] Add README note on the "Hello World" validation in
  `ansible/README.md`

**Checkpoint**: User Story 4 is fully functional and independently testable

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T012 [P] Update `docs/index.md` with server baseline workflow summary
- [ ] T013 [P] Update `README.md` with the base config YAML pre-step
- [ ] T014 Run quickstart validation in
  `specs/001-ansible-server-baseline/quickstart.md`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user
  stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User stories can then proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P3 → P4)
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No
  dependencies on other stories
- **User Story 2 (P2)**: Can start after Foundational (Phase 2) - No
  dependencies on other stories
- **User Story 3 (P3)**: Depends on User Story 2 completion (requires base
  config YAML data)
- **User Story 4 (P4)**: Depends on User Story 2 and 3 completion (requires
  hostname and router registration)

### Within Each User Story

- Documentation before configuration
- Configuration before router registration
- Router registration before "Hello World" validation

### Parallel Opportunities

- Setup and Foundational tasks can be completed quickly before story work
- User Stories 1 and 2 can proceed in parallel after Foundational tasks
- Polish tasks marked [P] can run in parallel after story completion

---

## Parallel Example: User Story 1

```bash
Task: "Create baseline README at docs/servers/<hostname>.md"
Task: "Record MAC address and baseline details in docs/servers/<hostname>.md"
```

## Parallel Example: User Story 2

```bash
Task: "Populate per-machine entries in ansible/configs/base-config.yml"
Task: "Add router network configuration section in ansible/configs/base-config.yml"
```

## Parallel Example: User Story 3

```bash
Task: "Add router registration playbook at ansible/playbooks/openwrt-register-server.yml"
Task: "Add hostname assignment logic in ansible/playbooks/openwrt-register-server.yml"
```

## Parallel Example: User Story 4

```bash
Task: "Add Hello World playbook at ansible/playbooks/hello-world.yml"
Task: "Add README note on the Hello World validation in ansible/README.md"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1
4. **STOP and VALIDATE**: Test User Story 1 independently
5. Deploy/demo if ready

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test independently → Deploy/Demo (MVP!)
3. Add User Story 2 → Test independently → Deploy/Demo
4. Add User Story 3 → Test independently → Deploy/Demo
5. Add User Story 4 → Test independently → Deploy/Demo
6. Each story adds value without breaking previous stories

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: User Story 1
   - Developer B: User Story 2
   - Developer C: User Story 3
   - Developer D: User Story 4
3. Stories complete and integrate independently

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Avoid: vague tasks, same file conflicts, cross-story dependencies that break
  independence
