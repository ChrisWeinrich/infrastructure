# Tasks: OpenWrt WISP IaC

**Input**: Design documents from `specs/002-openwrt-wisp-iac/`
**Prerequisites**: plan.md (required), spec.md (required for user stories),
research.md, data-model.md, contracts/

**Tests**: Not requested for this feature.

**Organization**: Tasks are grouped by user story to enable independent
implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Phase 1: Setup (Connection and Shared Infrastructure)

**Purpose**: Establish management connectivity and project structure

- [ ] T001 Create directories `ansible/playbooks/`, `ansible/inventory/openwrt/`,
  `ansible/configs/openwrt/`, `snapshots/`, and `docs/runbooks/`
- [ ] T002 Create inventory for the router (no Python on target) in
  `ansible/inventory/openwrt/hosts.yml`
- [ ] T003 [P] Add shared inventory variables in
  `ansible/inventory/openwrt/group_vars/all.yml`
- [ ] T004 [P] Declare the OpenWrt role in `ansible/requirements.yml`
- [ ] T005 Document dcli-based secrets usage and SSH key retrieval in
  `docs/runbooks/openwrt-secrets.md`
- [ ] T006 Add SSH connectivity checks using dcli in
  `docs/runbooks/openwrt-verification.md`
- [ ] T007 Define a required positive SSH connection test gate in
  `docs/runbooks/openwrt-verification.md`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can
be implemented

**CRITICAL**: No user story work can begin until this phase is complete

- [ ] T008 Add UCI read checks and client DNS/internet checks to
  `docs/runbooks/openwrt-verification.md`
- [ ] T009 Define recovery and rollback steps in
  `docs/runbooks/openwrt-recovery.md`
- [ ] T010 Implement verification playbook in
  `ansible/playbooks/verify-openwrt.yml`
- [ ] T011 Decide and document the first small declarative change in
  `docs/runbooks/openwrt-apply.md`

**Checkpoint**: Foundation ready - user story implementation can now begin

---

## Phase 3: User Story 1 - Maintain WISP Uplink While Serving LAN (Priority: P1)

**Goal**: Preserve WISP/repeater behavior and NATed LAN access under IaC

**Independent Test**: Apply the desired configuration and validate upstream
Wi-Fi connectivity plus LAN client internet access

### Implementation for User Story 1

- [ ] T012 [US1] Capture desired `network` config in
  `ansible/configs/openwrt/network`
- [ ] T013 [P] [US1] Capture desired `wireless` config in
  `ansible/configs/openwrt/wireless`
- [ ] T014 [P] [US1] Capture desired `firewall` config in
  `ansible/configs/openwrt/firewall`
- [ ] T015 [P] [US1] Capture desired `dhcp` config in
  `ansible/configs/openwrt/dhcp`
- [ ] T016 [P] [US1] Capture desired `system` config in
  `ansible/configs/openwrt/system`
- [ ] T017 [US1] Implement staged apply in `ansible/playbooks/apply-openwrt.yml`
- [ ] T018 [US1] Document staged apply sequence in
  `docs/runbooks/openwrt-apply.md`

**Checkpoint**: User Story 1 is functional and independently testable

---

## Phase 4: User Story 2 - Capture Baseline Before Changes (Priority: P2)

**Goal**: Capture a read-only baseline snapshot for recovery reference

**Independent Test**: Run the snapshot playbook and confirm a timestamped
snapshot appears under `snapshots/<router>/`

### Implementation for User Story 2

- [ ] T019 [US2] Implement read-only snapshot for `/etc/config/*` in
  `ansible/playbooks/snapshot-openwrt.yml`
- [ ] T020 [P] [US2] Document snapshot structure in `snapshots/README.md`

**Checkpoint**: User Story 2 is functional and independently testable

---

## Phase 5: User Story 3 - Safe, Repeatable Changes (Priority: P3)

**Goal**: Provide idempotent apply and recovery guidance

**Independent Test**: Re-apply configuration with zero changes

### Implementation for User Story 3

- [ ] T021 [US3] Implement the first small change idempotently in
  `ansible/playbooks/apply-openwrt.yml`
- [X] T022 [US3] Add pre-apply snapshot capture and delete the snapshot when
  apply results in no changes in `ansible/playbooks/apply-openwrt.yml`
- [X] T023 [US3] Update apply runbook with auto-snapshot behavior in
  `docs/runbooks/openwrt-apply.md`
- [ ] T024 [US3] Verify no lockout after the first change in
  `docs/runbooks/openwrt-verification.md`

**Checkpoint**: User Story 3 is functional and independently testable

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [X] T025 [P] Update `specs/002-openwrt-wisp-iac/quickstart.md` with the
  auto-snapshot apply flow
- [ ] T026 [P] Link runbooks from `docs/index.md`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user
  stories
- **User Stories (Phase 3+)**: Depend on Foundational phase completion
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Starts after Foundational phase
- **User Story 2 (P2)**: Starts after Foundational phase
- **User Story 3 (P3)**: Starts after Foundational phase

### Parallel Opportunities

- Setup tasks T003 and T004 can run in parallel
- User Story 1 tasks T013 to T016 can run in parallel
- User Story 2 task T019 can run in parallel with T018 after prerequisites
- User Story 3 tasks T022 and T023 can run in parallel
- Polish tasks T025 and T026 can run in parallel

---

## Parallel Example: User Story 1

```bash
Task: "Capture desired wireless config in ansible/configs/openwrt/wireless"
Task: "Capture desired firewall config in ansible/configs/openwrt/firewall"
Task: "Capture desired dhcp config in ansible/configs/openwrt/dhcp"
Task: "Capture desired system config in ansible/configs/openwrt/system"
```

## Parallel Example: User Story 2

```bash
Task: "Implement read-only snapshot for /etc/config/* in
ansible/playbooks/snapshot-openwrt.yml"
Task: "Document snapshot structure in snapshots/README.md"
```

## Parallel Example: User Story 3

```bash
Task: "Add pre-apply snapshot capture and delete the snapshot when apply
results in no changes in ansible/playbooks/apply-openwrt.yml"
Task: "Update apply runbook with auto-snapshot behavior in
docs/runbooks/openwrt-apply.md"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational
3. Complete Phase 3: User Story 1
4. Validate WISP uplink and LAN client access

### Incremental Delivery

1. Setup + Foundational
2. User Story 1 → validate
3. User Story 2 → validate
4. User Story 3 → validate
5. Polish tasks

### Parallel Team Strategy

- After Foundational phase completion, User Stories 1 to 3 can be executed in
  parallel by different operators if coordination permits.
