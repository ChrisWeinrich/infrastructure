# Network Configuration Layout

This runbook describes the central network configuration layout in
`ansible/configs/network.yml`. The layout mirrors the physical structure so
operators can find values quickly.

## Structure Overview

- `site`: Top-level grouping for a location or environment.
- `site.networks`: Named networks under the site.
- `site.networks.<name>.router`: The gateway device for the network.
- `site.networks.<name>.router.attached_devices`: Devices connected to the
  router (servers and clients).

## Naming Convention

- **Routers**: Use deity names (example: `hermes-gateway`).
- **Servers**: Use deity names (example: `atlas-host`).
- **Clients**: Use hero names (example: `odysseus-laptop`).
- **Networks**: Use mythology-themed realms or places
  (example: `olympus-lan`).

## Management Endpoints

Management endpoints are defined in each device block under
`management.protocol` and `management.port`, alongside each
`management_address`. Update the endpoint details whenever device addressing
changes.

## Update Checklist

1. Add or update device details under the correct network and router.
2. Keep `name`, `role`, and `management_address` consistent with inventory.
3. For static addressing, include `mac_address` when DHCP is involved.
4. Run the verification playbook to validate conflicts before applying
   changes.
