# Feature Specification: Atlas USB Disk Mounts

**Feature Branch**: `001-usb-disk-mount`  
**Created**: 2025-12-24  
**Status**: Draft  
**Input**: User description: "nun richten wir meine usb platte ein sudo blkid /dev/sdc1 /dev/sdc2. Bitte das diese gemounted wird ummer immer zu verfügung steht"

## User Scenarios & Testing _(mandatory)_

<!--
  IMPORTANT: User stories should be PRIORITIZED as user journeys ordered by importance.
  Each user story/journey must be INDEPENDENTLY TESTABLE - meaning if you implement just ONE of them,
  you should still have a viable MVP (Minimum Viable Product) that delivers value.

  Assign priorities (P1, P2, P3, etc.) to each story, where P1 is the most critical.
  Think of each story as a standalone slice of functionality that can be:
  - Developed independently
  - Tested independently
  - Deployed independently
  - Demonstrated to users independently
-->

### User Story 1 - Always-on USB mounts (Priority: P1)

As the administrator of the Atlas server, I want the two USB partitions to be
mounted automatically on every boot so that storage is always available without
manual steps.

**Why this priority**: Ensures the primary storage use case works reliably after
restarts and power cycles.

**Independent Test**: Can be fully tested by rebooting the server and confirming
both partitions are mounted and accessible.

**Acceptance Scenarios**:

1. **Given** the USB disk with two partitions is attached, **When** the server
   starts, **Then** both partitions are mounted at their configured mount
   locations.
2. **Given** the USB disk is attached, **When** the system restarts, **Then**
   the mounts are restored without manual intervention.
3. **Given** the device path for the disk changes between boots, **When** the
   system starts, **Then** the partitions are still mounted correctly.

---

### User Story 2 - Verify mount availability (Priority: P2)

As the administrator of the Atlas server, I want to verify that each partition
is mounted so I can confirm storage is ready for use.

**Why this priority**: Fast verification reduces troubleshooting time and avoids
unexpected downtime.

**Independent Test**: Can be fully tested by checking the mount status and
attempting read/write access to each mount location.

**Acceptance Scenarios**:

1. **Given** the system is running, **When** the administrator checks mount
   status, **Then** each partition reports its mount location and availability.

---

### User Story 3 - Graceful handling of missing disk (Priority: P3)

As the administrator of the Atlas server, I want clear feedback when the USB
disk is missing so I can resolve it quickly without impacting other services.

**Why this priority**: Prevents confusing failures and avoids blocking startup
or network access.

**Independent Test**: Can be fully tested by booting without the USB disk and
confirming the system reports mounts as unavailable while remaining operational.

**Acceptance Scenarios**:

1. **Given** the USB disk is disconnected, **When** the system starts, **Then**
   the mounts are marked unavailable and the server remains usable.

---

### Edge Cases

- The USB disk is connected but only one partition is present.
- Partition identifiers change after reformatting.
- Filesystem errors prevent a partition from mounting.
- The USB disk is removed while the system is running.

## Requirements _(mandatory)_

<!--
  ACTION REQUIRED: The content in this section represents placeholders.
  Fill them out with the right functional requirements.
-->

### Functional Requirements

- **FR-001**: System MUST mount both USB partitions at configured mount
  locations on every boot when the disk is attached.
- **FR-002**: System MUST use persistent partition identifiers so mounts do not
  depend on variable device paths.
- **FR-003**: System MUST expose mount availability status for each partition.
- **FR-004**: System MUST remain operational and clearly mark mounts as
  unavailable when the USB disk is missing.
- **FR-005**: Users MUST be able to validate read/write access for each mounted
  partition.
- **FR-006**: Scope MUST be limited to the Atlas server and the existing
  server-apply configuration playbook used for it.

### Key Entities _(include if feature involves data)_

- **USB Storage Device**: The physical disk connected to the router, expected to
  contain two partitions.
- **Partition**: A logical segment of the USB disk, identified by a persistent
  identifier and associated with a mount location.
- **Mount Configuration**: The desired mapping of partitions to mount locations,
  including expected availability.
- **Mount Status**: Current availability and access readiness for each partition.

## Assumptions & Sources _(mandatory)_

- Target device is the Atlas server host.
- Automation and configuration practices align with Ansible playbook standards:
  https://docs.ansible.com/
- Changes are limited to the existing server-apply playbook used for Atlas.
- Management access is available via SSH on the server's IP/hostname from
  inventory, using administrator credentials stored in the secure ops location.
- The USB disk contains two formatted partitions and is physically connected to
  the server USB port.
- Mount locations are predefined by the operator and are consistent across
  reboots.
- Any behavior or usage changes will be documented in `docs/` and README files,
  and configuration files will include clear English comments for each step.

## Success Criteria _(mandatory)_

### Measurable Outcomes

- **SC-001**: After any reboot, both partitions are available at their mount
  locations within 2 minutes of startup.
- **SC-002**: In three consecutive reboot tests, 100% of mounts are restored
  without manual steps.
- **SC-003**: When the USB disk is absent, the system reports mounts as
  unavailable within 30 seconds while remaining operational.
- **SC-004**: An administrator can confirm read/write access on both mounts in
  under 2 minutes using a standard verification check.
