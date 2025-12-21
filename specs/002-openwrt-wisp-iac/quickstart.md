# Quickstart

This quickstart describes the intended workflow for snapshotting and managing
an OpenWrt-based GL-MT6000 router in WISP mode. It is written for operators who
already have local access to the router and a safe fallback path.

## Prerequisites

- Physical or wired fallback access to the router during changes.
- Router management endpoint (IP or hostname), protocol, and credentials
available outside the repository.
- Upstream Wi-Fi credentials available at runtime.

## Baseline Snapshot

1. Ensure the router is reachable from the management host.
2. Run the snapshot playbook to capture `/etc/config` files into the
`snapshots/<router>/` directory.
3. Commit the snapshot in Git as the baseline reference.

## Declarative Apply

1. Derive desired configuration files from the baseline snapshot.
2. Apply changes in small increments with a verification checklist after each
step.
3. Confirm LAN clients can resolve DNS and reach the internet after each apply.

## Drift Check

1. Compare live `/etc/config` files with the repository state.
2. Review differences and decide whether to apply the repo state or capture a
new snapshot.

## Recovery

- Keep a documented vendor reset or repair process available as a last resort.
- Maintain physical access while iterating on network changes.

## Management Endpoints

Document and store the following outside the repository:

- Router management IP/hostname: 192.168.8.1
- Management protocol: SSH
- Authentication method and location: SSH key stored in pass
