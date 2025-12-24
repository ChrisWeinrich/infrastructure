# Quickstart: Atlas USB Disk Mounts

## Prerequisites

- SSH access to Atlas via the Ansible inventory.
- UUIDs for `/dev/sdc1` and `/dev/sdc2` from `blkid`.
- Desired mount paths for each partition.
- APFS support is provided by apfs-fuse (read-only).

## Apply

1. Edit `ansible/playbooks/apply-server.yml` to set the partition UUIDs and
   mount paths.
2. Run the playbook against Atlas:

```bash
ansible-playbook -i ansible/inventory ansible/playbooks/apply-server.yml
```

## Validate

- Confirm both mounts appear in the system mount list.
- For APFS mounts, verify read access and expect read-only behavior.
- For writable mounts, create and delete a small test file under each mount
  path.

## Rollback

- Remove or disable the mount entries in the playbook.
- Re-run the playbook to unmount and remove persistent entries.
