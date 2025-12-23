---

description: "Task list for feature implementation"
---

# Tasks: Tailscale Router Access

**Input**: Design documents from
`/Users/christianweinrich/Source/infrastructure/specs/`
`003-tailscale-router-access/`
**Prerequisites**: plan.md (required), spec.md (required), research.md,
 data-model.md, contracts/, quickstart.md

**Tests**: Tests are optional and not requested for this feature.

**Organization**: Tasks are grouped by user story to enable independent
implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [ ] T001 Create Tailscale UCI config file at
  ansible/configs/openwrt/tailscale

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story
can be implemented

- [ ] T002 Update
  ansible/inventory/openwrt/group_vars/all.yml to add Tailscale variables and
  include `tailscale` in `openwrt_uci_files`
- [ ] T003 Add DCLI secret reference for the Tailscale auth key in
  ansible/inventory/openwrt/group_vars/all.yml and document the lookup command
  in ansible/README.md
- [ ] T004 Manually create a Tailscale auth key per
  docs/runbooks/openwrt-secrets.md and store it in DCLI
- [ ] T005 Manually approve advertised routes and ACL access per
  docs/runbooks/openwrt-apply.md in the Tailscale admin console
- [ ] T006 Create install task in
  ansible/playbooks/tasks/install-tailscale.yml to install the package and
  enable the service
- [ ] T007 Update ansible/playbooks/apply-openwrt.yml to include
  tasks/install-tailscale.yml before configuration apply
- [ ] T008 Update ansible/playbooks/verify-openwrt.yml to assert Tailscale is
  running and to record advertised routes

**Checkpoint**: Foundation ready - user story implementation can now begin

---

## Phase 3: User Story 1 - Remote Access to Server (Priority: P1) 🎯 MVP

**Goal**: Enable remote access to 192.168.8.135 from outside the LAN

**Independent Test**: From an external network, an authorized user can reach
192.168.8.135 and an unauthorized user is blocked

### Implementation for User Story 1

- [ ] T009 [US1] Populate ansible/configs/openwrt/tailscale with auth key
  reference and route 192.168.8.135/32
- [ ] T010 [US1] Create configuration task in
  ansible/playbooks/tasks/configure-tailscale.yml to run `tailscale up` with
  the server-only route
- [ ] T011 [US1] Update ansible/playbooks/apply-openwrt.yml to include
  tasks/configure-tailscale.yml after install
- [ ] T012 [US1] Update docs/runbooks/openwrt-verification.md with an external
  check for 192.168.8.135 access
- [ ] T013 [US1] Update docs/runbooks/openwrt-recovery.md with rollback steps
  to disable Tailscale and restore prior state

**Checkpoint**: User Story 1 is independently functional and verifiable

---

## Phase 4: User Story 2 - Remote Access to LAN (Priority: P2)

**Goal**: Enable remote access to multiple LAN hosts in 192.168.8.0/24

**Independent Test**: From an external network, an authorized user can reach
at least two distinct LAN hosts within 192.168.8.0/24

### Implementation for User Story 2

- [ ] T014 [US2] Update
  ansible/inventory/openwrt/group_vars/all.yml to advertise
  192.168.8.0/24 instead of 192.168.8.135/32
- [ ] T015 [US2] Create ansible/configs/openwrt/firewall with a Tailscale zone
  and forwarding rules to the LAN
- [ ] T016 [US2] Update docs/runbooks/openwrt-verification.md to include
  multi-host access checks and subnet-overlap guidance

**Checkpoint**: User Stories 1 and 2 both work independently

---

## Phase 5: User Story 3 - Persistent and Documented Access (Priority: P3)

**Goal**: Keep access persistent across restarts and well documented

**Independent Test**: After a router reboot, access still works and docs
describe management access and verification steps

### Implementation for User Story 3

- [ ] T017 [US3] Update docs/runbooks/openwrt-apply.md with Tailscale apply
  steps and management access endpoints
- [ ] T018 [US3] Update docs/runbooks/openwrt-secrets.md with DCLI secret
  handling and storage guidance
- [ ] T019 [US3] Update README.md with a remote access overview and links to
  runbooks

**Checkpoint**: All user stories are independently functional and documented

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T020 [P] Update docs/index.md to link the new Tailscale runbook content
- [ ] T021 Run quickstart validation and sync steps in
  specs/003-tailscale-router-access/quickstart.md

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user
  stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2)
- **User Story 2 (P2)**: Can start after Foundational (Phase 2); depends on
  US1 for baseline Tailscale setup
- **User Story 3 (P3)**: Can start after Foundational (Phase 2)

### Parallel Opportunities

- T002 and T003 can run in parallel (different files)
- T009 and T010 can run in parallel (different runbooks)
- T014, T015, and T016 can run in parallel (documentation updates)
- T017 can run in parallel with documentation tasks in Phase 5

---

## Parallel Example: User Story 1

```bash
Task: "Populate ansible/configs/openwrt/tailscale with auth key reference and
route 192.168.8.135/32"
Task: "Create configuration task in
ansible/playbooks/tasks/configure-tailscale.yml to run tailscale up"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational
3. Complete Phase 3: User Story 1
4. Validate remote access to 192.168.8.135 from an external network

### Incremental Delivery

1. Setup + Foundational → Foundation ready
2. Add User Story 1 → Validate access to 192.168.8.135
3. Add User Story 2 → Validate access to multiple LAN hosts
4. Add User Story 3 → Validate persistence and documentation

### Parallel Team Strategy

- One developer handles Tailscale installation and configuration tasks
- Another developer updates documentation and verification runbooks
