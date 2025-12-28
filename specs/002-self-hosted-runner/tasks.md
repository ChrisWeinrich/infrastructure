---

description: "Task list for Self-hosted GitHub Runner MVP"
---

# Tasks: Self-hosted GitHub Runner MVP

**Input**: Design documents from `/specs/002-self-hosted-runner/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/

**Tests**: Not requested in spec.
**Documentation**: Updates are REQUIRED when behavior, usage, or runbooks change.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [X] T001 Create role skeleton for runner under `ansible/roles/apps/github-runner/` (tasks/, defaults/, templates/, files/)
- [X] T002 [P] Add role metadata in `ansible/roles/apps/github-runner/meta/main.yml`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

- [X] T003 Create runner configuration file at `ansible/configs/github-runner.yml` (runner name, labels, workdir, approved targets)
- [X] T004 Wire runner config into inventory at `ansible/inventories/home/group_vars/servers.yml` (including dcli secret paths)

**Checkpoint**: Foundation ready - user story implementation can now begin

---

## Phase 3: User Story 1 - Run build jobs on internal runner (Priority: P1) 🎯 MVP

**Goal**: Register and run GitHub.com jobs on the internal runner host with container-capable builds.

**Independent Test**: Trigger a workflow and confirm it executes on the runner and reports status in GitHub.com.

### Implementation for User Story 1

- [X] T005 [US1] Confirm runner appears online in GitHub.com settings (Repository or Org: Actions > Runners)
- [X] T006 [P] [US1] Add runner defaults in `ansible/roles/apps/github-runner/defaults/main.yml` (paths, labels, service name)
- [X] T007 [P] [US1] Create install tasks in `ansible/roles/apps/github-runner/tasks/install.yml`
- [X] T008 [P] [US1] Create registration tasks in `ansible/roles/apps/github-runner/tasks/register.yml`
- [X] T009 [P] [US1] Add Compose template in `ansible/roles/apps/github-runner/templates/compose.yml.j2`
- [X] T010 [US1] Wire role tasks in `ansible/roles/apps/github-runner/tasks/main.yml`
- [X] T011 [US1] Add runner role to playbook `ansible/playbooks/apply-server.yml`

**Checkpoint**: User Story 1 is fully functional and independently testable

---

## Phase 5: User Story 3 - Check runner health and access (Priority: P3)

**Goal**: Provide basic status visibility for runner availability and recent job state.

**Independent Test**: Verify the status script reports online/offline state and last job result.

### Implementation for User Story 3

- [ ] T017 [P] [US3] Add status script in `ansible/roles/apps/github-runner/files/runner-status.sh`
- [ ] T018 [US3] Install status script via `ansible/roles/apps/github-runner/tasks/status.yml`
- [ ] T019 [US3] Update role wiring in `ansible/roles/apps/github-runner/tasks/main.yml` to include status setup

**Checkpoint**: User Story 3 is independently functional

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T020 [P] Add runbook at `docs/runbooks/github-runner-mvp.md` (setup, secrets, usage, troubleshooting)
- [ ] T021 [P] Update documentation index `docs/index.md` to link the new runbook
- [ ] T022 [P] Update `mkdocs.yml` nav to include the runner runbook
- [ ] T023 Run linting and docs build (`pre-commit run --all-files`, `mkdocs build --strict`)

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2)
- **User Story 3 (P3)**: Can start after Foundational (Phase 2)

### Parallel Opportunities

- Setup tasks T001 and T002 can run in parallel
- Foundational tasks T003 and T004 can run in parallel
- Within US1: T006, T007, T008, T009 can run in parallel
- Within US3: T017 can run in parallel with other story work
- Documentation updates T020-T022 can run in parallel

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational
3. Complete Phase 3: User Story 1
4. Validate by running a workflow on the runner

### Incremental Delivery

1. Setup + Foundational → Foundation ready
2. User Story 1 → Validate build jobs
3. User Story 3 → Validate status visibility
4. Polish phase → Docs and quality gates
