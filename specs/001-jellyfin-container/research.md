# Research: Jellyfin First Container

## Decisions

### 1) Addressing scheme for VLAN 40

- **Decision**: Use subnet 192.168.40.0/24 with 192.168.40.1 as gateway,
  leave 192.168.40.2 unused, and assign Jellyfin to 192.168.40.3 (no reserve).
- **Rationale**: Aligns with the 40.x numbering convention and keeps a simple,
  predictable mapping for future services.
- **Alternatives considered**: 192.168.8.0/24 or 10.40.0.0/24.

### 2) Jellyfin access control

- **Decision**: Allow access only from Achilles MAC `0C:37:96:09:34:DA`.
- **Rationale**: Enforces a strict allowlist at the gateway and aligns with the
  stated security requirement.
- **Alternatives considered**: Allowlist by IP, allow multiple MACs.

### 3) Metadata persistence location

- **Decision**: Use a single host-level persistent directory for all container
  metadata to simplify backups.
- **Rationale**: Centralized persistence reduces backup complexity and supports
  future containers without rework.
- **Alternatives considered**: Per-container metadata directories.

### 4) Media sources

- **Decision**: Jellyfin media library reads from exactly two USB disks.
- **Rationale**: Explicit requirement; avoids accidental inclusion of other
  storage locations.
- **Alternatives considered**: Dynamic discovery of all mounted media.
