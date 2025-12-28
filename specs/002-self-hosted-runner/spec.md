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

### User Story 2 - Deploy container workloads into the VLAN (Priority: P2)

As an owner of the internal infrastructure, I want the same pipeline to deploy container workloads into my VLAN so that a full build-and-deploy flow works end-to-end for the POC, including multiple deployment targets when needed.

**Why this priority**: The POC requires deployments to prove the runner can execute real workloads, not just builds.

**Independent Test**: Can be fully tested by running a pipeline with a deployment step and verifying the target service becomes reachable in the VLAN.

**Acceptance Scenarios**:

1. **Given** a pipeline with a deploy stage and one approved deployment target, **When** the pipeline runs, **Then** the container workload is deployed and the target is reachable.
2. **Given** a pipeline with a deploy stage and multiple approved deployment targets, **When** the pipeline runs, **Then** each selected target receives a deployment and reports success or failure independently, and the pipeline fails if any selected target fails.
3. **Given** a deployment target is unreachable, **When** the deploy stage runs, **Then** the pipeline fails clearly and no partial deployment remains active on that target.

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
- How does the system handle a deployment request to an unapproved target?
- What happens when multiple jobs are queued while only one runner is available?
- How does the system handle variable-driven scaling of deployment targets?
- What happens when one target fails during a multi-target deployment?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST allow GitHub.com workflows to dispatch jobs to a self-hosted runner through an authenticated connection.
- **FR-002**: System MUST execute build jobs and report status and logs back to GitHub.com.
- **FR-003**: System MUST support container-based build steps required by the workflows.
- **FR-004**: System MUST allow a pipeline stage to deploy container workloads to pre-approved VLAN targets.
- **FR-005**: System MUST support multi-target deployments in a single pipeline run.
- **FR-006**: System MUST fail the pipeline run if any selected deployment target fails.
- **FR-007**: System MUST allow variable-driven selection or scaling of deployment targets for each run.
- **FR-008**: System MUST restrict deployment actions to explicitly approved targets and credentials.
- **FR-009**: System MUST provide basic runner health visibility (online/offline, last job result).
- **FR-010**: System MUST record minimal audit data per job (timestamp, result, target used).

### Key Entities *(include if feature involves data)*

- **Runner Host**: The internal machine that accepts and executes jobs.
- **Pipeline Job**: A unit of work dispatched from GitHub.com that includes build or deploy steps.
- **Deployment Target**: A VLAN destination where container workloads are deployed.
- **Deployment Target Set**: A selected list of targets for a single pipeline run.
- **Pipeline Run**: A single end-to-end execution that includes build and optional deploy stages.
- **Job Artifact**: Output produced by a build job and used for deployment or validation.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 95% of queued jobs start within 2 minutes when the runner is online.
- **SC-002**: 90% of pipeline runs that include a deploy stage complete end-to-end without manual intervention.
- **SC-003**: 90% of multi-target deploy runs complete all selected targets without manual intervention.
- **SC-004**: The operator can verify runner online/offline status in under 1 minute.
- **SC-005**: Container deployments reach the VLAN target within 5 minutes of pipeline start.

## Clarifications

### Session 2025-12-27

- Q: What should the pipeline do if any selected deployment target fails? → A: Fail the pipeline if any selected target fails.

## Assumptions

- The POC uses a single runner and a single VLAN environment.
- One operator administers runner access and deployment target approvals.
- Multi-target deployment selection is driven by runtime variables defined per pipeline run.
- High availability and multi-runner scaling are out of scope for the MVP.

## Dependencies

- Active GitHub.com account with permissions to register self-hosted runners.
- A secure network path between GitHub.com and the internal VLAN.
- Deployment credentials for the approved VLAN targets.
