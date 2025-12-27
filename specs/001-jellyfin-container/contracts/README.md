# Contracts: Jellyfin First Container

This feature does not introduce a public API contract. It relies on
infrastructure configuration changes:

- Jellyfin service reachable at 192.168.40.3 (VLAN 40).
- OpenWrt firewall rule allowing only Achilles MAC `0C:37:96:09:34:DA`.
- Host-level persistent metadata path for container volumes.

If a future API surface is required, add a concrete OpenAPI document here.
