# Tasks: Atlas Host Container VLAN

**Input**: Design documents from
`/Users/christianweinrich/Source/infrastructure/specs/001-docker-vlan-nginx/`
**Prerequisites**: plan.md (required), spec.md (required for user stories),
research.md, data-model.md, contracts/, quickstart.md

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [X] T001 Review scope and priorities in specs/001-docker-vlan-nginx/spec.md
- [X] T002 Review implementation plan in specs/001-docker-vlan-nginx/plan.md

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story
can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [X] T003 [P] Add VLAN 40 and hostname data to ansible/configs/network.yml
- [X] T004 [P] Add VLAN rollback/validation notes to docs/runbooks/network-config.md
- [X] T005 [P] Add hostname access notes to docs/runbooks/openwrt-tailscale.md
- [X] T006 [P] Add VLAN service reference to docs/index.md

**Checkpoint**: Foundation ready - user story implementation can now begin

---

## Phase 3: User Story 1 - Provision isolated service network (Priority: P1) 🎯

**Goal**: Install Docker/Compose, create VLAN 40 interface on atlas-host, and
run hello world nginx on the isolated network.

**Independent Test**: Apply playbooks and confirm VLAN interface is up on
atlas-host and service responds on the VLAN subnet.

### Implementation for User Story 1

- [X] T007 [US1] Add Docker Engine and Compose install tasks in ansible/playbooks/apply-server.yml
- [X] T008 [US1] Add VLAN 40 interface tasks in ansible/playbooks/apply-server.yml
- [X] T009 [US1] Add macvlan network and nginx container tasks in ansible/playbooks/apply-server.yml
- [X] T010 [US1] Add VLAN/container validation tasks in ansible/playbooks/apply-server.yml
- [X] T011 [P] [US1] Add server rollback steps in docs/runbooks/network-config.md

**Checkpoint**: User Story 1 is functional and testable independently

---

## Phase 4: User Story 2 - Provide access from LAN and remote admin (Priority: P2)

**Goal**: Enable LAN and Tailscale access to the service via hostname.

**Independent Test**: From a LAN client and a Tailscale client, resolve the
hostname and receive the hello world response.

### Implementation for User Story 2

- [X] T012 [US2] Add VLAN 40 routing/firewall tasks in ansible/playbooks/apply-openwrt.yml
- [X] T013 [US2] Add DHCP/DNS hostname tasks in ansible/playbooks/apply-openwrt.yml
- [X] T014 [US2] Add routing/DNS validation in ansible/playbooks/verify-openwrt.yml
- [X] T015 [P] [US2] Add LAN/Tailscale validation steps in docs/runbooks/openwrt-tailscale.md

**Checkpoint**: User Stories 1 and 2 work independently

---

## Phase 5: User Story 3 - Repeatable provisioning (Priority: P3)

**Goal**: Ensure re-running automation does not duplicate resources.

**Independent Test**: Run playbooks twice and confirm no duplicate VLAN
interfaces, networks, or DNS entries are created.

### Implementation for User Story 3

- [ ] T016 [US3] Add idempotency assertions for server VLAN/containers in ansible/playbooks/apply-server.yml
- [ ] T017 [P] [US3] Add idempotency assertions for VLAN/DNS in ansible/playbooks/apply-openwrt.yml
- [ ] T018 [P] [US3] Add repeat-run validation in ansible/playbooks/verify-openwrt.yml

**Checkpoint**: All user stories are independently functional

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [ ] T019 [P] Update docs/index.md with VLAN and service access links
- [ ] T020 Ensure English comments in ansible/playbooks/apply-server.yml
- [ ] T021 Ensure English comments in ansible/playbooks/apply-openwrt.yml
- [ ] T022 Ensure English comments in ansible/playbooks/verify-openwrt.yml
- [ ] T023 Ensure English comments in docs/runbooks/network-config.md
- [ ] T024 Ensure English comments in docs/runbooks/openwrt-tailscale.md
- [ ] T025 Update specs/001-docker-vlan-nginx/quickstart.md after validation

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user
  stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
- **Polish (Phase 6)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2)
- **User Story 2 (P2)**: Can start after Foundational (Phase 2)
- **User Story 3 (P3)**: Can start after Foundational (Phase 2)

### Parallel Opportunities

- T003, T004, T005, T006 can run in parallel (different files)
- T011 and T015 can run in parallel with other story tasks (docs only)
- T017 and T018 can run in parallel (different files)
- T019 can run in parallel with other polish tasks (docs only)

---

## Parallel Example: User Story 1

```bash
Task: "Add Docker Engine and Compose install tasks in ansible/playbooks/apply-server.yml"
Task: "Add VLAN 40 interface tasks in ansible/playbooks/apply-server.yml"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup
2. Complete Phase 2: Foundational
3. Complete Phase 3: User Story 1
4. Stop and validate User Story 1 independently

### Incremental Delivery

1. Complete Setup + Foundational
2. Add User Story 1 → Validate
3. Add User Story 2 → Validate
4. Add User Story 3 → Validate
5. Update polish tasks
