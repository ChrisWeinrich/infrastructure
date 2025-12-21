# OpenWrt Snapshots

Snapshots capture the OpenWrt `/etc/config` state for recovery.

## Structure

```text
snapshots/
└── <router>/
    ├── <timestamp>/
    │   ├── network
    │   ├── wireless
    │   ├── firewall
    │   ├── dhcp
    │   └── system
```

## Notes

- Snapshots are read-only by default.
