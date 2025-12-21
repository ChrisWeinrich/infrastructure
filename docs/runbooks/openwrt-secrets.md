# OpenWrt Secrets Handling

This runbook describes how to retrieve the OpenWrt SSH private key using dcli
and keep secrets out of the repository.

## SSH Private Key Retrieval

1. Fetch the SSH private key from dcli.

   ```bash
   mkdir -p ~/.ssh
   dcli read openwrt/mt6000/ssh_key > ~/.ssh/openwrt_mt6000
   ```

2. Lock down permissions on the key file.

   ```bash
   chmod 600 ~/.ssh/openwrt_mt6000
   ```

3. Use the key when running Ansible.

   ```bash
   ANSIBLE_PRIVATE_KEY_FILE=~/.ssh/openwrt_mt6000 \
     ansible-playbook playbooks/verify-openwrt.yml \
     -i inventories/openwrt/hosts.yml
   ```

## Operational Notes

- Do not store SSH keys in the repository.
- Keep host and user values in `inventories/openwrt/hosts.yml` only.
- Keep the key file in `~/.ssh` with `0600` permissions.
