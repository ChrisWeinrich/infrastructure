# Feature Specification: Static IP and Hostnames

**Feature Branch**: `001-static-ip-hostnames`
**Created**: 2025-12-20
**Status**: Draft
**Input**: User description: "nächster step ich will für den server der an dem router hängt eine feste IP, kann die 192.168.1.134 bleiben. Dazu noch saubere Hostanmes für beide maschinen hermes-gateway und atlas-host. ich will auch eine zentrale yaml im ansible in der all meine config vars in schön lesbarer form sind. mein ganz config. vorzugweise nach dem bau prinzip das der netzwerk struktur entspricht"

## User Scenarios & Testing _(mandatory)_

### User Story 1 - Stable server address (Priority: P1)

As an operator, I want the server connected to the router to keep a fixed LAN address so I can reliably access it.

**Why this priority**: Stable addressing is required for all other management and service access.

**Independent Test**: Can be fully tested by applying the configuration and confirming the server stays at the specified address across restarts.

**Acceptance Scenarios**:

1. **Given** the server is connected to the router LAN, **When** the configuration is applied, **Then** the server uses IP address 192.168.1.134.
2. **Given** the configuration has been applied previously, **When** the configuration is re-applied, **Then** the server remains at 192.168.1.134.

---

### User Story 2 - Clear hostnames (Priority: P2)

As an operator, I want consistent hostnames for the router and server so I can identify and access each device without ambiguity.

**Why this priority**: Clear names reduce operational mistakes and speed up administration.

**Independent Test**: Can be tested by confirming the names appear consistently wherever device names are used for management.

**Acceptance Scenarios**:

1. **Given** the router is managed on the LAN, **When** the configuration is applied, **Then** the router hostname is hermes-gateway.
2. **Given** the server is managed on the LAN, **When** the configuration is applied, **Then** the server hostname is atlas-host.

---

### User Story 3 - Central configuration view (Priority: P3)

As an operator, I want a single, human-readable configuration source that mirrors the network structure so I can find and update values quickly.

**Why this priority**: A central, structured view reduces errors and makes changes faster and safer.

**Independent Test**: Can be tested by locating required values in the central configuration without searching multiple files.

**Acceptance Scenarios**:

1. **Given** the central configuration source, **When** I look for a device or network value, **Then** it is grouped under the relevant network structure section.
2. **Given** a new operator, **When** they look up the server IP or hostname, **Then** they can locate it in under 2 minutes.

---

### Edge Cases

- What happens when the requested IP address is already in use on the LAN?
- How does the system handle a hostname that duplicates an existing device name?
- What happens when a required configuration value is missing from the central configuration source?

## Requirements _(mandatory)_

### Functional Requirements

- **FR-001**: System MUST assign the server connected to the router the fixed LAN IP address 192.168.1.134.
- **FR-002**: System MUST keep the server at 192.168.1.134 across repeated configuration applications.
- **FR-003**: System MUST set the router hostname to hermes-gateway.
- **FR-004**: System MUST set the server hostname to atlas-host.
- **FR-005**: System MUST provide a single, human-readable configuration source containing all environment configuration values.
- **FR-006**: The configuration source MUST organize values by network structure (site, networks, devices, addressing) and clearly indicate relationships.
- **FR-007**: System MUST document management endpoints for the router and server, including hostname and IP address.
- **FR-008**: System MUST flag IP or hostname conflicts within the defined network.

### Key Entities _(include if feature involves data)_

- **Device**: A managed machine such as the router or server, identified by role, hostname, and address.
- **Address Assignment**: The fixed IP address associated with a device.
- **Hostname**: The unique name used to identify a device in management contexts.
- **Network Structure**: The logical grouping of site, networks, and devices used to organize configuration values.
- **Configuration Source**: The single location that stores all network, device, and addressing values.

## Assumptions & Sources _(mandatory)_

- Router model and baseline behavior follow the primary router reference: https://github.com/gl-inet/docs4.x/blob/master/docs/user_guide/gl-mt6000/index.md
- OpenWrt automation conventions follow the core reference: https://github.com/gekmihesg/ansible-openwrt
- The server is connected to the router LAN and should use a fixed address within the 192.168.1.0/24 network.
- The router is named hermes-gateway and the attached server is named atlas-host.
- Management access occurs on the local LAN using existing administrative credentials and methods; authentication changes are out of scope.
- Management endpoints to document: hermes-gateway (router hostname) and atlas-host (server hostname), with the server reachable at 192.168.1.134.
- Scope is limited to LAN addressing, device hostnames, and the central configuration view; unrelated services and features are out of scope.
- Changes affecting behavior or usage must update `docs/` and any README.md.
- Configuration artifacts will include clear English comments for each block to aid understanding.

## Success Criteria _(mandatory)_

### Measurable Outcomes

- **SC-001**: The server remains reachable at 192.168.1.134 for 7 consecutive days after configuration without IP changes.
- **SC-002**: 100% of management references resolve hermes-gateway to the router and atlas-host to the server on the LAN.
- **SC-003**: Operators can locate any network or device configuration value in the central configuration source within 2 minutes.
- **SC-004**: Configuration review identifies 0 IP address or hostname conflicts in the defined network.
