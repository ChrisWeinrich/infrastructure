# OpenWrt Drift Workflow

Use the drift playbook to compare live router configuration to the repository
state.

## Steps

1. Confirm SSH access using the verification checklist.
2. Run the drift playbook:

   ```bash
   ANSIBLE_PRIVATE_KEY_FILE=~/.ssh/openwrt_mt6000 \
     ansible-playbook playbooks/drift-openwrt.yml \
     -i inventories/openwrt/hosts.yml
   ```

3. Review the report under `snapshots/<router>/drift/`.
4. If drift is expected, update the desired configuration or capture a new
   snapshot.
5. If drift is unexpected, re-apply the desired configuration with the staged
   apply workflow.
