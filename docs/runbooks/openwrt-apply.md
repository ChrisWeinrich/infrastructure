# OpenWrt Apply

Apply configuration changes in small, verified steps. Do not continue if any
verification gate fails.

## First Small Declarative Change

The first change is intentionally low risk: set the system hostname to
`mt6000` using UCI. This change is idempotent and safe to re-run.

## Staged Apply Sequence

1. For a quick hello-world check, run the verification checklist in
   `docs/runbooks/openwrt-verification.md`.
2. The snapshot playbook is only required once at the beginning. After that,
   `ansible/playbooks/apply-openwrt.yml` automatically captures a snapshot
   before applying changes.
3. Apply the first small change using `ansible/playbooks/apply-openwrt.yml`.
   This run captures a pre-apply snapshot and removes it automatically if the
   apply makes no changes.
4. Re-run the verification checklist.
5. If Tailscale is being configured for the first time:
   - Create a reusable auth key in the Tailscale admin console.
   - Store the auth key in dcli at `openwrt/mt6000/tailscale/auth_key`.
   - Ensure the Tailnet ACLs allow your user/device to reach the LAN subnet.
   - After the first `tailscale up`, approve advertised routes in the admin
     console.
6. Apply configuration files in the following order, pausing after each file
   for verification:
   1. `ansible/configs/openwrt/network`
   2. `ansible/configs/openwrt/wireless`
   3. `ansible/configs/openwrt/firewall`
   4. `ansible/configs/openwrt/dhcp`
   5. `ansible/configs/openwrt/system`
   6. `ansible/configs/openwrt/tailscale`

7. After each stage, re-run the verification checklist.

## Tailscale Apply Notes

- `ansible/playbooks/apply-openwrt.yml` installs Tailscale and runs
  `tailscale up` using the auth key stored in dcli.
- After the first apply, approve advertised routes in the Tailscale admin
  console and re-run the verification checklist.

## Management Access Endpoints

- SSH: `root@192.168.8.1:22` (inventory host `mt6000`)
- Web UI: `http://192.168.8.1` on the LAN

## Example Invocation

```bash
ANSIBLE_PRIVATE_KEY_FILE=~/.ssh/openwrt_mt6000 \
  ansible-playbook ansible/playbooks/apply-openwrt.yml \
  -i ansible/inventory/openwrt/hosts.yml
```

## Notes

- Keep physical access during changes.
- If any step fails, stop and follow `docs/runbooks/openwrt-recovery.md`.
