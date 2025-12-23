# Feature Specification: Tailscale Router Access

**Feature Branch**: `003-tailscale-router-access`  
**Created**: 2025-12-23  
**Status**: Draft  
**Input**: User description: "ich möchte auf dem roouter tail scale isntallieren. ACC ist das ich von aussen das ganze netzwerk sehe und meinen Server auf 192.168.8.135 erreiche. der ist in dem netz."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Remote Access to Server (Priority: P1)

As the network owner, I want to reach the server at 192.168.8.135 from outside the LAN so I can use its services remotely.

**Why this priority**: Direct access to the main server is the primary goal and enables remote work immediately.

**Independent Test**: From an external network, a permitted user can connect to 192.168.8.135 and use a service on it successfully.

**Acceptance Scenarios**:

1. **Given** the router is connected to the internet and the user is authenticated, **When** the user connects from outside the LAN, **Then** the user can access 192.168.8.135.
2. **Given** the user is not authorized, **When** they attempt to reach 192.168.8.135, **Then** access is denied.

---

### User Story 2 - Remote Access to LAN (Priority: P2)

As the network owner, I want to see and reach other devices in the LAN from outside so I can manage the full network remotely.

**Why this priority**: Extends value beyond a single host and enables full network administration.

**Independent Test**: From an external network, a permitted user can reach at least one additional LAN host besides 192.168.8.135.

**Acceptance Scenarios**:

1. **Given** the LAN subnet is 192.168.8.0/24, **When** an authorized user connects remotely, **Then** the user can access multiple LAN hosts in that subnet.
2. **Given** the remote user has a local subnet that overlaps with 192.168.8.0/24, **When** they attempt access, **Then** the system provides a clear failure or workaround instruction.

---

### User Story 3 - Persistent and Documented Access (Priority: P3)

As the network owner, I want the remote access setup to persist across router restarts and be documented so I can maintain it reliably.

**Why this priority**: Ensures long-term operability and reduces maintenance risk.

**Independent Test**: After a router restart, remote access still works and documentation clearly describes management access and verification steps.

**Acceptance Scenarios**:

1. **Given** the router has been restarted, **When** an authorized user attempts remote access, **Then** access to LAN hosts still works.
2. **Given** the documentation set, **When** an admin reviews `docs/` or README, **Then** management access and verification steps are clearly described.

### Edge Cases

- Remote user is authenticated but the router has no WAN connectivity.
- LAN host is powered off or changes IP from 192.168.8.135 unexpectedly.
- Remote client's local network overlaps with 192.168.8.0/24.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The router MUST provide remote access to the LAN using Tailscale for authorized users.
- **FR-002**: Authorized users MUST be able to reach the server at 192.168.8.135 from outside the LAN.
- **FR-003**: Authorized users MUST be able to reach other hosts in 192.168.8.0/24 from outside the LAN.
- **FR-004**: Unauthorized users MUST be blocked from accessing any LAN hosts.
- **FR-005**: The remote access configuration MUST persist across router restarts.
- **FR-006**: Documentation MUST describe how to access the router for management and how to verify remote connectivity.

### Key Entities *(include if feature involves data)*

- **Tailnet User**: Authorized person/device allowed to connect remotely.
- **Router Node**: The OpenWrt router providing remote access to the LAN.
- **LAN Subnet**: The internal network range (assumed 192.168.8.0/24).
- **LAN Host**: Any device on the LAN, including the server at 192.168.8.135.

## Assumptions & Sources *(mandatory)*

- Router model is GL-MT6000 or compatible with the referenced OpenWrt guidance.
- Router management access is available over the LAN at a known IP/hostname with admin credentials.
- The LAN subnet is 192.168.8.0/24 and the server has a stable IP of 192.168.8.135.
- The user has a Tailscale account and permissions to authorize the router and remote devices.
- Changes affecting behavior or usage must update `docs/` and any README.md.
- Router reference: https://github.com/gl-inet/docs4.x/blob/master/docs/user_guide/gl-mt6000/index.md
- Ansible/OpenWrt reference: https://github.com/gekmihesg/ansible-openwrt

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: An authorized user can access 192.168.8.135 from outside the LAN in under 1 minute.
- **SC-002**: An authorized user can access at least two distinct LAN hosts (including 192.168.8.135) from outside the LAN.
- **SC-003**: 95% of remote access attempts succeed over a 7-day period.
- **SC-004**: Initial setup can be completed by an admin in under 30 minutes using project documentation.
