# Quickstart: Static IP and Hostnames

## Goal

Apply a fixed server IP, set clear device hostnames, and keep a central
configuration source aligned to the network structure.

## Prerequisites

- Local access to the repository
- Administrative access to the router and server
- Existing Ansible/OpenWrt automation tooling available

## Steps

1. Update the central configuration source with the site, network, and device
   values for hermes-gateway and atlas-host.
2. Validate the configuration for IP and hostname conflicts before applying
   changes.
3. Apply the configuration to the router and server using the standard
   automation workflow for this repository.
4. Verify the server remains reachable at 192.168.1.134 and that both
   hostnames resolve on the LAN.
5. Document management endpoints in `docs/` and update any README.md that
   references access details.

## Rollback

- Revert to the prior configuration source version in version control.
- Re-apply the last known-good configuration to restore previous addressing
  and hostnames.
- Confirm management access through documented endpoints.
