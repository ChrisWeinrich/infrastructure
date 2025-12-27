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

## VLAN 40 Validation and Rollback

Validation steps before and after applying VLAN 40 updates:

1. Confirm VLAN 40 values in `ansible/configs/network.yml` match the intended
   subnet, gateway, and hostname data.
2. After applying playbooks, verify the VLAN interface exists on atlas-host and
   can reach the VLAN gateway (for example, ping `192.168.40.1` from atlas-host).

Rollback steps if VLAN 40 changes need to be reverted:

1. Remove the VLAN 40 network and service hostname entries from
   `ansible/configs/network.yml`.
2. Re-run the relevant playbooks to remove or disable the VLAN configuration.
3. If OpenWrt changes were applied, restore the last known-good snapshot using
   the OpenWrt recovery runbook.
4. Remove the Docker macvlan network and hello world container if they were
   created, then re-run `ansible/playbooks/apply-server.yml` to reconcile.

## Update Checklist

1. Add or update device details under the correct network and router.
2. Keep `name`, `role`, and `management_address` consistent with inventory.
3. For static addressing, include `mac_address` when DHCP is involved.
4. Run the verification playbook to validate conflicts before applying
   changes.
