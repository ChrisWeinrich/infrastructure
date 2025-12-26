# Data Model: Playbook Role Refactor

## Entities

### Script

- Fields: name, path, entry_point, target_playbook, scope (atlas/hermes),
  description, expected_outcomes
- Relationships: maps to one or more Playbooks
- Validation rules: target_playbook must exist; scope must be atlas or hermes

### Playbook

- Fields: name, path, scope (atlas/hermes/site), roles_included, tags
- Relationships: includes Roles; referenced by Scripts
- Validation rules: only role includes and orchestration logic; no inline tasks

### Role

- Fields: name, path, responsibility, task_files
- Relationships: used by Playbooks
- Validation rules: single responsibility; task files grouped by concern

### Documentation Artifact

- Fields: path, topic, scope (atlas/hermes), last_updated
- Relationships: documents Scripts, Playbooks, and Roles
- Validation rules: includes prerequisites, run order, and safe usage
