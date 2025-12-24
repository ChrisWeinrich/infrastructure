---
description: "Task list template for feature implementation"
---

# Tasks: Repository foundation (linting, docs, CI)

**Input**: Design documents from `/specs/001-repo-foundation/`
**Prerequisites**: plan.md (required), spec.md (required for user stories),
research.md, data-model.md, contracts/

**Tests**: Tests are optional for this feature; linting and docs build checks
serve as validation.

**Organization**: Tasks are grouped by user story to enable independent
implementation and validation.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Repository scaffolding and baseline configuration files

- [x] T001 Create `.gitignore` with common tooling patterns in
      `/Users/christianweinrich/Source/infrastructure/.gitignore`
- [x] T002 [P] Add Ansible scaffold README in
      `/Users/christianweinrich/Source/infrastructure/ansible/README.md`
- [x] T003 [P] Add Ansible scaffold directories with placeholders:
      `/Users/christianweinrich/Source/infrastructure/ansible/playbooks/.gitkeep`,
      `/Users/christianweinrich/Source/infrastructure/ansible/roles/.gitkeep`,
      `/Users/christianweinrich/Source/infrastructure/ansible/inventory/.gitkeep`

---

## Phase 2: User Story 2 - Run checks locally (Priority: P2)

**Goal**: Provide reproducible local linting and docs build commands

**Independent Test**: Run the documented commands locally and confirm success

### Configuration

- [x] T010 Add pre-commit hooks with pinned revisions in
      `/Users/christianweinrich/Source/infrastructure/.pre-commit-config.yaml`
- [x] T011 [P] Add YAML lint config in
      `/Users/christianweinrich/Source/infrastructure/.yamllint.yml`
- [x] T012 [P] Add Ansible lint config in
      `/Users/christianweinrich/Source/infrastructure/.ansible-lint.yml`
- [x] T013 [P] Add Markdown lint config in
      `/Users/christianweinrich/Source/infrastructure/.markdownlint-cli2.yaml`
- [x] T014 Add pinned Markdown lint tool versions in
      `/Users/christianweinrich/Source/infrastructure/package.json` and
      `/Users/christianweinrich/Source/infrastructure/package-lock.json`
- [x] T015 Add pinned MkDocs tool versions in
      `/Users/christianweinrich/Source/infrastructure/requirements-docs.txt`
- [x] T016 Add local verification instructions in
      `/Users/christianweinrich/Source/infrastructure/README.md`

---

## Phase 3: User Story 3 - Provide initial documentation (Priority: P3)

**Goal**: Create a documentation site entry point

**Independent Test**: Build docs and open the generated index page

- [x] T020 Add MkDocs configuration in
      `/Users/christianweinrich/Source/infrastructure/mkdocs.yml`
- [x] T021 [P] Add initial docs index page in
      `/Users/christianweinrich/Source/infrastructure/docs/index.md`

---

## Phase 4: User Story 1 - Prevent regressions via CI (Priority: P1)

**Goal**: Run all checks in CI on push and pull_request

**Independent Test**: Introduce a lint violation and confirm CI fails

- [x] T030 Add GitHub Actions workflow in
      `/Users/christianweinrich/Source/infrastructure/.github/workflows/ci.yml`
      with least-privilege permissions and no secrets for fork PRs

---

## Phase N: Polish & Cross-Cutting Concerns

**Purpose**: Consistency and documentation updates

- [x] T040 Ensure all new documentation is English and hard-wrapped at 80
      characters in `/Users/christianweinrich/Source/infrastructure/docs/index.md`
      and `/Users/christianweinrich/Source/infrastructure/README.md`
