#!/usr/bin/env bash
set -euo pipefail

# Entry point for running gateway automation with sudo password from Dashlane.

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/../.." && pwd)"

# Load the sudo password from Dashlane via dcli (if needed on the control host).
ANSIBLE_BECOME_PASS="$(
  dcli p --output console title=atlas-host/root
)"
export ANSIBLE_BECOME_PASS

ansible-playbook \
  -i "${repo_root}/ansible/inventories/home/hosts.yml" \
  "${repo_root}/ansible/playbooks/apply-openwrt.yml"
