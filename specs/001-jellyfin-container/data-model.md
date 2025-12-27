# Data Model: Jellyfin First Container

## Entities

### USB-Medium

- **Fields**: id, mount_path, label, expected=true
- **Rules**: Exactly two entries are required and must be mounted for normal
  operation.

### Jellyfin-Metadaten

- **Fields**: base_path, backup_scope=all_containers
- **Rules**: Must be persistent across container restarts and host reboots.

### Jellyfin-Service

- **Fields**: service_name, address=192.168.40.3, status
- **Relationships**: Reads from USB-Medium (2), writes to Jellyfin-Metadaten (1).

### Achilles-Device

- **Fields**: mac_address=0C:37:96:09:34:DA, name=achilles
- **Rules**: Only allowed client for Jellyfin access.

### Firewall-Rule

- **Fields**: source_mac, target_ip=192.168.40.3, action=allow
- **Rules**: Deny-by-default for non-matching sources.

## Relationships

- Jellyfin-Service uses two USB-Medium entries as media sources.
- Jellyfin-Service persists metadata to Jellyfin-Metadaten.
- Firewall-Rule allows Achilles-Device to reach Jellyfin-Service.

## State/Validation Notes

- If one USB-Medium is missing, the system is degraded and must alert via logs.
- If Jellyfin-Metadaten path is unavailable, Jellyfin must not start to avoid
  data loss or inconsistency.
