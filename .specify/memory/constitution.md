<!--
Sync Impact Report:
- Version change: 1.2.0 -> 1.2.1
- Modified principles: I. Infrastructure-as-Code First -> I. Infrastructure-as-Code First
- Added sections: None
- Removed sections: None
- Templates requiring updates:
  - .specify/templates/plan-template.md ✅ updated
  - .specify/templates/spec-template.md ✅ updated
  - .specify/templates/tasks-template.md ✅ updated
- Follow-up TODOs: None
-->
# Infrastructure Constitution

## Core Principles

### I. Infrastructure-as-Code First
- All router and network configuration MUST be expressed in Ansible and/or
  OpenWrt configuration files committed to version control.
- Router configuration MUST be applied from those configuration files; do not
  mix config sync with ad-hoc UCI write commands in automation. UCI is for
  read-only verification or emergency recovery only.
- Manual changes are emergency-only, logged, and MUST be codified in IaC within
  the next change window.
Rationale: IaC enables repeatable, reviewable changes and reliable recovery.

### II. Safety-First Network Changes
- Every change MUST include explicit rollback steps and validation checks.
- Changes MUST avoid lockouts by preserving out-of-band access and safe apply
  paths (staged rollout or maintenance window as appropriate).
Rationale: Network changes are high-risk and require safe recovery paths.

### III. Idempotency & Drift Control
- Automation MUST be idempotent and safe to re-run without unintended changes.
- Drift MUST be detected and remediated through IaC; ad-hoc fixes are not
  permitted.
Rationale: Idempotency and drift control keep infrastructure consistent.

### IV. Cited Assumptions
- Router, OpenWrt, and Ansible specifics MUST cite authoritative sources in
  docs or code comments; no undocumented assumptions.
- Router-specific guidance MUST first consult the primary router reference
  before other sources.
Rationale: Cited sources reduce ambiguity and prevent tribal knowledge.

### V. Commented Code & Configurations
- All code, scripts, configs, and YAML files MUST include comments that make
  each step, function, class, or block understandable at a glance.
- Comments MUST be in English; update touched comments to comply.
Rationale: Clear English comments speed reviews and reduce operational risk.

### VI. English Documentation
- All documentation MUST be in English, including runbooks and change records.
Rationale: English documentation ensures consistent team understanding.

### VII. Markdown Hard-Wrap at 80 Columns
- Markdown prose MUST be hard-wrapped at 80 characters; code blocks are exempt.
Rationale: Consistent wrapping improves diffs and readability.

### VIII. Documentation & README Sync
- Changes that affect behavior, operation, or usage MUST update relevant files
  under `docs/` and any existing README.md in the repository.
Rationale: Users rely on docs and READMEs to operate and validate changes.

## Operational Standards

- Infrastructure changes MUST be made through Ansible/OpenWrt configurations
  and kept under version control with clear change history.
- Router configuration MUST be applied via repo-managed config files; avoid
  mixing config sync with UCI write changes in automation.
- Change proposals MUST include a safety plan, rollback steps, and validation
  criteria before and after applying changes.
- Assumptions and device-specific behavior MUST be documented with sources.
- Code, scripts, configs, and YAML files MUST be commented so each step,
  function, class, or block is immediately understandable.
- Primary router reference (consult first for router-specific guidance):
  https://github.com/gl-inet/docs4.x/blob/master/docs/user_guide/gl-mt6000/index.md
- Core reference for Ansible/OpenWrt:
  https://github.com/gekmihesg/ansible-openwrt
- Management access endpoints and methods MUST be documented (IP/hostname,
  protocol, authentication, and location).
- Idempotency and drift detection MUST be validated as part of change delivery.
- Changes affecting behavior or usage MUST update `docs/` and README.md when
  present.

## Review & Change Control

- Every change MUST be peer-reviewed with an explicit Constitution Check.
- Rollback steps, pre-change backups, and post-change verification are required
  for network-affecting updates.
- When feasible, changes SHOULD be validated in a lab or staging environment
  before production rollout.

## Governance

- This constitution supersedes other guidance; conflicts MUST be resolved in
  favor of these rules.
- Amendments require a documented rationale, impact assessment, and updates to
  all dependent templates.
- Versioning follows semantic versioning: MAJOR for incompatible removals or
  redefinitions, MINOR for new principles/sections, PATCH for clarifications.
- Compliance is mandatory: reviewers MUST verify adherence in plans, specs,
  tasks, and code review; exceptions require written approval and risk notes.

**Version**: 1.2.1 | **Ratified**: 2025-12-20 | **Last Amended**: 2025-12-27
