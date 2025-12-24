# Quickstart: Ansible Repository Layout

## Purpose

This quickstart explains the standard entry points for running automation once
all content has been migrated into the canonical `./ansible/` layout.

## Standard Entry Points

- `ansible/scripts/run_site.sh`: Run the full site automation.
- `ansible/scripts/run_gateway.sh`: Run gateway-specific automation.
- `ansible/scripts/run_atlas.sh`: Run Atlas host automation.
- `ansible/scripts/run_tag.sh`: Run a tagged subset of automation.

## Operator Checklist

1. Confirm all automation assets live under `./ansible/`.
2. Verify required inventories, roles, and playbooks exist as placeholders if
   empty.
3. Use the standard run scripts under `ansible/scripts/` for consistent
   invocation.
4. Update `docs/` and any README.md if entry points or behavior change.
