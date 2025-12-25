# Ansible Layout Migration Runbook

## Purpose

Define the steps, validation, and rollback process for migrating automation
assets into the canonical `ansible/` layout.

## Preconditions

- Ensure the canonical directory tree exists under `ansible/`.
- Ensure placeholder files exist for required inventories, roles, playbooks,
  scripts, and shared vars.
- Confirm the migration plan in `/specs/001-ansible-layout/` is current.

## Migration Steps

1. Inventory legacy automation content outside `ansible/`.
2. Copy or move inventories into `ansible/inventories/home/`.
3. Copy or move roles into `ansible/roles/` and keep task files organized.
4. Copy or move playbooks into `ansible/playbooks/`.
5. Copy or move scripts into `ansible/scripts/`.
6. Copy or move shared vars into `ansible/vars/constants.yml`.
7. Record each move with a before/after path and checksum for validation.

## Validation

- Verify every required path exists under `ansible/`.
- Compare checksums between source and destination for each migrated asset.
- Confirm no automation assets remain outside `ansible/`.
- Run lint gates (ansible-lint, yamllint) from the repository root.

## Rollback

- Revert moved files to their original locations using the migration record.
- Restore original files from git history if needed.
- Re-run validation to confirm the repository matches the pre-migration state.

## Migration Checklist

- [ ] Canonical directory tree exists under `ansible/`.
- [ ] Inventories moved to `ansible/inventories/home/`.
- [ ] Roles moved to `ansible/roles/`.
- [ ] Playbooks moved to `ansible/playbooks/`.
- [ ] Scripts moved to `ansible/scripts/`.
- [ ] Shared vars moved to `ansible/vars/constants.yml`.
- [ ] Checksums recorded for migrated assets.
- [ ] No automation assets remain outside `ansible/`.
- [ ] Lint gates pass from repo root.
