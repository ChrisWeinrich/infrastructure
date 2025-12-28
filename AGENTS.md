# Repository Guidelines

## Project Structure & Module Organization

- `ansible/` holds automation assets: `playbooks/`, `roles/`, `configs/`, `vars/`, and `inventories/` (primary inventory: `ansible/inventories/home/hosts.yml`).
- `ansible/scripts/` contains the standard entry points for running playbooks.
- `docs/` contains MkDocs content; `mkdocs.yml` is the site configuration.
- `snapshots/` stores captured state artifacts used by runbooks.

## Build, Test, and Development Commands

- `pip install -r requirements-docs.txt`: install MkDocs and doc tooling.
- `npm ci`: install Markdown lint dependencies.
- `pre-commit install`: enable repo hooks for YAML, Ansible, and formatting.
- `pre-commit run --all-files`: run yamllint, ansible-lint, and formatting checks.
- `npm run lint:md -- "**/*.md"`: lint Markdown with markdownlint-cli2.
- `mkdocs build --strict`: validate and build documentation.
- When running `ansible/scripts/*`, start with a 1-minute timeout and extend only if needed.

## Coding Style & Naming Conventions

- YAML and Ansible files use 2-space indentation; keep lines <= 120 chars (see `.yamllint.yml`).
- Format with Prettier when applicable (via pre-commit).
- Prefer descriptive, kebab-case names for playbooks and roles (e.g., `apply-server.yml`, `usb-drives`).
- Comments are mandatory for non-obvious steps and should explain intent, not restate the code.
- Apply SOC/SRP: keep each role, playbook, and script focused on a single responsibility.

## Testing Guidelines

- There are no unit tests in this repo; quality gates are linting and documentation builds.
- Run `pre-commit run --all-files` and `mkdocs build --strict` before opening a PR.
- For OpenWrt changes, follow verification steps in `docs/runbooks/` (see `openwrt-verification.md`).

## Commit & Pull Request Guidelines

- Commit messages are short, imperative, and topic-focused (e.g., “Update OpenWrt playbook tasks for hosts”).
- PRs should include a clear description, affected areas (playbooks, runbooks, inventories), and any related issue links.
- If a change affects usage or behavior, update `docs/` and `README.md` accordingly.
- Avoid risky or irreversible changes; obtain explicit approval before any destructive operations.

## Constitution & AGENTS

- The constitution defines non-negotiable rules; `AGENTS.md` is the repo-specific guide.
- If guidance conflicts, follow the constitution and update `AGENTS.md` for alignment.

## Security & Configuration Tips

- Keep secrets out of the repository; follow `docs/runbooks/openwrt-secrets.md` for credential handling.
- Inventory and host-specific settings live under `ansible/inventories/` and `ansible/configs/`; avoid hardcoding secrets in playbooks.

## Active Technologies
- Ansible (YAML), Bash (POSIX shell) + Ansible, GitHub Actions runner, Docker engine, Tailscale (network reachability) (002-self-hosted-runner)
- Host filesystem for runner state, logs, and job artifacts (002-self-hosted-runner)

- Ansible (YAML), Bash (POSIX shell) + Ansible, OpenWrt UCI, Docker/Container runtime on hos (001-jellyfin-container)
- Host filesystem paths for USB mounts and persistent metadata (001-jellyfin-container)

## Recent Changes

- 001-jellyfin-container: Added Ansible (YAML), Bash (POSIX shell) + Ansible, OpenWrt UCI, Docker/Container runtime on hos
