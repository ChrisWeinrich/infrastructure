# Feature Specification: Repository foundation (linting, docs, CI)

**Feature Branch**: `001-repo-foundation`
**Created**: 2025-12-20
**Status**: Draft
**Input**: User description:
"/prompts::speckit.specify Write Spec 001: Repository foundation (linting,
docs, CI). Goals: - Add YAML linting, Markdown linting, and Ansible linting.
- Add docs/ that renders via MkDocs and builds in CI (strict). - Add a minimal
ansible/ scaffold. - Run checks locally and in GitHub Actions CI. Acceptance
criteria: - CI runs on push + pull_request and fails on violations. - MkDocs
build succeeds with strict mode in CI. - docs/ contains an initial index page.
- Linting configs are reproducible and pinned where appropriate."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Prevent regressions via CI (Priority: P1)

As a maintainer, I want automated checks on every change so issues are caught
before merge.

**Why this priority**: Preventing regressions and broken documentation is the
primary value of the foundation work.

**Independent Test**: Open a pull request with a lint violation and confirm the
CI check fails and reports the issue.

**Acceptance Scenarios**:

1. **Given** a pull request with invalid YAML, **When** CI runs, **Then** the
   linting check fails and blocks merge.
2. **Given** a pull request that introduces a documentation warning, **When**
   the docs build runs in strict mode, **Then** the build fails.

---

### User Story 2 - Run checks locally (Priority: P2)

As a contributor, I want a documented local workflow to run the same checks so
I can fix issues before pushing.

**Why this priority**: Local feedback reduces iteration time and CI churn.

**Independent Test**: Follow the documented steps to run all checks locally and
observe a pass on a clean working tree.

**Acceptance Scenarios**:

1. **Given** a clean workspace, **When** I run the documented checks locally,
   **Then** linting and docs build complete successfully.

---

### User Story 3 - Provide initial documentation (Priority: P3)

As a reader, I want an initial documentation entry point so the repository is
understandable.

**Why this priority**: A minimal docs entry is required for future expansion.

**Independent Test**: View the generated documentation site and verify the
index page renders.

**Acceptance Scenarios**:

1. **Given** the documentation site build completes, **When** I open the index
   page, **Then** I can read the initial content.

---

### Edge Cases

- Linting on empty or placeholder files does not crash and reports clear
  failures.
- Documentation build fails when warnings are present (strict mode).
- CI handles pull requests from forks without exposing secrets.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The repository MUST include linting for YAML, Markdown, and
  Ansible content.
- **FR-002**: Linting configurations and tool versions MUST be pinned or
  otherwise reproducible.
- **FR-003**: The documentation site MUST be built with MkDocs in strict mode
  during CI.
- **FR-004**: CI MUST run on push and pull_request events and fail on
  violations.
- **FR-005**: The repository MUST include a minimal `ansible/` scaffold to
  organize automation assets.
- **FR-006**: The repository MUST include a `docs/` directory with an initial
  index page.
- **FR-007**: The same checks MUST be runnable locally with documented steps.
- **FR-008**: CI MUST run safely on fork pull requests without using secrets.

## Assumptions & Sources *(mandatory)*

- GitHub Actions is the CI platform, per the feature request.
- MkDocs is the documentation generator, per the feature request.
- Node.js/npm is used only to pin and run markdownlint-cli2.
- No router/OpenWrt device specifics are required for this feature; therefore no
  external citations are needed here.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% of pushes and pull requests trigger automated checks.
- **SC-002**: Invalid YAML, Markdown, or Ansible content causes CI to fail
  consistently.
- **SC-003**: Documentation builds complete in strict mode without warnings.
- **SC-004**: Contributors can run the full check suite locally in under
  5 minutes on a standard development machine.
