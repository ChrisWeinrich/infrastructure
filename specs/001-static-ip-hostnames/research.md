# Research: Static IP and Hostnames

## Decision 1: Use repository-managed OpenWrt configuration via Ansible

- **Decision**: Use repo-managed Ansible automation to apply OpenWrt UCI
  changes for IP addressing and hostnames.
- **Rationale**: Aligns with IaC, idempotency, and drift control while using
  supported automation patterns.
- **Alternatives considered**: Manual router UI changes (rejected due to drift
  risk and non-repeatability).
- **References**:
  - https://github.com/gekmihesg/ansible-openwrt

## Decision 2: Anchor router assumptions on the GL-MT6000 reference

- **Decision**: Validate router behaviors and defaults against the GL-MT6000
  user guide.
- **Rationale**: Constitution requires primary router reference for
  router-specific assumptions.
- **Alternatives considered**: Vendor forums or secondary guides (rejected as
  non-authoritative).
- **References**:
  - https://github.com/gl-inet/docs4.x/blob/master/docs/user_guide/gl-mt6000/index.md

## Decision 3: Central configuration layout mirrors network structure

- **Decision**: Central configuration is organized by site, networks, devices,
  and addressing to match the real topology.
- **Rationale**: Directly supports the requirement for a human-readable source
  that maps to the network structure.
- **Alternatives considered**: Flat key-value layout (rejected due to poor
  discoverability and higher error risk).
