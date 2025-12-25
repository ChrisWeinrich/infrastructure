# Infrastructure Repository

Repository foundation for infrastructure automation, linting, and
documentation.

## Ansible Layout

- Canonical automation assets live under `ansible/`.
- Standard entry points live under `ansible/scripts/`.
- Inventory lives at `ansible/inventories/home/hosts.yml`.

## Local checks

1. Install pre-commit and enable hooks:
   - `pip install pre-commit`
   - `pre-commit install`
2. Install Markdown linting dependencies:
   - `npm ci`
3. Install documentation dependencies:
   - `pip install -r requirements-docs.txt`
4. Run all checks:
   - `pre-commit run --all-files`
   - `npm run lint:md -- "**/*.md"`
   - `mkdocs build --strict`

## Documentation

- Source files live in `docs/`.
- The MkDocs configuration is `mkdocs.yml`.
- Update `docs/` and README.md when changes affect usage or behavior.
- Remote access via Tailscale is documented in the OpenWrt runbooks under
  `docs/runbooks/`.
- Central network configuration layout:
  `docs/runbooks/network-config.md`

## OpenWrt Remote Access

- Apply and verification flow: `docs/runbooks/openwrt-apply.md`,
  `docs/runbooks/openwrt-verification.md`
- Secrets and recovery steps: `docs/runbooks/openwrt-secrets.md`,
  `docs/runbooks/openwrt-recovery.md`
- Tailscale overview: `docs/runbooks/openwrt-tailscale.md`
