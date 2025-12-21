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
  - has many Drift Reports

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

### Drift Report

- **Fields**:
  - router_id
  - compared_at
  - differences (file-level diffs)
  - status (clean, drifted)
- **Relationships**:
  - belongs to Router
  - compares Desired Configuration to live Router Configuration

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
- Drift Report status MUST be `clean` when no diffs are detected and `drifted`
when any file differs.
- Verification Checklist MUST include DNS resolution and external reachability
checks.
- Recovery Plan MUST include a vendor reset/repair step as last resort.

## State Transitions

- Configuration Snapshot: `planned` -> `captured` -> `verified`.
- Drift Report: `pending` -> `generated` -> `reviewed`.
- Verification Checklist: `draft` -> `executed` -> `recorded`.
