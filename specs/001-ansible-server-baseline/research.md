# Phase 0 Research: Ansible Server Baseline

## Decision: Single main configuration YAML location

**Decision**: Store the base configuration in a single main YAML file under
`ansible/configs/` and treat it as the only configuration source for Ansible
and router registration data.

**Rationale**: Keeps configuration centralized, aligns with the constitution's
single-source rule, and matches the repository's existing `ansible/configs/`
structure.

**Alternatives considered**:
- `ansible/inventory/` (rejected because it conflates inventory structure with
  shared configuration data).
- `docs/` (rejected because configuration should live with automation assets).

## Decision: Router registration workflow reference

**Decision**: Use the GL-MT6000 documentation as the primary reference for
router registration workflows.

**Rationale**: It is the authoritative router guide required by the
constitution and ensures consistency with the device in scope.

**Alternatives considered**:
- Community forum guidance (rejected because it is not authoritative).

## Decision: "Hello World" validation expectation

**Decision**: Define "Hello World" as a simple connectivity validation that
uses the hostname from the main YAML file and confirms the automation runner
can reach the server.

**Rationale**: Validates DNS/hostname assignment and confirms Ansible can target
and connect to the server without requiring additional configuration state.

**Alternatives considered**:
- Running a full baseline configuration play (rejected because it exceeds the
  minimal validation requirement).
