# Phase 0 Research: Repository foundation (linting, docs, CI)

## Decisions

### Decision: Use pre-commit for local lint hooks

**Rationale**: Pre-commit provides a consistent, reproducible way to run hooks
locally and in CI with pinned revisions.
**Alternatives considered**: Custom shell scripts; make targets only.

### Decision: Use markdownlint-cli2 for Markdown linting

**Rationale**: markdownlint-cli2 is widely used, supports config files, and can
be run both locally and in CI.
**Alternatives considered**: markdownlint (v1), vale, custom lint rules.

### Decision: Use MkDocs with Material theme

**Rationale**: MkDocs is simple for documentation sites and Material offers a
clean, well-documented theme that is widely adopted.
**Alternatives considered**: Sphinx, Docusaurus, plain Markdown only.

### Decision: Use GitHub Actions for CI

**Rationale**: Repository already targets GitHub; Actions provides native
workflows for linting and docs builds.
**Alternatives considered**: GitLab CI, CircleCI.

### Decision: Pin linting tool versions where possible

**Rationale**: Pinned versions improve reproducibility and reduce CI variability.
**Alternatives considered**: Floating latest versions.
