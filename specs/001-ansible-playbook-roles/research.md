# Research: Playbook Role Refactor

## Decision 1: Canonical layout source of truth

- Decision: Use `ansible/README.md` as the authoritative layout and entry
  point definition for Atlas host and Hermes gateway automation.
- Rationale: The README documents the intended structure and guardrails and is
  required by the constitution for layout changes.
- Alternatives considered: Infer structure from existing files only. Rejected
  because the README is the explicit contract and keeps changes aligned.

## Decision 2: Playbook entry points and scripts

- Decision: Maintain playbooks as orchestration-only entry points and link
  scripts in `ansible/scripts/` directly to those playbooks.
- Rationale: Separation of concerns keeps task logic inside roles and makes
  scripts safe, predictable entry points.
- Alternatives considered: Embed tasks in playbooks for speed. Rejected due to
  SOC and maintainability requirements.

## Decision 3: Role task structure

- Decision: Split role tasks by concern (packages, networking, hardware,
  services, containers) using the names in `ansible/README.md`.
- Rationale: Consistent structure speeds reviews, reduces drift, and supports
  idempotent changes.
- Alternatives considered: Single monolithic task files. Rejected because it
  hides responsibilities and increases risk.

## Decision 4: Documentation coverage

- Decision: Update `docs/`, `README.md`, and `ansible/README.md` when behavior
  or entry points change, and include script-to-playbook mappings.
- Rationale: The constitution requires synced docs and clear operator guidance.
- Alternatives considered: Update only one README. Rejected due to constitution
  requirements and operator safety.
