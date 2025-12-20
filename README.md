# Infrastructure Repository

Repository foundation for infrastructure automation, linting, and
documentation.

## Local checks

1. Install pre-commit and enable hooks:
   - `pip install pre-commit`
   - `pre-commit install`
2. Install Markdown linting dependencies:
   - `npm ci`
3. Install documentation dependencies:
   - `pip install -r requirements-docs.txt`
4. Run all checks:
   - `pre-commit run --all-files`
   - `npm run lint:md -- "**/*.md"`
   - `mkdocs build --strict`

## Documentation

- Source files live in `docs/`.
- The MkDocs configuration is `mkdocs.yml`.
