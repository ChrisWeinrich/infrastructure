# Feature Specification: Self-hosted GitHub Runner MVP

**Feature Branch**: `002-self-hosted-runner`  
**Created**: 2025-12-27  
**Status**: Draft  
**Input**: User description: "naechster step ist ein selbst hosted github agent der von github.com in meinem netzweg angesteuert werden kann. Bitte erstmal klar den agenten mvp entwickeln, also absolute basis austattung (docker etc.) dann muessen wir mein gh und tails scla konfigureiren und dann gehen wir noch in die detials. Wichtig ist das er build jobs aussfuehren kann, und auch container in mein vlan deployen kann (Wird spaeter noch sauber getrennt, aber fuer POC ist das erstmal gut wenn ich alles in einer pipelien machen kann)"

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Run build jobs on internal runner (Priority: P1)

As an owner of the internal infrastructure, I want GitHub.com workflows to run on a self-hosted runner in my network so that builds run on my hardware and are under my control.

**Why this priority**: This is the core MVP value and unlocks all other pipeline steps.

**Independent Test**: Can be fully tested by triggering a workflow on GitHub.com and confirming the job completes on the internal runner.

**Acceptance Scenarios**:

1. **Given** the runner is online and registered, **When** a GitHub.com workflow is triggered, **Then** the job is picked up by the runner and completes with a reported status.
2. **Given** a workflow includes container-based build steps, **When** the job runs on the runner, **Then** those steps execute successfully and results are reported to GitHub.com.

---

### User Story 3 - Check runner health and access (Priority: P3)

As an owner of the internal infrastructure, I want basic visibility into runner status and access so that I can operate the runner and troubleshoot issues.

**Why this priority**: Basic observability is required to keep the POC reliable and usable.

**Independent Test**: Can be fully tested by changing runner availability and confirming the status is visible to the operator.

**Acceptance Scenarios**:

1. **Given** the runner is online, **When** the operator checks status, **Then** the system shows the runner as available.
2. **Given** the runner is offline, **When** a job is queued, **Then** the job is not run and the offline status is visible to the operator.

---

### Edge Cases

- What happens when the runner loses network connectivity mid-job?
- What happens when multiple jobs are queued while only one runner is available?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST allow GitHub.com workflows to dispatch jobs to a self-hosted runner through an authenticated connection.
- **FR-002**: System MUST execute build jobs and report status and logs back to GitHub.com.
- **FR-003**: System MUST support container-based build steps required by the workflows.
- **FR-009**: System MUST provide basic runner health visibility (online/offline, last job result).
- **FR-010**: System MUST record minimal audit data per job (timestamp, result, target used).

### Key Entities *(include if feature involves data)*

- **Runner Host**: The internal machine that accepts and executes jobs.
- **Pipeline Job**: A unit of work dispatched from GitHub.com that includes build or deploy steps.
- **Pipeline Run**: A single end-to-end execution that includes build and optional deploy stages.
- **Job Artifact**: Output produced by a build job and used for deployment or validation.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 95% of queued jobs start within 2 minutes when the runner is online.
- **SC-004**: The operator can verify runner online/offline status in under 1 minute.

## Clarifications

### Session 2025-12-27

- Q: What should the pipeline do if any selected deployment target fails? → A: Fail the pipeline if any selected target fails.

## Assumptions

- The POC uses a single runner and a single VLAN environment.
- One operator administers runner access and deployment target approvals.
- High availability and multi-runner scaling are out of scope for the MVP.

## Dependencies

- Active GitHub.com account with permissions to register self-hosted runners.
- A secure network path between GitHub.com and the internal VLAN.
