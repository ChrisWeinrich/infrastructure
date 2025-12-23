# Phase 1 Quickstart: Ansible Server Baseline

## Purpose

Provide the minimum steps to document a server, create the base configuration
YAML as a required pre-step, register the server on the router, and validate
automation connectivity.

## Prerequisites

- Access to the server to retrieve MAC address and baseline information.
- Access to the OpenWrt router management interface.
- Access to the automation runner with Ansible installed.

## Steps

1. Document the server baseline in a minimal README, including MAC address,
   server configuration summary, and base server information.
2. Create the single main configuration YAML in `ansible/configs/` and record
   the server hostname, IP address, and MAC address, along with required manual
   and defined values. This is a required pre-step before router changes.
3. Register the server on the OpenWrt router using the hostname and MAC address
   from the YAML.
4. Validate the registration by confirming the router lists the server with the
   assigned hostname.
5. Run the Ansible "Hello World" check using the hostname defined in the YAML
   file and confirm successful completion.

## Expected Result

- Documentation exists before configuration or automation.
- The base configuration YAML is the only source of Ansible configuration.
- The router has the server registered with the correct hostname.
- The Ansible connectivity check succeeds using the hostname.
