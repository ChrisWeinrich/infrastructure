# Atlas USB Mounts

This document describes how to configure persistent USB mounts on the Atlas
server using the Ansible playbook.

## Prerequisites

- SSH access to Atlas via `ansible/inventory`.
- UUIDs for `/dev/sdc1` and `/dev/sdc2` from `blkid`.
- Desired mount paths for each partition.
- USB filesystem tooling installed (FUSE and build dependencies for APFS
  support, managed by the playbook).

## Configuration

Edit `ansible/playbooks/apply-server.yml` and set the `usb_partitions` values:

- `uuid`: UUID from `blkid` (stable across reboots).
- `mount_path`: Target mount location on Atlas.
- `fstype`: Filesystem type (`fuse.apfs` for APFS via apfs-fuse).
- `options`: Mount options (use `ro,allow_other` for APFS read-only).

## Apply

Run the playbook from repo root (this will build and install apfs-fuse if
needed):

```bash
ansible-playbook -i ansible/inventory ansible/playbooks/apply-server.yml
```

## Validate

- Confirm both mounts appear in the system mount list.
- For APFS mounts, verify read access and expect read-only behavior.
- For writable mounts, create and delete a small test file under each mount
  path.

## Rollback

1. Remove or disable the USB mount entries in
   `ansible/playbooks/apply-server.yml`.
2. Re-run the playbook to unmount and remove persistent entries.
