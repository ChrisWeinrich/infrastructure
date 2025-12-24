# Data Model: Atlas Host Container VLAN

## VlanNetwork

Represents the isolated VLAN segment for the service.

Fields:

- id: VLAN identifier (40)
- subnet: CIDR range (192.168.40.0/24)
- gateway: Router interface address for the VLAN
- uplink: Router/host interface carrying the VLAN

## ServerVlanInterface

Represents the atlas-host VLAN interface configuration.

Fields:

- name: Interface name (e.g., vlan40 or eth0.40)
- vlan_id: Associated VLAN ID
- address: Static IP assigned on the VLAN
- state: up, down, or error

## ContainerService

Represents the hello world web service running in a container.

Fields:

- name: Service identifier
- image: Service image reference
- vlan_network: Associated VlanNetwork
- endpoint: Service IP and port on the VLAN
- health: healthy, unhealthy, or unknown

## ServiceHostname

Represents a DNS hostname mapped to the service endpoint.

Fields:

- name: Hostname
- address: IP address of the service
- scope: LAN, Tailscale, or both
