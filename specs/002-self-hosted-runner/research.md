# Research: Self-hosted GitHub Runner MVP

**Date**: 2025-12-27
**Spec**: /Users/christianweinrich/Source/infrastructure/specs/002-self-hosted-runner/spec.md

## Findings

### Decision: Automate runner setup via Ansible role and playbook

- **Rationale**: The repository already manages host configuration with Ansible roles and `apply-server.yml`, so adding a focused role keeps SOC/SRP and reuse consistent.
- **Alternatives considered**: Manual installation on the host (rejected due to drift risk and lack of repeatability).

### Decision: Use Docker engine on the runner for build and deploy steps

- **Rationale**: Build workflows require container execution, and the server is already managed with Docker roles; this matches the MVP requirement.
- **Alternatives considered**: Host-native builds without containers (rejected due to workflow constraints and parity issues).

### Decision: Use existing Tailscale/OpenWrt routing for VLAN reachability

- **Rationale**: The repository already documents Tailscale setup for network routing; reusing it avoids new connectivity patterns for the POC.
- **Alternatives considered**: Direct VLAN access without overlay routing (rejected due to limited remote access and operational risk).

### Decision: Store runner registration tokens and deploy credentials outside the repo

- **Rationale**: Repository guidance requires secrets to stay out of version control and already uses dcli paths for secrets.
- **Alternatives considered**: Storing secrets in inventory files (rejected due to security policy).

### Decision: Keep audit data minimal and host-local for MVP

- **Rationale**: The MVP needs basic job visibility without introducing new data stores or services.
- **Alternatives considered**: External logging/monitoring system (deferred for later scope).
