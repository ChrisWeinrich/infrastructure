# Quickstart

This quickstart describes the intended workflow for snapshotting and managing
an OpenWrt-based GL-MT6000 router in WISP mode. It is written for operators who
already have local access to the router and a safe fallback path.

## Prerequisites

- Physical or wired fallback access to the router during changes.
- Router management endpoint (IP or hostname), protocol, and credentials
available outside the repository.
- Upstream Wi-Fi credentials available at runtime.
- SSH private key retrieved at runtime via dcli.

## Baseline Snapshot

1. Ensure the router is reachable from the management host.
2. Retrieve the SSH key with dcli and export the path for Ansible.

   ```bash
   mkdir -p ~/.ssh
   dcli read openwrt/mt6000/ssh_key > ~/.ssh/openwrt_mt6000
   chmod 600 ~/.ssh/openwrt_mt6000
   ```

3. Run the snapshot playbook to capture `/etc/config` files into the
`snapshots/<router>/` directory.

   ```bash
   ANSIBLE_PRIVATE_KEY_FILE=~/.ssh/openwrt_mt6000 \
     ansible-playbook playbooks/snapshot-openwrt.yml \
     -i inventories/openwrt/hosts.yml
   ```
4. Commit the snapshot in Git as the baseline reference.

## Declarative Apply

1. Derive desired configuration files from the baseline snapshot.
2. Apply changes in small increments with a verification checklist after each
step.
3. Confirm LAN clients can resolve DNS and reach the internet after each apply.
4. Use the staged apply playbook:

   ```bash
   ANSIBLE_PRIVATE_KEY_FILE=~/.ssh/openwrt_mt6000 \
     ansible-playbook playbooks/apply-openwrt.yml \
     -i inventories/openwrt/hosts.yml
   ```

## Drift Check

1. Compare live `/etc/config` files with the repository state.
2. Review differences and decide whether to apply the repo state or capture a
new snapshot.
3. Use the drift playbook to generate a report:

   ```bash
   ANSIBLE_PRIVATE_KEY_FILE=~/.ssh/openwrt_mt6000 \
     ansible-playbook playbooks/drift-openwrt.yml \
     -i inventories/openwrt/hosts.yml
   ```

## Recovery

- Keep a documented vendor reset or repair process available as a last resort.
- Maintain physical access while iterating on network changes.

## Management Endpoints

Document and store the following outside the repository:

- Router management IP/hostname: 192.168.8.1
- Management protocol: SSH
- Authentication method and location: SSH key stored in pass
