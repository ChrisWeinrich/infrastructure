<!-- Sync Impact Report
Version change: N/A (template) -> 1.0.0
Modified principles: [PRINCIPLE_1_NAME] -> I. Risk Avoidance First; [PRINCIPLE_2_NAME] -> II. SOC & SRP Mandatory; [PRINCIPLE_3_NAME] -> III. Documentation Always Updated; [PRINCIPLE_4_NAME] -> IV. Comments Explain Intent; [PRINCIPLE_5_NAME] -> V. Constitution Primacy
Added sections: Safety & Architecture Requirements; Development Workflow & Quality Gates
Removed sections: None
Templates requiring updates: ✅ updated .specify/templates/plan-template.md; ✅ updated .specify/templates/tasks-template.md
Follow-up TODOs: TODO(RATIFICATION_DATE) - adoption date not recorded
-->
# Infrastructure Repository Constitution

## Core Principles

### I. Risk Avoidance First
Do not take risky or irreversible actions. Prefer reversible changes, minimal
blast radius, and explicit approval before any destructive operations (e.g.,
force deletes, forced rewrites, or production-impacting changes).

### II. SOC & SRP Mandatory
Separation of Concerns and Single Responsibility Principle are non-negotiable.
Each module, role, playbook, or script must have one clear responsibility; do
not mix unrelated concerns in the same unit.

### III. Documentation Always Updated
Documentation must be updated whenever behavior, usage, configuration, or
runbooks change. Changes are incomplete until the corresponding docs are
updated in `docs/` and/or `README.md`.

### IV. Comments Explain Intent
Comments are mandatory for non-obvious logic and must explain intent or
constraints rather than restating the code.

### V. Constitution Primacy
This constitution defines non-negotiable rules. `AGENTS.md` is the contributor
guide for how to work in this repository. If there is a conflict, the
constitution prevails.

## Safety & Architecture Requirements
- Prefer safe defaults and least-privilege changes.
- Require an explicit risk check in plans and reviews for sensitive changes.
- Keep responsibilities separated across roles, playbooks, and scripts.

## Development Workflow & Quality Gates
- Reviews must confirm compliance with the Core Principles.
- Linting and documentation builds are required quality gates.
- Documentation updates are required when behavior, usage, or runbooks change.

## Governance
This constitution supersedes all other practices. Amendments require a PR with
rationale, impact summary, and any necessary migration steps. Versioning follows
semantic versioning: MAJOR for incompatible policy shifts, MINOR for new or
materially expanded rules, PATCH for clarifications. Every PR must verify
compliance with the Core Principles and note any risks explicitly.

**Version**: 1.0.0 | **Ratified**: TODO(RATIFICATION_DATE): adoption date unknown | **Last Amended**: 2025-12-27
