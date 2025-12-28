# Implementation Plan: Self-hosted GitHub Runner MVP

**Branch**: `002-self-hosted-runner` | **Date**: 2025-12-27 | **Spec**: /Users/christianweinrich/Source/infrastructure/specs/002-self-hosted-runner/spec.md
**Input**: Feature specification from `/specs/002-self-hosted-runner/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

Deliver an MVP self-hosted GitHub Actions runner on the internal server that can execute build jobs using existing Ansible automation patterns for install, configuration, and runbook documentation.

## Technical Context

**Language/Version**: Ansible (YAML), Bash (POSIX shell)  
**Primary Dependencies**: Ansible, GitHub Actions runner, Docker engine, Tailscale (network reachability)  
**Storage**: Host filesystem for runner state, logs, and job artifacts  
**Testing**: `pre-commit run --all-files`, `mkdocs build --strict`  
**Target Platform**: Linux server in the home VLAN managed via Ansible (atlas-host)  
**Project Type**: Infrastructure automation (Ansible playbooks, roles, scripts)  
**Performance Goals**: Jobs start within 2 minutes; deployments complete within 5 minutes per target  
**Constraints**: Least-privilege changes, single-runner POC, secrets stored outside the repo  
**Scale/Scope**: Single runner, single VLAN, single operator

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- No-risk posture: avoid irreversible/destructive actions without explicit approval.
- SOC/SRP compliance: each module or role has one clear responsibility.
- Documentation updates required for behavior, usage, or runbook changes.
- Comments required for non-obvious logic to explain intent.
- Constitution governs; `AGENTS.md` is implementation guidance.

## Project Structure

### Documentation (this feature)

```text
specs/002-self-hosted-runner/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
ansible/
├── playbooks/
│   └── apply-server.yml
├── roles/
│   ├── apps/
│   │   └── github-runner/        # New role for runner install/config
│   └── host/
│       └── docker/
├── inventories/
│   └── home/hosts.yml
├── configs/
└── scripts/
    └── run_atlas.sh

docs/
└── runbooks/
    └── github-runner-mvp.md      # New runbook for setup/ops
```

**Structure Decision**: Use the existing Ansible layout by adding a focused `apps/github-runner` role and wiring it into `ansible/playbooks/apply-server.yml`, with a dedicated runbook under `docs/runbooks/` for setup and operational steps.

## Complexity Tracking

No constitution violations requiring justification.
