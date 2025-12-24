# Feature Specification: Server Container VLAN Setup

**Feature Branch**: `001-docker-vlan-nginx`  
**Created**: 2025-12-24  
**Status**: Draft  
**Input**: User description: "wir sind beim nächeten feature und haben nun 004-.... DAs feature dreht sich um folgendes auf dem Server docker udn docker compose installieren. Ein Vlan dafüber ein richten und einen hello world nginx container deployen"

## User Scenarios & Testing *(mandatory)*

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

### User Story 1 - Provision isolated service network (Priority: P1)

As an infrastructure admin, I want the atlas-host server to host a simple web service inside its own isolated container environment on an isolated network segment so I can validate container readiness and network separation.

**Why this priority**: This confirms the server can run containerized services safely without impacting existing traffic.

**Independent Test**: Can be fully tested by running the provisioning process once and verifying the service is reachable on the isolated network.

**Acceptance Scenarios**:

1. **Given** the server is reachable for administration, **When** provisioning is applied, **Then** an isolated network segment is configured on the server.
2. **Given** the isolated segment is configured, **When** the hello world service is started, **Then** the service responds with the expected page on that segment.

---

### User Story 2 - Provide access from LAN and remote admin (Priority: P2)

As an infrastructure admin, I want to access the hello world service from the LAN and via remote admin access so I can validate it locally and from outside.

**Why this priority**: This ensures the service is reachable for local and remote validation without exposing it broadly.

**Independent Test**: Can be tested by reaching the service from the LAN and from the remote admin network.

**Acceptance Scenarios**:

1. **Given** the hello world service is running, **When** accessing it from the LAN (192.168.8.0/24), **Then** the service responds with the expected page.
2. **Given** the hello world service is running, **When** accessing it from the remote admin network (Tailscale), **Then** the service responds with the expected page.

---

### User Story 3 - Repeatable provisioning (Priority: P3)

As an infrastructure admin, I want to re-run provisioning without creating duplicate network settings or services so the setup is safe to maintain.

**Why this priority**: Repeatable runs reduce operational risk during changes.

**Independent Test**: Can be tested by running provisioning twice and confirming no duplicate resources appear.

**Acceptance Scenarios**:

1. **Given** the server is already configured, **When** provisioning runs again, **Then** no duplicate network segments or duplicate services are created.

---

[Add more user stories as needed, each with an assigned priority]

### Edge Cases

- What happens when VLAN 40 or subnet 192.168.40.0/24 is already in use on the server?
- How does the system handle an unavailable uplink for the isolated network?
- What happens if the service port is already occupied on the server?
- What happens if the LAN or Tailscale routes to the service are missing?

## Requirements *(mandatory)*

<!--
  ACTION REQUIRED: The content in this section represents placeholders.
  Fill them out with the right functional requirements.
-->

### Functional Requirements

- **FR-001**: System MUST configure an isolated network segment on the atlas-host server using VLAN 40 and subnet 192.168.40.0/24.
- **FR-002**: System MUST keep existing server management access available after the isolated segment is configured.
- **FR-003**: System MUST deploy a minimal hello world web service that runs in an isolated container environment on the atlas-host server and responds on the isolated network segment.
- **FR-004**: System MUST allow access to the hello world service from the LAN 192.168.8.0/24.
- **FR-005**: System MUST allow access to the hello world service from the remote admin network (Tailscale).
- **FR-006**: System MUST support DNS hostnames for the hello world service for LAN and remote admin access.
- **FR-007**: System MUST support repeatable provisioning without creating duplicate network configuration or services.

### Key Entities *(include if feature involves data)*

- **Isolated Network Segment**: The VLAN-based network segment configured on the server (ID, subnet, uplink association).
- **Hello World Service Endpoint**: The network endpoint exposed by the sample service (address, port, expected response).
- **Service Hostname**: The DNS name mapped to the hello world service (name, resolution scope).

## Assumptions & Sources *(mandatory)*

- Target server is "atlas-host" and is reachable via existing SSH host alias
  `atlas-host` on the management network.
- VLAN trunking is available on the server uplink to carry the isolated segment.
- If router configuration is required to pass the VLAN, consult the GL-MT6000 reference first:
  https://github.com/gl-inet/docs4.x/blob/master/docs/user_guide/gl-mt6000/index.md
- For OpenWrt automation patterns, consult:
  https://github.com/gekmihesg/ansible-openwrt
- Management access details: SSH over the management network to host
  `atlas-host`, authenticated using existing admin credentials in the local SSH
  config.
- Any behavior or usage changes will update `docs/` and any README.md.
- Code, scripts, configs, and YAML files will include English comments where steps are not self-explanatory.

## Success Criteria *(mandatory)*

<!--
  ACTION REQUIRED: Define measurable success criteria.
  These must be technology-agnostic and measurable.
-->

### Measurable Outcomes

- **SC-001**: The isolated network segment is created and usable within 15 minutes of starting provisioning.
- **SC-002**: The hello world endpoint responds successfully from the isolated network on the first attempt after provisioning.
- **SC-003**: The service is reachable from the LAN (192.168.8.0/24) and the remote admin network on the first attempt after provisioning.
- **SC-004**: DNS hostnames resolve to the service for both LAN and remote admin access on the first attempt after provisioning.
- **SC-005**: Re-running provisioning results in zero duplicate network segments or duplicate services.
