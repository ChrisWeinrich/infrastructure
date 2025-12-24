# Research Notes: Atlas USB Disk Mounts

## Mount Identifiers

Decision: Use UUIDs gathered from `blkid` for `/dev/sdc1` and `/dev/sdc2`.

Rationale: UUIDs remain stable across reboots and device path changes, matching
FR-002.

Alternatives considered: Device paths like `/dev/sdc1` (rejected because they can
change between boots).

## Mount Locations

Decision: Define mount points as explicit variables in
`ansible/playbooks/apply-server.yml` so the operator controls the exact paths
used on Atlas.

Rationale: The operator already has predefined mount locations; variables keep
the change self-contained to the playbook while avoiding guesswork.

Alternatives considered: Hard-code `/mnt/usb1` and `/mnt/usb2` (rejected because
mount locations are not specified in the feature description).

## Mount Management

Decision: Use Ansible mount tasks with state `mounted` so entries are persisted
and idempotent.

Rationale: Ensures mounts survive reboots and can be safely re-applied.

Alternatives considered: Manual edits of mount configuration (rejected because
it is not idempotent and conflicts with IaC principles).

## Validation Approach

Decision: Validate mounts by checking mount status and performing a simple
read/write test on each mount path.

Rationale: Directly confirms availability and write access per FR-005 and
success criteria.

Alternatives considered: Only checking mount status (rejected because it does
not verify write access).
