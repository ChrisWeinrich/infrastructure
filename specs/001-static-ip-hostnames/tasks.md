# Tasks: Static IP and Hostnames

**Input**: Design documents from `/specs/001-static-ip-hostnames/`
**Prerequisites**: plan.md (required), spec.md (required for user stories),
research.md, data-model.md, contracts/

**Tests**: Not requested in the feature specification.

**Organization**: Tasks are grouped by user story to enable independent
implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [x] T001 Create central configuration file skeleton in
      `ansible/configs/network.yml`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story
can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T002 Implement OpenWrt UCI sync tasks in
      `ansible/playbooks/tasks/apply-openwrt-uci.yml`
- [x] T003 Update `ansible/playbooks/apply-openwrt.yml` to include
      `ansible/playbooks/tasks/apply-openwrt-uci.yml`
- [x] T004 [P] Add network conflict validation in
      `ansible/playbooks/tasks/validate-network.yml`
- [x] T005 Update `ansible/playbooks/verify-openwrt.yml` to include
      `ansible/playbooks/tasks/validate-network.yml`
- [x] T006 Update rollback steps for LAN changes in
      `docs/runbooks/openwrt-recovery.md`
- [x] T007 Update validation steps for LAN changes in
      `docs/runbooks/openwrt-apply.md`

**Checkpoint**: Foundation ready - user story implementation can now begin in
parallel

---

## Phase 3: User Story 1 - Stable server address (Priority: P1) 🎯 MVP

**Goal**: The server attached to the router stays at 192.168.1.134

**Independent Test**: Apply the configuration and confirm the server stays at
192.168.1.134 across re-apply and reboot.

### Implementation for User Story 1

- [x] T008 [US1] Define the server address assignment in
      `ansible/configs/network.yml`
- [x] T009 [US1] Add DHCP static lease configuration in
      `ansible/configs/openwrt/dhcp`
- [x] T010 [US1] Update OpenWrt variables to reference the server address in
      `ansible/inventory/openwrt/group_vars/all.yml`

**Checkpoint**: User Story 1 should be fully functional and testable
independently

---

## Phase 4: User Story 2 - Clear hostnames (Priority: P2)

**Goal**: Router hostname is hermes-gateway and server hostname is atlas-host

**Independent Test**: Apply the configuration and verify both hostnames are
reported correctly on the LAN.

### Implementation for User Story 2

- [x] T011 [US2] Define router and server hostnames in
      `ansible/configs/network.yml`
- [x] T012 [US2] Add OpenWrt hostname configuration in
      `ansible/configs/openwrt/system`
- [x] T013 [US2] Wire router hostname variable in
      `ansible/playbooks/apply-openwrt.yml`
- [x] T014 [US2] Add server inventory entries in
      `ansible/inventory/servers/hosts.yml`
- [x] T015 [US2] Add server hostname playbook in
      `ansible/playbooks/apply-server.yml`

**Checkpoint**: User Stories 1 and 2 should both work independently

---

## Phase 5: User Story 3 - Central configuration view (Priority: P3)

**Goal**: A single, readable configuration source mirrors the network
structure

**Independent Test**: Locate the server IP and hostnames in under 2 minutes
using the central configuration file.

### Implementation for User Story 3

- [x] T016 [US3] Expand the site/network/device hierarchy in
      `ansible/configs/network.yml`
- [x] T017 [US3] Document the central configuration layout and management
      endpoints in `docs/runbooks/network-config.md`

**Checkpoint**: All user stories should now be independently functional

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [x] T018 [P] Update `docs/index.md` and `README.md` with the new runbook and
      management endpoints
- [x] T019 Ensure English comments are present in
      `ansible/configs/network.yml`
- [x] T020 Ensure English comments are present in
      `ansible/configs/openwrt/dhcp`
- [x] T021 Ensure English comments are present in
      `ansible/configs/openwrt/system`

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user
  stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User stories can then proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P3)
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - no
  dependencies on other stories
- **User Story 2 (P2)**: Can start after Foundational (Phase 2) - independent
  once shared config and validation are in place
- **User Story 3 (P3)**: Can start after Foundational (Phase 2) - uses the
  same central configuration file as US1/US2

### Within Each User Story

- Configuration source updates before router/server apply
- OpenWrt config files before apply playbooks
- Documentation after configuration changes are drafted

### Parallel Opportunities

- Foundational tasks T002 and T004 can run in parallel
- Documentation tasks T006 and T007 can run in parallel with core config tasks
- Polish tasks T018, T019, T020, T021 can run in parallel

---

## Parallel Example: User Story 2

```bash
Task: "Add OpenWrt hostname configuration in ansible/configs/openwrt/system"
Task: "Add server inventory entries in ansible/inventory/servers/hosts.yml"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1
4. STOP and validate User Story 1 independently

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Validate → Deploy/Demo
3. Add User Story 2 → Validate → Deploy/Demo
4. Add User Story 3 → Validate → Deploy/Demo
5. Run Polish tasks and update docs/README

### Parallel Team Strategy

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: User Story 1
   - Developer B: User Story 2
   - Developer C: User Story 3
3. Stories complete and integrate independently
