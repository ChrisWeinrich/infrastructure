# Feature Specification: Ansible Server Baseline

**Feature Branch**: `001-ansible-server-baseline`  
**Created**: 2025-12-21  
**Status**: Draft  
**Input**: User description: "- Create a new specification for an infrastructure project focused on Ansible. - Define the goal as documenting and establishing the base setup and base configuration of a server. - Capture that the first step is documentation. - Require determining the server’s MAC address. - Require setting up the server. - Require creating a minimal baseline README for the server. - Include in the README: - The MAC address. - The server configuration. - The base information about the server. - Require registering the server on the OpenWRT router. - Require assigning a hostname to the server on the OpenWRT router. - Require executing an Ansible “Hello World” against the server using the hostname. - Require introducing a single large/main YAML file containing all configurations. - Require that some values are manually entered into this YAML file. - Require that some values are determined/defined in this YAML file. - Require that Ansible reads configuration from this YAML file. - Require the YAML file to include per-machine configuration, including: - Hostnames. - IP addresses. - MAC addresses (including the given MAC address). - Require the same approach for the router: - A single large YAML file manages the full network configuration."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Document the server baseline (Priority: P1)

As an infrastructure maintainer, I document the server baseline first so that setup and automation have a clear, consistent source of truth.

**Why this priority**: Documentation is the first step and is required to drive all later steps.

**Independent Test**: Can be fully tested by producing the baseline README with required content and capturing the server MAC address.

**Acceptance Scenarios**:

1. **Given** a new server that is not yet documented, **When** I gather its base information and MAC address, **Then** a minimal baseline README exists and includes the MAC address, server configuration, and base server information.
2. **Given** the baseline README is created, **When** I review it for completeness, **Then** it lists the MAC address and the required baseline details without missing fields.
3. **Given** documentation is complete, **When** I perform the baseline setup, **Then** the server matches the documented baseline configuration before any automation checks occur.

---

### User Story 2 - Define a single configuration source of truth (Priority: P2)

As an infrastructure maintainer, I capture all configuration in a single YAML source of truth so the server and router can be configured consistently.

**Why this priority**: Configuration data must be consolidated before it can drive router registration and automation.

**Independent Test**: Can be fully tested by creating the single YAML file with required manual and defined values and verifying it includes per-machine details.

**Acceptance Scenarios**:

1. **Given** the server baseline is documented, **When** I create the main configuration YAML file, **Then** it includes hostnames, IP addresses, and MAC addresses for each machine, including the documented MAC address.
2. **Given** the main configuration YAML file exists, **When** I review its contents, **Then** it contains both manually entered values and values determined within the file.
3. **Given** the main configuration YAML file is in place, **When** I review router configuration content, **Then** the file includes the full network configuration for the router.

---

### User Story 3 - Register the server on the router (Priority: P3)

As an infrastructure maintainer, I register the server and assign its hostname on the OpenWrt router so the network recognizes the server consistently.

**Why this priority**: The server must be visible to the network and assigned a hostname before automation can address it reliably.

**Independent Test**: Can be fully tested by registering the server on the router and verifying the hostname assignment.

**Acceptance Scenarios**:

1. **Given** the server MAC address is documented, **When** I register the server on the OpenWrt router, **Then** the router records the MAC address and assigns the specified hostname.
2. **Given** the router registration is complete, **When** I view the router's known devices list, **Then** the server appears with the assigned hostname.

---

### User Story 4 - Run a baseline automation check (Priority: P4)

As an infrastructure maintainer, I run an Ansible "Hello World" against the server using its hostname to confirm connectivity and baseline configuration readiness.

**Why this priority**: Verifies that the hostname and basic automation path work before deeper configuration.

**Independent Test**: Can be fully tested by executing a "Hello World" run and confirming the run targets the hostname successfully.

**Acceptance Scenarios**:

1. **Given** the router hostname assignment is complete, **When** I run the "Hello World" automation using the hostname, **Then** the run completes successfully against the server.
2. **Given** the main configuration YAML exists, **When** I run the "Hello World" automation, **Then** the run reads host targeting details from that YAML file.

---

### Edge Cases

- What happens when the server MAC address cannot be determined due to missing or inaccessible hardware information?
- How does the system handle a hostname that conflicts with an existing router entry?
- What happens when the router registration succeeds but the hostname does not resolve for automation?
- What happens when the main configuration YAML is missing required per-machine fields?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The process MUST start with documentation before any setup or automation steps.
- **FR-002**: The server MAC address MUST be determined and recorded.
- **FR-003**: The server MUST be set up to a baseline configuration before automation verification.
- **FR-004**: A minimal baseline README for the server MUST be created and MUST include the MAC address, server configuration, and base server information.
- **FR-005**: The server MUST be registered on the OpenWrt router.
- **FR-006**: The server MUST be assigned a hostname on the OpenWrt router.
- **FR-007**: An Ansible "Hello World" MUST be executed against the server using the assigned hostname.
- **FR-008**: A single main YAML file MUST contain all server configurations.
- **FR-009**: The main YAML file MUST include both manually entered values and values determined within the file.
- **FR-010**: Ansible MUST read configuration from the main YAML file.
- **FR-011**: The main YAML file MUST include per-machine configuration for hostnames, IP addresses, and MAC addresses, including the documented MAC address.
- **FR-012**: A single main YAML file MUST manage the full network configuration for the router.

### Key Entities *(include if feature involves data)*

- **Server Baseline README**: Minimal documentation record containing the MAC address, server configuration, and base server information.
- **Server Configuration Record**: Per-machine configuration values such as hostname, IP address, and MAC address.
- **Router Registration Entry**: Router-side record associating a server MAC address with a hostname.
- **Main Configuration YAML**: The single source of configuration data for servers and router network settings.

## Assumptions & Sources *(mandatory)*

- Assumption: The OpenWrt router is the GL-MT6000 model, and its documentation is the primary reference for router capabilities and UI workflows. Source: https://github.com/gl-inet/docs4.x/blob/master/docs/user_guide/gl-mt6000/index.md
- Assumption: OpenWrt configuration management aligns with the Ansible OpenWrt role reference. Source: https://github.com/gekmihesg/ansible-openwrt
- Assumption: Router management is available via a LAN management IP over HTTPS with administrator credentials stored in the team's secure credential store.
- Assumption: The server is reachable on the local network once registered, and its hostname is resolvable from the automation runner.
- Assumption: Any updates to documentation or usage will be reflected in `docs/` and any README files.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% of new servers have a baseline README created before setup activities begin.
- **SC-002**: The MAC address, hostname, and IP address are recorded for each server with zero missing fields.
- **SC-003**: Router registration and hostname assignment are completed for each server in under 30 minutes.
- **SC-004**: The "Hello World" automation run succeeds on the first attempt for at least 90% of newly registered servers.
