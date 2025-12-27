# OpenWrt Basic Setup

## Set Admin Password

1. Retrieve the admin password from Dashlane via dcli:

   ```bash
   dcli p --output console title=openwrt/mt6000/admin
   ```

2. Set the password in the OpenWrt web UI (LuCI) at `http://192.168.8.1`.

   Use the System -> Administration page to set the root password.

## Add SSH Key

1. Copy the local public key to the router:

   ```bash
   ssh-copy-id -i ~/.ssh/id_ed25519.pub root@192.168.8.1
   ```
