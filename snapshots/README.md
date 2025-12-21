# OpenWrt Snapshots

Snapshots capture the OpenWrt `/etc/config` state for drift comparisons and
recovery.

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
    └── drift/
        └── <timestamp>.diff
```

## Notes

- Snapshots are read-only by default.
- Drift reports compare repository config to live config.
