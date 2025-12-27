---
description: "Task list template for feature implementation"
---

# Tasks: Jellyfin First Container

**Input**: Design documents from `/specs/001-jellyfin-container/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, contracts/

**Tests**: The examples below include test tasks. Tests are OPTIONAL - only include them if explicitly requested in the feature specification.
**Documentation**: Updates are REQUIRED when behavior, usage, or runbooks change.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [x] T001 Confirm current nginx app usage and identify removal points in `ansible/playbooks/apply-server.yml`
- [x] T002 Inventory and document existing VLAN40 config in `ansible/roles/openwrt/uci/files/openwrt/` before changes
- [x] T003 [P] Confirm USB disk mount points and IDs used by host in `ansible/roles/host/hardware/`
- [x] T004 [P] Define base path for container metadata persistence in `ansible/vars/` (new or existing file)

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T005 Remove nginx app inclusion from `ansible/playbooks/apply-server.yml`
- [x] T006 Add Jellyfin role scaffold at `ansible/roles/apps/jellyfin/` (defaults, tasks, templates as needed)
- [x] T007 Add shared container volume base path variable in `ansible/vars/` and wire into host setup
- [x] T008 Ensure VLAN40 addressing (192.168.40.0/24) is reflected in `ansible/roles/openwrt/uci/files/openwrt/` configs

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Jellyfin Zugriff vom Achilles-Device (Priority: P1) 🎯 MVP

**Goal**: Jellyfin ist nur vom Achilles-Device erreichbar.

**Independent Test**: Zugriff von Achilles ist erlaubt; alle anderen Clients werden blockiert.

### Implementation for User Story 1

- [x] T009 [P] Add MAC allowlist rule for Achilles in `ansible/roles/openwrt/uci/files/openwrt/` firewall config
- [x] T010 [P] Add Jellyfin service address mapping for 192.168.40.3 in `ansible/roles/openwrt/uci/files/openwrt/` if required
- [x] T011 [US1] Apply OpenWrt role changes in `ansible/playbooks/apply-openwrt.yml`

**Checkpoint**: Achilles can reach Jellyfin; other devices are blocked

---

## Phase 4: User Story 2 - Medienbibliothek aus zwei USB-Platten (Priority: P2)

**Goal**: Jellyfin nutzt genau zwei USB-Platten als Medienquellen.

**Independent Test**: Medien von beiden Platten sind sichtbar und abspielbar.

### Implementation for User Story 2

- [x] T012 [P] Define exact media mount paths in `ansible/vars/` for Jellyfin inputs
- [x] T013 [P] Update `ansible/roles/host/hardware/` to ensure both mounts are present
- [x] T014 [US2] Configure Jellyfin media volumes in `ansible/roles/apps/jellyfin/tasks/main.yml`

**Checkpoint**: Jellyfin media library shows content from both disks

---

## Phase 5: User Story 3 - Zentrale Metadaten-Persistenz (Priority: P3)

**Goal**: Metadaten liegen zentral und persistent fuer einfache Backups.

**Independent Test**: Metadaten bleiben nach Neustart erhalten und sind aus zentralem Pfad wiederherstellbar.

### Implementation for User Story 3

- [x] T015 [P] Define metadata base path for all containers in `ansible/vars/`
- [x] T016 [P] Ensure metadata directory exists and permissions are set in `ansible/roles/host/hardware/` or `ansible/roles/host/docker/`
- [x] T017 [US3] Bind Jellyfin metadata volume to base path in `ansible/roles/apps/jellyfin/tasks/main.yml`

**Checkpoint**: Jellyfin metadata persists across restarts

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [x] T018 [P] Update runbook references in `docs/runbooks/` for Jellyfin deployment and access control
- [x] T019 [P] Update `docs/index.md` and `README.md` to reflect Jellyfin as first container
- [ ] T020 Run `pre-commit run --all-files` and `mkdocs build --strict` from repo root

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User stories can then proceed in parallel (if staffed)
  - Or sequentially in priority order (P1 → P2 → P3)
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories
- **User Story 2 (P2)**: Can start after Foundational (Phase 2) - May integrate with US1 but should be independently testable
- **User Story 3 (P3)**: Can start after Foundational (Phase 2) - May integrate with US1/US2 but should be independently testable

### Within Each User Story

- Models/variables before service wiring
- Service wiring before playbook inclusion
- Story complete before moving to next priority

### Parallel Opportunities

- All Setup tasks marked [P] can run in parallel
- All Foundational tasks marked [P] can run in parallel (within Phase 2)
- Once Foundational phase completes, all user stories can start in parallel (if team capacity allows)
- All tasks within a story marked [P] can run in parallel

---

## Parallel Example: User Story 1

```bash
# Run OpenWrt firewall allowlist change in parallel with service address mapping
Task: "Add MAC allowlist rule for Achilles in ansible/roles/openwrt/uci/files/openwrt/ firewall config"
Task: "Add Jellyfin service address mapping for 192.168.40.3 in ansible/roles/openwrt/uci/files/openwrt/ if required"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational (CRITICAL - blocks all stories)
3. Complete Phase 3: User Story 1
4. **STOP and VALIDATE**: Verify Achilles-only access
5. Deploy/demo if ready

### Incremental Delivery

1. Complete Setup + Foundational → Foundation ready
2. Add User Story 1 → Test independently → Deploy/Demo (MVP!)
3. Add User Story 2 → Test independently → Deploy/Demo
4. Add User Story 3 → Test independently → Deploy/Demo
5. Each story adds value without breaking previous stories

### Parallel Team Strategy

With multiple developers:

1. Team completes Setup + Foundational together
2. Once Foundational is done:
   - Developer A: User Story 1
   - Developer B: User Story 2
   - Developer C: User Story 3
3. Stories complete and integrate independently
