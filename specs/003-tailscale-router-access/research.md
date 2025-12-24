# Research: Tailscale Router Access

## Decision 1: Use subnet routing via the router

- Decision: Configure the router as the Tailscale subnet router advertising
  192.168.8.0/24 for remote access.
- Rationale: Subnet routing exposes the full LAN to authorized users without
  installing clients on every LAN host and matches the feature goals.
- Alternatives considered: Install Tailscale only on the server at
  192.168.8.135; use port forwarding/VPN unrelated to Tailscale.

## Decision 2: Manage configuration through IaC

- Decision: Implement all changes via Ansible and OpenWrt UCI configuration
  committed to the repository.
- Rationale: Aligns with IaC principles, idempotency, and drift control in the
  Infrastructure Constitution.
- Alternatives considered: Manual router configuration in the web UI.

## Decision 3: Enforce authorization with Tailnet ACLs

- Decision: Use Tailnet ACLs to restrict which users/devices can access the
  advertised subnet.
- Rationale: Centralized access control reduces router-side complexity and
  ensures only authorized users access LAN resources.
- Alternatives considered: Router firewall allow-lists only.

## Decision 4: Validate access with repeatable checks

- Decision: Provide a documented verification flow (snapshot, apply, verify)
  using existing playbooks and connectivity checks.
- Rationale: Satisfies the safety-first and validation requirements while
  remaining repeatable.
- Alternatives considered: Ad-hoc manual testing without scripts.
