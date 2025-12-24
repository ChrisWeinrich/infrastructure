# Research: Ansible Repository Layout

## Decision 1: Preserve existing Ansible/OpenWrt tooling stack

- **Decision**: Keep Ansible playbooks, OpenWrt UCI snapshots, and the
  `gekmihesg.openwrt` role as the canonical automation stack.
- **Rationale**: The repository already standardizes on these tools and the
  constitution mandates cited references for router/OpenWrt behavior.
- **Alternatives considered**: Replacing automation with other IaC tools or
  custom scripts was rejected to avoid rewriting established workflows.

## Decision 2: Keep linting and pre-commit gates

- **Decision**: Retain pre-commit, ansible-lint, and yamllint as validation
  gates for the restructured repository.
- **Rationale**: These gates provide consistent checks for YAML quality and
  Ansible best practices, aligning with idempotency and review requirements.
- **Alternatives considered**: Removing linting gates was rejected due to
  increased risk of configuration drift and review overhead.

## Decision 3: Model the layout as a filesystem contract

- **Decision**: Treat the canonical layout as a filesystem contract with
  explicit required paths and placeholder files.
- **Rationale**: The feature goal is structural consistency and migration
  fidelity, which is best represented as a formal layout contract.
- **Alternatives considered**: Relying on informal conventions was rejected
  because it does not provide testable guarantees.
