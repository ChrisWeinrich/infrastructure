# OpenWrt Verification

Use this checklist before and after every change. Stop if any gate fails.

## SSH Connectivity Gate (Required)

1. Retrieve the SSH key with dcli (see `docs/runbooks/openwrt-secrets.md`).
2. Run the verification playbook and confirm the SSH check passes.

   ```bash
   ANSIBLE_PRIVATE_KEY_FILE=~/.ssh/openwrt_mt6000 \
     ansible-playbook ansible/playbooks/verify-openwrt.yml \
     -i ansible/inventory/openwrt/hosts.yml
   ```

**Gate**: If SSH connectivity fails, do not apply any changes.

## UCI Read Checks (Required)

Confirm the router can read each configuration file before applying changes.
These checks are performed by the verification playbook, and can be run
manually if needed.

```bash
uci show network
uci show wireless
uci show firewall
uci show dhcp
uci show system
```

## LAN Client DNS and Internet Checks (Required)

From a LAN client connected to the MT6000, verify external resolution and
reachability.

```bash
nslookup example.com
ping -c 3 1.1.1.1
curl -I https://example.com
```

**Gate**: If any of these checks fail, halt and follow the recovery plan.

## Post-Change Lockout Check (Required)

After the first small change and after each staged apply step:

1. Confirm SSH access still works via `ansible/playbooks/verify-openwrt.yml`.
2. Confirm the LAN client DNS and internet checks still pass.

If any check fails, stop and follow the recovery runbook.

## Tailscale Remote Access Checks (When Enabled)

1. Confirm the Tailscale service is running:

   ```bash
   /etc/init.d/tailscale status
   tailscale status
   ```

2. From an external network, confirm access to the server at 192.168.8.135.
   Example checks:

   ```bash
   ping -c 3 192.168.8.135
   ssh <user>@192.168.8.135
   ```

3. If subnet routing is enabled, confirm access to at least one additional LAN
   host within 192.168.8.0/24.
4. If the remote client's local subnet overlaps with 192.168.8.0/24, switch
   to a non-overlapping network (mobile hotspot or alternate uplink) before
   retrying verification.
5. If access fails, check Tailnet ACLs and the approved routes in the
   Tailscale admin console.
