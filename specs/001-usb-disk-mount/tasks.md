# Tasks: Atlas USB Disk Mounts

**Input**: Design documents from
`/Users/christianweinrich/Source/infrastructure/specs/001-usb-disk-mount/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/,
quickstart.md

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Confirm the playbook scope and baseline structure.

- [x] T001 Confirm Atlas scope and annotate playbook header in
      `ansible/playbooks/apply-server.yml`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Shared prerequisites required by all user stories.

- [x] T002 Add variables block for partition UUIDs and mount paths in
      `ansible/playbooks/apply-server.yml`
- [x] T003 Add rollback notes and operator guidance comments in
      `ansible/playbooks/apply-server.yml`

**Checkpoint**: Foundation ready - user story implementation can begin.

---

## Phase 3: User Story 1 - Always-on USB mounts (Priority: P1) 🎯 MVP

**Goal**: Ensure both partitions mount automatically on every boot.

**Independent Test**: Reboot Atlas and confirm both partitions are mounted at
their configured mount paths.

### Implementation for User Story 1

- [x] T004 [US1] Ensure mount directories exist for both partitions in
      `ansible/playbooks/apply-server.yml`
- [x] T005 [US1] Add mount tasks using UUIDs for both partitions in
      `ansible/playbooks/apply-server.yml`
- [x] T006 [US1] Add idempotency comments and safe defaults for mount options in
      `ansible/playbooks/apply-server.yml`

**Checkpoint**: User Story 1 is functional and independently testable.

---

## Phase 4: User Story 2 - Verify mount availability (Priority: P2)

**Goal**: Provide a clear way to confirm mounts and write access.

**Independent Test**: Run the playbook and verify mount status plus a
read/write check at each mount path.

### Implementation for User Story 2

- [x] T007 [US2] Add mount status checks for both partitions in
      `ansible/playbooks/apply-server.yml`
- [x] T008 [US2] Add read/write verification tasks for each mount in
      `ansible/playbooks/apply-server.yml`
- [x] T009 [US2] Add operator-facing status output in
      `ansible/playbooks/apply-server.yml`

**Checkpoint**: User Story 2 is functional and independently testable.

---

## Phase 5: User Story 3 - Graceful handling of missing disk (Priority: P3)

**Goal**: Keep Atlas operational and report missing mounts clearly.

**Independent Test**: Boot without the USB disk and confirm the playbook reports
missing mounts without failing the run.

### Implementation for User Story 3

- [x] T010 [US3] Add non-fatal checks for missing partitions in
      `ansible/playbooks/apply-server.yml`
- [x] T011 [US3] Add conditional messaging for unavailable mounts in
      `ansible/playbooks/apply-server.yml`

**Checkpoint**: User Story 3 is functional and independently testable.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Documentation and validation updates.

- [x] T012 [P] Document Atlas USB mount usage and validation steps in
      `docs/atlas-usb-mounts.md`
- [x] T013 [P] Update Ansible usage notes in `ansible/README.md`
- [x] T014 Run the quickstart validation steps and record any corrections in
      `/Users/christianweinrich/Source/infrastructure/specs/001-usb-disk-mount/quickstart.md`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies.
- **Foundational (Phase 2)**: Depends on Setup completion.
- **User Stories (Phase 3+)**: Depend on Foundational completion.
- **Polish (Phase 6)**: Depends on desired user stories.

### User Story Dependencies

- **US1**: No dependencies after Foundational.
- **US2**: No dependencies after Foundational.
- **US3**: No dependencies after Foundational.

### Parallel Opportunities

- T012 and T013 can run in parallel (different files).
- Story phases can run in parallel after Foundational if staffed, but most work
  touches `ansible/playbooks/apply-server.yml` and should be sequenced to avoid
  merge conflicts.

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1 and Phase 2.
2. Complete Phase 3 (US1).
3. Validate mounts after reboot.

### Incremental Delivery

1. Add US2 validation tasks after US1 is stable.
2. Add US3 graceful handling once mount checks are verified.
3. Finish documentation and quickstart validation.
