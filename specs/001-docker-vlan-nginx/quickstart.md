# Quickstart: Atlas Host Container VLAN

## Prerequisites

- SSH access to atlas-host via the Ansible inventory.
- VLAN 40 trunked to the router and atlas-host uplink.
- Tailscale tailnet admin access to approve new subnet routes if required.
- Planned hostname for the hello world service.

## Apply

1. Update `ansible/configs/network.yml` with VLAN 40 values and hostname
   details.
2. Apply router configuration:

```bash
ANSIBLE_PRIVATE_KEY_FILE=~/.ssh/openwrt_mt6000 \
  ansible-playbook ansible/playbooks/apply-openwrt.yml \
  -i ansible/inventory/openwrt/hosts.yml
```

3. Apply server configuration:

```bash
ansible-playbook -i ansible/inventory ansible/playbooks/apply-server.yml
```

## Validate

- Confirm VLAN 40 interface is up on atlas-host.
- Confirm the hello world service responds via the configured hostname from
  the LAN (192.168.8.0/24).
- Confirm the hello world service responds via the configured hostname from a
  Tailscale client with subnet routes enabled.

## Rollback

- Remove or disable VLAN 40 and hostname entries in the OpenWrt configs.
- Remove the container service and VLAN configuration from the server playbook.
- Re-run the playbooks to return to the prior state.
