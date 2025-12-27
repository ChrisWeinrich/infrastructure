# Data Model: Ansible Repository Layout

## Entities

### CanonicalLayout

**Purpose**: Defines the required filesystem contract for all automation assets.

**Attributes**:

- `root_path`: `./ansible/`
- `required_paths`: List of required directories and files
- `placeholder_files`: Files that must exist even when empty
- `allowed_extensions`: YAML, templates, scripts, and snapshot files used by
  automation

**Relationships**:

- Owns many `LayoutNode` entries.
- Governs placement of all `AutomationAsset` entries.

### LayoutNode

**Purpose**: Represents a directory or file in the canonical structure.

**Attributes**:

- `path`: Repository-relative path
- `node_type`: Directory or file
- `is_required`: Boolean
- `is_placeholder`: Boolean (files only)
- `category`: inventories, roles, playbooks, scripts, vars, config

**Relationships**:

- Belongs to `CanonicalLayout`.
- Parent-child relationship with other `LayoutNode` entries.

### AutomationAsset

**Purpose**: Any automation content managed by the repository.

**Attributes**:

- `path`: Current repository-relative path
- `asset_type`: playbook, inventory, role task, template, file, script, vars
- `source_path`: Original location (for migration tracking)
- `content_hash`: Used to verify migration fidelity

**Relationships**:

- Must map to a `LayoutNode` under `CanonicalLayout`.

### MigrationRecord

**Purpose**: Tracks migration progress and validation checks.

**Attributes**:

- `asset_path`: Source path moved
- `destination_path`: Canonical path after migration
- `status`: pending, migrated, validated
- `validation_result`: pass, fail
- `notes`: Migration notes or exceptions

**Relationships**:

- References one `AutomationAsset`.

## Validation Rules

- All `AutomationAsset` entries must map to a `LayoutNode` under
  `./ansible/`.
- Every `LayoutNode` marked `is_required` must exist in the repository.
- `AutomationAsset` migration requires matching `content_hash` values.
- `placeholder_files` must exist and be tracked as committed files.

## State Transitions

### MigrationRecord

- `pending` -> `migrated` when the asset is moved to the canonical path.
- `migrated` -> `validated` when content matches the source asset.
- `migrated` -> `pending` when validation fails and remediation is needed.

## Canonical Folder Structure (Contract)

```text
ansible/
├── inventories/
│   └── home/
│       ├── hosts.yml
│       ├── group_vars/
│       │   ├── all.yml
│       │   ├── gateways.yml
│       │   └── hosts.yml
│       └── host_vars/
│           ├── hermes-gateway.yml
│           └── atlas-host.yml
├── roles/
│   ├── base/
│   │   ├── tasks/
│   │   ├── defaults/
│   │   └── vars/
│   └── hermes_gateway/
│       ├── tasks/
│       │   ├── main.yml
│       │   ├── packages.yml
│       │   ├── networking.yml
│       │   ├── dhcp.yml
│       │   └── hardware.yml
│       ├── templates/
│       ├── files/
│       ├── defaults/
│       └── vars/
│   └── atlas_host/
│       ├── tasks/
│       │   ├── main.yml
│       │   ├── packages.yml
│       │   ├── docker_config.yml
│       │   ├── hardware.yml
│       │   ├── services.yml
│       │   └── containers.yml
│       ├── containers/
│       │   ├── *.yml
│       │   └── README.md
│       ├── templates/
│       ├── files/
│       ├── defaults/
│       └── vars/
├── vars/
│   └── constants.yml
├── playbooks/
│   ├── site.yml
│   ├── gateway.yml
│   └── atlas.yml
├── scripts/
│   ├── run_site.sh
│   ├── run_atlas.sh
│   ├── run_gateway.sh
│   └── run_tag.sh
├── ansible.cfg
└── requirements.yml
```
