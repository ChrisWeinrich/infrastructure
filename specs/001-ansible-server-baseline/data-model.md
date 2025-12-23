# Phase 1 Data Model: Ansible Server Baseline

## Entities

### Server

**Description**: Represents a physical or virtual server managed in the
baseline process.

**Fields**:
- `hostname` (string, required, unique)
- `ip_address` (string, required)
- `mac_address` (string, required, unique)
- `base_information` (string, required, human-readable summary)
- `baseline_configuration` (string, required, summary of setup state)

**Validation Rules**:
- `hostname`, `ip_address`, and `mac_address` must be present before router
  registration.
- `mac_address` must be formatted consistently across YAML and README.

### Server Baseline README

**Description**: Minimal documentation artifact that records the baseline for a
single server.

**Fields**:
- `mac_address` (string, required)
- `server_configuration` (string, required)
- `base_information` (string, required)

**Validation Rules**:
- All fields must be present before any automation validation.

### Main Configuration YAML

**Description**: Single source of configuration data for servers and router
network settings.

**Fields**:
- `servers` (list, required)
  - `hostname` (string, required)
  - `ip_address` (string, required)
  - `mac_address` (string, required)
  - `manual_values` (map, required)
  - `defined_values` (map, required)
- `router_network` (map, required)
  - `registrations` (list, required)

**Validation Rules**:
- Must include all per-machine entries for hostnames, IPs, and MACs.
- Must include the documented server MAC address in the server list.
- Must be the only configuration source for Ansible-related values.

### Router Registration Entry

**Description**: Router-side mapping between a MAC address and a hostname.

**Fields**:
- `hostname` (string, required)
- `mac_address` (string, required)
- `ip_address` (string, optional)

**Validation Rules**:
- Router entries must align with the main configuration YAML values.

## Relationships

- A **Server** has one **Server Baseline README**.
- The **Main Configuration YAML** aggregates all **Server** records and router
  registration entries.
- Each **Router Registration Entry** references one **Server** by MAC address.
