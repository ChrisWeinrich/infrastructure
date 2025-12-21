# Implementation Plan: Repository foundation (linting, docs, CI)

**Branch**: `001-repo-foundation` | **Date**: 2025-12-20 | **Spec**:
`/Users/christianweinrich/Source/infrastructure/specs/001-repo-foundation/spec.md`
**Input**: Feature specification from
`/specs/001-repo-foundation/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See
`.specify/templates/commands/plan.md` for the execution workflow.

## Summary

Establish repository foundations for linting and documentation: add pre-commit
hooks for YAML and Ansible linting, markdownlint-cli2 for Markdown, and MkDocs
(with Material theme) for docs, plus GitHub Actions CI to run all checks and
fail on violations.

## Technical Context

**Language/Version**: N/A (repo-level tooling)
**Primary Dependencies**: pre-commit, yamllint, ansible-lint,
markdownlint-cli2, MkDocs, mkdocs-material, Node.js (for markdownlint-cli2)
**Storage**: N/A
**Testing**: Linting and documentation build checks
**Target Platform**: GitHub Actions (Ubuntu runner)
**Project Type**: Single repository with config/docs
**Performance Goals**: N/A
**Constraints**: Pinned tool versions, strict docs build, 80-column Markdown
wrap
**Scale/Scope**: Repository foundation for linting and docs

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- IaC only: router/network changes expressed in Ansible/OpenWrt configs and
  committed to version control.
- Safety-first: rollback steps, pre/post validation, and safe access path are
  defined for network changes.
- Idempotency: automation is idempotent.
- Assumptions are documented with citations for router/OpenWrt/Ansible
  specifics.
- Code comments and documentation are in English; Markdown prose hard-wraps at
  80 characters.

**Gate status**: Pass. This work adds tooling and docs only; no network changes.

**Post-design check**: Pass. No changes affecting network or device behavior.

## Project Structure

### Documentation (this feature)

```text
/Users/christianweinrich/Source/infrastructure/specs/001-repo-foundation/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command)
```

### Source Code (repository root)

```text
/Users/christianweinrich/Source/infrastructure/
├── .github/workflows/ci.yml
├── .pre-commit-config.yaml
├── .yamllint.yml
├── .ansible-lint.yml
├── .markdownlint-cli2.yaml
├── mkdocs.yml
├── docs/
│   └── index.md
└── ansible/
    └── README.md
```

**Structure Decision**: Single repo with config, docs, and Ansible scaffold
files at the root.

## Planned Changes

- Add or update lint configs for YAML, Ansible, and Markdown.
- Add MkDocs config and initial documentation.
- Add minimal Ansible scaffold structure and README.
- Add GitHub Actions workflow for pre-commit and MkDocs strict build.
- Document local verification commands.

## Local Verification Commands

- `pre-commit run --all-files`
- `mkdocs build --strict`

## Complexity Tracking

No Constitution Check violations; complexity tracking not required.
