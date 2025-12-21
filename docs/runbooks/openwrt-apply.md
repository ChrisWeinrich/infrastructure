# OpenWrt Apply

Apply configuration changes in small, verified steps. Do not continue if any
verification gate fails.

## First Small Declarative Change

The first change is intentionally low risk: set the system hostname to
`mt6000` using UCI. This change is idempotent and safe to re-run.

## Staged Apply Sequence

1. Run the verification checklist in `docs/runbooks/openwrt-verification.md`.
2. Apply the first small change using `ansible/playbooks/apply-openwrt.yml`.
   This run captures a pre-apply snapshot and removes it automatically if the
   apply makes no changes.
3. Re-run the verification checklist.
4. Apply configuration files in the following order, pausing after each file
   for verification:

   1. `ansible/configs/openwrt/network`
   2. `ansible/configs/openwrt/wireless`
   3. `ansible/configs/openwrt/firewall`
   4. `ansible/configs/openwrt/dhcp`
   5. `ansible/configs/openwrt/system`

5. After each stage, re-run the verification checklist.

## Example Invocation

```bash
ANSIBLE_PRIVATE_KEY_FILE=~/.ssh/openwrt_mt6000 \
  ansible-playbook ansible/playbooks/apply-openwrt.yml \
  -i ansible/inventory/openwrt/hosts.yml
```

## Notes

- Keep physical access during changes.
- If any step fails, stop and follow `docs/runbooks/openwrt-recovery.md`.
