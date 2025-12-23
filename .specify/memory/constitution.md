<!--
Sync Impact Report:
- Version change: 1.2.0 -> 1.3.0
- Modified principles: None
- Added sections: X. Naming Conventions for Hosts and Networks
- Removed sections: None
- Templates requiring updates:
  - .specify/templates/plan-template.md ✅ updated
  - .specify/templates/spec-template.md ✅ updated
- Follow-up TODOs: None
-->
# Infrastructure Constitution

## Core Principles

### I. Infrastructure-as-Code First
- All router and network configuration MUST be expressed in Ansible and/or
  OpenWrt configurations committed to version control.
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

### V. English Code Comments
- All code comments MUST be in English; update touched comments to comply.
Rationale: A shared language keeps reviews and maintenance efficient.

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

### IX. Single-Source Ansible Configuration
- All Ansible-related configuration MUST flow through the single main YAML file.
- The main YAML file is the only place where configuration is defined.
- No configuration values may be hidden or stored anywhere else.
Rationale: A single source of truth prevents drift, ambiguity, and hidden state.

### X. Naming Conventions for Hosts and Networks
- Hostnames, SSIDs, and inventory labels MUST follow the Theme + Role format:
  `<theme>-<role>` with optional numeric suffixes (e.g., `io-worker-01`).
- Server names MUST use the Titans theme: `atlas`, `prometheus`, `hermes`,
  `janus`, `hades`, plus a clear role suffix (e.g., `atlas-storage`, `hermes-gw`,
  `janus-fw`).
- Client names MUST use the Heroes theme (e.g., `achilles`, `odysseus`) with
  a role or device qualifier as needed.
- WLAN SSIDs MUST use `olympus`, `styx`, or `asphodel` with role suffixes
  (e.g., `olympus-wifi`, `styx-uplink`).
Rationale: Theme + role names are durable, descriptive, and reduce ambiguity.

## Operational Standards

- Infrastructure changes MUST be made through Ansible/OpenWrt configurations
  and kept under version control with clear change history.
- Change proposals MUST include a safety plan, rollback steps, and validation
  criteria before and after applying changes.
- Assumptions and device-specific behavior MUST be documented with sources.
- Ansible configuration MUST be defined only in the single main YAML file.
- Primary router reference (consult first for router-specific guidance):
  https://github.com/gl-inet/docs4.x/blob/master/docs/user_guide/gl-mt6000/index.md
- Core reference for Ansible/OpenWrt:
  https://github.com/gekmihesg/ansible-openwrt
- Management access endpoints and methods MUST be documented (IP/hostname,
  protocol, authentication, and location).
- Idempotency and drift detection MUST be validated as part of change delivery.
- Changes affecting behavior or usage MUST update `docs/` and README.md when
  present.
- Naming for hosts, SSIDs, and inventory labels MUST follow the Theme + Role
  scheme defined in the Core Principles.

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

**Version**: 1.3.0 | **Ratified**: 2025-12-20 | **Last Amended**: 2025-12-21
