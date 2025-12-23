# Data Model: Tailscale Router Access

## Entities

### TailnetUser

- Fields: user_id, display_name, device_id, authorized, last_seen
- Notes: Represents a person or device authorized to access the LAN.

### RouterNode

- Fields: hostname, management_address, tailscale_status, advertised_routes,
  last_configured_at
- Notes: The OpenWrt router providing remote access to the LAN.

### LanSubnet

- Fields: cidr, gateway, description
- Notes: The internal subnet advertised to remote users.

### LanHost

- Fields: ip_address, hostname, role, critical, reachable
- Notes: Devices within the LAN, including 192.168.8.135.

## Relationships

- A RouterNode advertises one or more LanSubnet entries.
- A LanSubnet contains multiple LanHost entries.
- A TailnetUser is authorized to access one or more LanSubnet entries.

## Validation Rules

- LanSubnet.cidr must be valid CIDR notation.
- LanHost.ip_address must be within LanSubnet.cidr.
- TailnetUser.authorized must be true to permit access to LanHost.

## State Transitions

- TailnetUser: unauthorized -> authorized -> revoked
- RouterNode: unconfigured -> configured -> verified
