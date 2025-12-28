# Quickstart: Self-hosted GitHub Runner MVP

**Date**: 2025-12-27
**Spec**: /Users/christianweinrich/Source/infrastructure/specs/002-self-hosted-runner/spec.md

## Goal

Bring up a self-hosted GitHub Actions runner on the internal server and validate build + deploy in one pipeline.

## Prerequisites

- `atlas-host` is reachable via Ansible inventory `ansible/inventories/home/hosts.yml`.
- Docker is installed via the existing host role.
- Required secrets are stored in dcli (runner registration token, deploy credentials).
- VLAN routing is configured (see `docs/runbooks/openwrt-tailscale.md`).

## Steps

1. Add runner configuration values in inventory or host vars (labels, runner name, work directory).
2. Store the GitHub runner registration token in dcli at the agreed path.
3. Store deployment credentials in dcli for the approved VLAN target(s).
4. Add the GitHub runner role to `ansible/playbooks/apply-server.yml`.
5. Run the server playbook using `ansible/scripts/run_atlas.sh`.
6. Trigger a GitHub workflow and confirm the job runs on the internal runner.
7. Trigger a pipeline with a deploy stage and verify the target service is reachable.

## Validation

- Runner shows as online in GitHub and can execute a build job.
- Deploy stage completes and the VLAN target is reachable.
- Job audit data is recorded locally for the latest run.
