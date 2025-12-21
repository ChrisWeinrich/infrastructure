# Phase 0 Research

## Decisions

### Decision: Use Ansible `gekmihesg.openwrt` with UCI-driven changes

**Rationale**: The role is designed for OpenWrt management without requiring
Python on the router and aligns with the safety and idempotency requirements.

**Alternatives considered**: Raw SSH scripts, manual LuCI changes, or custom
playbooks without a dedicated role.

**Sources**:

```
https://github.com/gekmihesg/ansible-openwrt
```

### Decision: Baseline snapshots by fetching /etc/config files

**Rationale**: Capturing `network`, `wireless`, `firewall`, `dhcp`, and `system`
provides a focused, read-only baseline for recovery while avoiding intrusive
backups.

**Alternatives considered**: Full sysupgrade backups or filesystem tarballs.

### Decision: Staged apply with explicit verification and recovery

**Rationale**: Network changes carry a lockout risk; applying changes in small
increments with checks and a documented recovery plan minimizes downtime and
supports safe rollback.

**Alternatives considered**: Single-pass full configuration replacement without
intermediate validation.

### Decision: Preserve WISP/repeater behavior as the default uplink

**Rationale**: The current operational requirement is to maintain WISP uplink
and NATed LAN access while migrating to IaC.

**Alternatives considered**: Switching to Ethernet WAN or altering subnet/NAT
behavior.

**Sources**:

```
https://github.com/gl-inet/docs4.x/blob/master/docs/user_guide/gl-mt6000/index.md
```
