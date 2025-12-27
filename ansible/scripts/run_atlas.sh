#!/usr/bin/env bash
set -euo pipefail

# Entry point for running Atlas automation with sudo password from Dashlane.

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "${script_dir}/../.." && pwd)"

# Load the sudo password from Dashlane via dcli.
export ANSIBLE_BECOME_PASSWORD
ANSIBLE_BECOME_PASSWORD="$(
  dcli p --output console title=atlas-host/root
)"

ansible-playbook \
  -i "${repo_root}/ansible/inventories/home/hosts.yml" \
  "${repo_root}/ansible/playbooks/apply-server.yml"
