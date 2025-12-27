# OpenWrt Tailscale Remote Access

This runbook documents the Tailscale-based remote access setup for the
OpenWrt router (mt6000) and the LAN subnet 192.168.8.0/24.

## Prerequisites

- Tailscale auth key stored in dcli at `openwrt/mt6000/tailscale/auth_key`.
- Router reachable over SSH and Ansible inventory configured.
- Tailnet admin access to approve subnet routes and manage ACLs.

## Apply Configuration

1. Apply configuration (captures a snapshot first):

   ```bash
   ANSIBLE_PRIVATE_KEY_FILE=~/.ssh/openwrt_mt6000 \
     ansible-playbook ansible/playbooks/apply-openwrt.yml \
     -i ansible/inventory/openwrt/hosts.yml
   ```

2. Verify router state:

   ```bash
   ANSIBLE_PRIVATE_KEY_FILE=~/.ssh/openwrt_mt6000 \
     ansible-playbook ansible/playbooks/verify-openwrt.yml \
     -i ansible/inventory/openwrt/hosts.yml
   ```

## Tailnet Route Approval

After the first apply, approve the advertised subnet route in the Tailscale
admin console:

- Approve: `192.168.8.0/24`
- Ensure Tailnet ACLs allow your user/device to access the subnet.

## Client Access Setup

On each remote client, accept subnet routes so 192.168.8.0/24 is reachable.

CLI:

```bash
tailscale up --accept-routes
```

GUI:

- Tailscale app -> Settings -> enable "Use Subnet Routes" (wording varies).

## Accessing the LAN

Once routes are approved and accepted, access LAN hosts by IP, for example:

```bash
ping 192.168.8.134
ssh <user>@192.168.8.134
```

## Hostname Access for VLAN Services

When VLAN services are added (for example, the hello world nginx service on
VLAN 40), ensure the router provides the DNS record and clients query it:

- DNS record: map `nginx-vlan40` to `192.168.40.10` in OpenWrt dnsmasq.
- LAN clients should already use the router as DNS (`192.168.8.1`).
- Tailscale clients should resolve via the router DNS (set in tailnet DNS or
  via client configuration).

Example validation:

```bash
curl http://nginx-vlan40
```

LAN validation (from a LAN client):

```bash
nslookup nginx-vlan40 192.168.8.1
curl http://nginx-vlan40
```

Tailscale validation (from a Tailscale client with subnet routes enabled):

```bash
nslookup nginx-vlan40 192.168.8.1
curl http://nginx-vlan40
```

The router management endpoints remain:

- SSH: `root@192.168.8.1:22`
- Web UI: `http://192.168.8.1`

## Troubleshooting

- No access to 192.168.8.0/24:
  - Confirm `tailscale up --accept-routes` on the client.
  - Confirm route approval in the Tailscale admin console.
  - Check Tailnet ACLs permit the subnet.
- Overlapping client subnet:
  - Switch to a non-overlapping network (mobile hotspot or alternate uplink).
- Host unreachable:
  - Verify the host IP in router DHCP leases.
  - Confirm host firewall allows the intended protocol (SSH, HTTP, etc.).
- Rollback:
  - Follow `docs/runbooks/openwrt-recovery.md`.
