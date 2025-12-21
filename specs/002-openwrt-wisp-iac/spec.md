# Feature Specification: OpenWrt WISP IaC

**Feature Branch**: `002-openwrt-wisp-iac`
**Created**: 2025-12-20
**Status**: Implemented
**Input**: User description: "We have a GL.iNet Flint 2 (GL-MT6000) router that
is already connected to the internet via Repeater mode, which
operates in WISP mode by default (router creates its own subnet and
firewall/NAT behind an upstream Wi-Fi network). We want to migrate
this working manual setup into a clean, reproducible, Git-managed
infrastructure-as-code setup. Goals: - Keep the current behavior:
MT6000 provides a private LAN/Wi-Fi for clients and uses an upstream
Wi-Fi as WAN uplink (Repeater/WISP). - Manage the OpenWrt
configuration via Ansible from a Git repository as the single source
of truth. - Ensure idempotency: changes are applied
consistently, and removing config from the repo should remove it from
the router when safe. - Avoid requiring Python on the router (use an
Ansible role/approach that can manage OpenWrt without Python). Non-
goals (for this spec): - No VPN / remote access feature yet. - No
VLAN design yet. - No server configuration (network boundary only).
Constraints: - Safety first: network changes must avoid lockouts.
Each change should have a verification checklist and a recovery plan.
           - Start from a read-only snapshot of the current router config before
making declarative changes. Acceptance criteria: - Router remains
connected to upstream Wi-Fi via Repeater/WISP after applying the IaC.
           - A client connected to the MT6000 can resolve DNS and reach the
internet. - The repository contains the necessary specs, plan, and
tasks for this feature and produces a reproducible configuration."

## Clarifications

### Session 2025-12-20

- Q: Where should SSH user and key be sourced for management access? → A: Use
dcli for the SSH private key only; store host and user in inventory.
- Q: Which dcli command should be used to retrieve the SSH key? → A: Use
`dcli read <path>` to fetch the key by path.
- Q: What is the dcli path for the SSH key? → A: Use
`openwrt/mt6000/ssh_key`.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Maintain WISP Uplink While Serving LAN (Priority: P1)

As a network operator, I want the router to keep its current WISP/repeater
behavior so clients on the private LAN can continue to reach the internet
without manual reconfiguration.

**Why this priority**: This is the core behavior that must not regress during
the migration.

**Independent Test**: Can be fully tested by applying the desired configuration
once and validating WAN uplink plus LAN client internet
access.

**Acceptance Scenarios**:

1. **Given** the router has a valid upstream Wi-Fi profile, **When** the desired
configuration is applied, **Then** the router reconnects to the upstream Wi-
Fi and continues to provide NATed internet access to LAN clients.
2. **Given** a LAN client is connected to the router, **When** the configuration
is applied, **Then** the client can resolve DNS and reach an external site.

---

### User Story 2 - Capture Baseline Before Changes (Priority: P2)

As a network operator, I want a read-only snapshot of the current router
configuration stored in the repository so I can compare and recover if needed.

**Why this priority**: Baselines are required for safe change control and
recovery.

**Independent Test**: Can be fully tested by running the snapshot task and
confirming a stored artifact exists without applying any
changes.

**Acceptance Scenarios**:

1. **Given** the router is reachable from the management network, **When** the
snapshot task runs, **Then** a timestamped, read-only configuration snapshot
is captured and stored in the repository.

---

### User Story 3 - Safe, Repeatable Changes (Priority: P3)

As a network operator, I want changes to be idempotent and reversible with clear
verification and recovery steps so I can apply updates without risking lockout.

**Why this priority**: Safety and repeatability reduce downtime and prevent loss
of access.

**Independent Test**: Can be fully tested by applying the configuration twice
and confirming no further changes plus a documented
recovery path.

**Acceptance Scenarios**:

1. **Given** the desired configuration matches the router state, **When** the
configuration is applied again, **Then** no changes are made and the router
remains reachable.
2. **Given** a configuration application fails, **When** the recovery steps are
followed, **Then** the router returns to a reachable, internet-connected
state.

---

### Edge Cases

- What happens when the upstream Wi-Fi is unavailable during apply?
- How does the process handle invalid upstream Wi-Fi credentials?
- What happens if the router reboots mid-apply?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST capture a read-only snapshot of the current router
configuration before any changes are applied.
- **FR-002**: System MUST store the desired router configuration in a version-
controlled repository as the single source of truth.
- **FR-003**: System MUST apply configuration changes idempotently, producing no
changes on repeated runs when the router already matches the desired state.
- **FR-004**: System MUST preserve WISP/repeater behavior, providing a private
LAN/Wi-Fi behind a NAT/firewall while using upstream Wi-Fi as WAN.
- **FR-005**: System MUST ensure LAN clients can resolve DNS and reach the
internet after applying configuration changes.
- **FR-006**: System MUST provide a documented verification checklist for every
change and a recovery plan to restore access if a change fails.
- **FR-007**: System MUST remove configurations that are removed from the
repository when it is safe to do so without breaking basic connectivity.
- **FR-008**: System MUST avoid requiring additional runtime dependencies to be
installed on the router beyond standard management interfaces.
- **FR-009**: System MUST keep sensitive credentials out of the repository and
require a secure input method for them at runtime.
- **FR-010**: System MUST source the SSH private key from dcli at runtime and
keep the router host and user in the inventory.
- **FR-011**: System MUST retrieve the SSH key with `dcli read <path>` at
runtime.
- **FR-012**: System MUST use the dcli path `openwrt/mt6000/ssh_key` for the
SSH private key.
- **FR-013**: System MUST reload `system` and restart `dnsmasq` when the router
hostname changes.
- **FR-014**: System MUST capture a snapshot before apply and delete the
snapshot if no changes are applied.

Acceptance for these requirements is demonstrated by the User Scenarios and the
Success Criteria outcomes.

### Key Entities *(include if feature involves data)*

- **Router Configuration**: The current live configuration state on the router.
- **Desired Configuration**: The version-controlled target state that defines
expected router behavior.
- **Configuration Snapshot**: A read-only, timestamped capture of the router's
current state before changes.
- **Verification Checklist**: A set of steps used to confirm connectivity and
safety after changes.
- **Recovery Plan**: Documented steps to regain access and restore connectivity
if changes fail.

## Assumptions & Sources *(mandatory)*

- The GL.iNet Flint 2 (GL-MT6000) supports repeater/WISP mode as a supported
internet connection method and can be administered via the standard management
interfaces. Source: https://github.com/gl-
inet/docs4.x/blob/master/docs/user_guide/gl-mt6000/index.md
- Configuration automation for OpenWrt can be performed without installing
Python on the router. Source: https://github.com/gekmihesg/ansible-openwrt
- Management access to the router is available on the local LAN at
192.168.8.1 via SSH, with credentials stored in pass and not in the
repository.
- Upstream Wi-Fi credentials are available to authorized operators at runtime
and are not committed to version control.
- The repository will store only non-sensitive configuration artifacts and
documentation required for reproducible setup.
- Out of scope for this feature: VPN/remote access, VLAN design, and server
configuration beyond the network boundary.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: After applying the desired configuration, the router reconnects to
upstream Wi-Fi and restores LAN client internet access within 2 minutes.
- **SC-002**: A LAN client can resolve DNS and reach an external website
successfully in 3 consecutive verification attempts after apply.
- **SC-003**: Re-applying the configuration twice in succession results in zero
reported changes and no loss of reachability.
- **SC-004**: A configuration snapshot is captured and stored before each change
within 5 minutes of initiating the change.
- **SC-005**: The repository contains the feature spec, a plan, and task list
for this feature before implementation work begins.
- **SC-006**: When an apply run results in no changes, the pre-apply snapshot is
deleted.
