# Phase 1 Quickstart: Repository foundation (linting, docs, CI)

## Purpose

Run the same linting and documentation checks locally as CI.

## Prerequisites

- Pre-commit installed locally.
- MkDocs installed locally with required theme and plugins.

## Run all checks

```bash
pre-commit run --all-files
mkdocs build --strict
```

## Notes

- Use the same commands before opening a pull request.
- CI runs the same checks on push and pull_request.
