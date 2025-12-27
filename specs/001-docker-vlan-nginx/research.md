# Research: Atlas Host Container VLAN

## Decision 1: Use existing Ansible playbooks for server and router changes

- **Decision**: Implement atlas-host changes in
  `ansible/playbooks/apply-server.yml` and OpenWrt changes in
  `ansible/playbooks/apply-openwrt.yml` using repo-managed configs.
- **Rationale**: Aligns with the IaC-first constitution, preserves idempotency,
  and keeps all network changes versioned and reviewable.
- **Alternatives considered**: Manual configuration on the server or router
  (rejected due to drift risk and lack of repeatability).
- **References**:
  - https://github.com/gekmihesg/ansible-openwrt
  - https://github.com/gl-inet/docs4.x/blob/master/docs/user_guide/gl-mt6000/index.md

## Decision 2: Install Docker and Compose via OS packages on atlas-host

- **Decision**: Use the atlas-host OS package manager (apt) to install Docker
  Engine and Docker Compose plugin.
- **Rationale**: The current server playbook already uses apt, making package
  installation consistent and straightforward to automate.
- **Alternatives considered**: Official Docker apt repository (rejected for
  additional key/repo management overhead for this MVP).
- **References**:
  - https://docs.docker.com/engine/install/ubuntu/

## Decision 3: Configure VLAN persistence based on detected host tooling

- **Decision**: Detect whether netplan or ifupdown is present on atlas-host and
  apply VLAN 40 configuration using the available tooling.
- **Rationale**: Avoids assumptions about the OS network stack while ensuring
  persistence across reboots.
- **Alternatives considered**: Assume netplan only (rejected due to uncertainty
  about atlas-host OS).

## Decision 4: Use Docker macvlan network for the isolated service

- **Decision**: Attach the hello world nginx container to a Docker macvlan
  network backed by the VLAN 40 interface.
- **Rationale**: Keeps the service isolated while placing it directly on the
  VLAN subnet, aligning with the isolation requirement.
- **Alternatives considered**: Host port publishing on the management network
  (rejected because it weakens isolation).
- **References**:
  - https://docs.docker.com/network/drivers/macvlan/

## Decision 5: Provide hostnames via OpenWrt dnsmasq and Tailscale DNS

- **Decision**: Define static DNS hostnames in OpenWrt dnsmasq for LAN access
  and ensure Tailscale clients resolve them via router DNS settings.
- **Rationale**: Centralizes name resolution on the router and keeps hostnames
  consistent for local and remote access.
- **Alternatives considered**: Rely on per-client hosts files (rejected due to
  operational overhead).
- **References**:
  - https://github.com/gekmihesg/ansible-openwrt
