# Data Model

## Entities

### Router

- **Fields**:
  - id (stable identifier in inventory)
  - model (GL-MT6000)
  - management_endpoint (IP/hostname)
  - firmware_version
  - upstream_uplink_type (repeater/WISP)
- **Relationships**:
  - has many Configuration Snapshots
  - has one Desired Configuration

### Configuration Snapshot

- **Fields**:
  - router_id
  - captured_at
  - files (network, wireless, firewall, dhcp, system)
  - checksum_set
- **Relationships**:
  - belongs to Router

### Desired Configuration

- **Fields**:
  - router_id
  - version
  - files (network, wireless, firewall, dhcp, system)
  - last_applied_at
- **Relationships**:
  - belongs to Router

### Verification Checklist

- **Fields**:
  - router_id
  - created_at
  - steps (ordered)
  - results (pass/fail per step)
- **Relationships**:
  - references a Desired Configuration version

### Recovery Plan

- **Fields**:
  - router_id
  - created_at
  - steps (ordered)
  - prerequisites (physical access, ethernet)
- **Relationships**:
  - references a Desired Configuration version

## Validation Rules

- Snapshot files MUST include the five `/etc/config` files identified in the
  feature spec.
- Desired Configuration MUST preserve WISP uplink behavior unless explicitly
  superseded by a future feature.
- Verification Checklist MUST include DNS resolution and external reachability
  checks.
- Recovery Plan MUST include a vendor reset/repair step as last resort.

## State Transitions

- Configuration Snapshot: `planned` -> `captured` -> `verified`.
- Verification Checklist: `draft` -> `executed` -> `recorded`.
