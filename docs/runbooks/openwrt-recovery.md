# OpenWrt Recovery

Use these steps to recover access if a change fails. The goal is to restore
reachability before making new changes.

## Recovery Steps

1. Stop the current apply process and keep physical access to the router.
2. Reconnect via the last known-good management path (wired or local Wi-Fi).
3. Restore the last snapshot into `/etc/config` using SCP or SFTP.
4. Commit the restored configuration:

   ```bash
   uci commit network
   uci commit wireless
   uci commit firewall
   uci commit dhcp
   uci commit system
   uci commit tailscale
   ```

5. Disable Tailscale if it was part of the failed change:

   ```bash
   /etc/init.d/tailscale stop
   /etc/init.d/tailscale disable
   uci set tailscale.settings.enabled='0'
   uci commit tailscale
   tailscale down
   ```

6. Reboot the router if configuration services do not reload cleanly.
7. Re-run the verification checklist in
   `docs/runbooks/openwrt-verification.md`.

## Last Resort

- Use the vendor reset or repair workflow for the GL-MT6000.
- Restore the previous baseline snapshot and re-apply changes in smaller
  increments.
