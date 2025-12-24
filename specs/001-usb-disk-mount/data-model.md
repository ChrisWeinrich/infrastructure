# Data Model: Atlas USB Disk Mounts

## USBStorageDevice

Represents the physical USB disk attached to Atlas.

Fields:

- id: Logical identifier for the disk (admin-facing label)
- connection: Physical connection state (attached, detached)
- partitions: List of Partition entities on the disk

## Partition

Represents a partition on the USB disk.

Fields:

- uuid: Stable identifier from `blkid`
- filesystem: Filesystem type (e.g., ext4, xfs)
- label: Human-readable label if present
- mount_config: Associated MountConfiguration
- mount_status: Associated MountStatus

## MountConfiguration

Defines the desired mount configuration for a partition.

Fields:

- mount_path: Target mount location on Atlas
- options: Mount options (if any)
- required: Whether the mount is expected to be present on boot

## MountStatus

Represents current availability of a mount.

Fields:

- state: mounted, unmounted, unavailable
- last_checked: Timestamp of last verification
- writable: Whether write access succeeds
