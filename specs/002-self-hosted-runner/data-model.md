# Data Model: Self-hosted GitHub Runner MVP

**Date**: 2025-12-27
**Spec**: /Users/christianweinrich/Source/infrastructure/specs/002-self-hosted-runner/spec.md

## Entities

### Runner Host

- **Description**: Internal machine that executes GitHub Actions jobs.
- **Fields**:
  - `id` (string, unique)
  - `hostname` (string)
  - `labels` (list of strings)
  - `status` (enum: `online`, `offline`)
  - `last_seen_at` (timestamp)
  - `last_job_result` (enum: `success`, `failure`, `cancelled`, `unknown`)
- **Validation Rules**:
  - `hostname` must match inventory host.
  - `status` must be a valid enum value.

### Pipeline Run

- **Description**: One end-to-end execution of a workflow.
- **Fields**:
  - `id` (string, unique)
  - `source` (string, e.g., repo/workflow identifier)
  - `triggered_at` (timestamp)
  - `status` (enum: `queued`, `running`, `success`, `failure`, `cancelled`)
- **Relationships**:
  - Has many `Pipeline Jobs`.
- **Validation Rules**:
  - `triggered_at` must be set when created.

### Pipeline Job

- **Description**: A single unit of work in a pipeline (build or deploy).
- **Fields**:
  - `id` (string, unique)
  - `run_id` (foreign key to Pipeline Run)
  - `job_type` (enum: `build`, `deploy`)
  - `status` (enum: `queued`, `running`, `success`, `failure`, `cancelled`)
  - `started_at` (timestamp)
  - `completed_at` (timestamp)
  - `target_id` (optional, foreign key to Deployment Target)
- **Relationships**:
  - Executed by one `Runner Host`.
  - May reference one `Deployment Target`.
- **Validation Rules**:
  - `job_type` must be a valid enum value.
  - `completed_at` must be >= `started_at` when present.

### Deployment Target

- **Description**: VLAN destination for container deployments.
- **Fields**:
  - `id` (string, unique)
  - `name` (string)
  - `address` (string)
  - `status` (enum: `approved`, `revoked`)
  - `approved_at` (timestamp)
- **Validation Rules**:
  - `address` must be a valid hostname or IP.
  - `status` must be a valid enum value.

### Job Artifact

- **Description**: Output from a build job used by later steps.
- **Fields**:
  - `id` (string, unique)
  - `job_id` (foreign key to Pipeline Job)
  - `name` (string)
  - `created_at` (timestamp)
  - `size_bytes` (integer)
- **Validation Rules**:
  - `size_bytes` must be >= 0.

## State Transitions

- **Runner Host**: `offline` -> `online` -> `offline`
- **Pipeline Run**: `queued` -> `running` -> (`success` | `failure` | `cancelled`)
- **Pipeline Job**: `queued` -> `running` -> (`success` | `failure` | `cancelled`)
- **Deployment Target**: `approved` -> `revoked`
