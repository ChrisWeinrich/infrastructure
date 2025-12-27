---
description: "Task list template for feature implementation"
---

# Tasks: Ansible Repository Layout

**Input**: Design documents from `/specs/001-ansible-layout/`
**Prerequisites**: plan.md (required), spec.md (required for user stories),
research.md, data-model.md, contracts/

**Tests**: No explicit test tasks requested in the feature specification.

**Organization**: Tasks are grouped by user story to enable independent
implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [x] T001 Create canonical directory tree and placeholders under `ansible/`
- [x] T002 [P] Add layout reference in `ansible/README.md`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story
can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T003 Create migration runbook in `docs/runbooks/ansible-layout.md`
- [x] T004 Document rollback and validation steps in
      `docs/runbooks/ansible-layout.md`
- [x] T005 [P] Add migration checklist to `docs/runbooks/ansible-layout.md`

**Checkpoint**: Foundation ready - user story implementation can now begin in
parallel

---

## Phase 3: User Story 1 - Canonical Layout Enforcement (Priority: P1) 🎯 MVP

**Goal**: Ensure all automation assets live under the canonical `ansible/`
structure with required placeholders.

**Independent Test**: Repository scan confirms all required paths exist and no
automation files remain outside `ansible/`.

### Implementation for User Story 1

- [x] T006 [US1] Enforce canonical inventories at
      `ansible/inventories/home/`
- [x] T007 [US1] Enforce canonical roles under `ansible/roles/`
- [x] T008 [US1] Enforce canonical playbooks under `ansible/playbooks/`
- [x] T009 [US1] Enforce canonical scripts under `ansible/scripts/`
- [x] T010 [US1] Enforce shared vars at `ansible/vars/constants.yml`
- [x] T011 [US1] Ensure `ansible/ansible.cfg` and `ansible/requirements.yml`
      exist as placeholders if missing

**Checkpoint**: User Story 1 fully functional and independently testable

---

## Phase 4: User Story 2 - Safe Migration of Existing Content (Priority: P2)

**Goal**: Move all legacy automation content into canonical locations without
loss.

**Independent Test**: Migrated files match source content and no legacy files
remain outside `ansible/`.

### Implementation for User Story 2

- [x] T012 [US2] Migrate inventories into `ansible/inventories/home/`
- [x] T013 [US2] Migrate role content into `ansible/roles/`
- [x] T014 [US2] Migrate playbooks into `ansible/playbooks/`
- [x] T015 [US2] Migrate scripts into `ansible/scripts/`
- [x] T016 [US2] Migrate shared vars into `ansible/vars/constants.yml`
- [x] T017 [US2] Record migration verification in
      `docs/runbooks/ansible-layout.md`

**Checkpoint**: User Story 2 fully functional and independently testable

---

## Phase 5: User Story 3 - Standardized Entry Points (Priority: P3)

**Goal**: Provide standard run scripts and container-specific entry points.

**Independent Test**: Standard run scripts exist and each container deployment
has a matching `run_container_<name>.sh` script.

### Implementation for User Story 3

- [x] T018 [US3] Ensure standard entry scripts exist in `ansible/scripts/`:
      `run_site.sh`, `run_gateway.sh`, `run_atlas.sh`, `run_tag.sh`
- [x] T019 [US3] Create container run scripts named
      `ansible/scripts/run_container_<name>.sh` for each container definition in
      `ansible/roles/atlas_host/containers/*.yml`
- [x] T020 [US3] Document container script naming in
      `ansible/roles/atlas_host/containers/README.md`

**Checkpoint**: All user stories should now be independently functional

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [x] T021 [P] Update `docs/index.md` with the canonical layout location
- [x] T022 [P] Update `README.md` with the canonical layout and entry points
- [x] T023 [P] Update `ansible/README.md` with container script conventions
- [x] T024 Ensure comments explain each step in updated YAML and scripts

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

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No
  dependencies on other stories
- **User Story 2 (P2)**: Can start after Foundational (Phase 2) - May reference
  US1 structure but remains independently testable
- **User Story 3 (P3)**: Can start after Foundational (Phase 2) - Depends on
  canonical script locations defined in US1

### Within Each User Story

- Establish canonical paths before moving files
- Migration validation after each content move
- Story complete before moving to next priority

### Parallel Opportunities

- Setup tasks marked [P] can run in parallel
- Foundational tasks marked [P] can run in parallel
- Polish tasks marked [P] can run in parallel

---

## Parallel Example: User Story 1

```bash
# Enforce canonical structure for different areas in parallel:
Task: "Enforce canonical inventories at ansible/inventories/home/"
Task: "Enforce canonical roles under ansible/roles/"
Task: "Enforce canonical playbooks under ansible/playbooks/"
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
2. Add User Story 1 → Test independently → Deploy/Demo (MVP)
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

---

## Notes

- [P] tasks = different files, no dependencies
- [Story] label maps task to specific user story for traceability
- Each user story should be independently completable and testable
- Stop at any checkpoint to validate story independently
- Avoid: vague tasks, same file conflicts, cross-story dependencies that break
  independence
