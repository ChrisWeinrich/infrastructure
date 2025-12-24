# Data Model: Static IP and Hostnames

## Entity: Device

- **Purpose**: A managed machine such as the router or server.
- **Fields**:
  - id (stable identifier)
  - role (router, server)
  - hostname (unique name)
  - management_address (IP address on LAN)
  - site (association to network structure)
- **Relationships**:
  - Belongs to one Network Structure section
  - Has one Address Assignment
- **Validation rules**:
  - hostname is unique within the site
  - management_address is unique within the site

## Entity: Address Assignment

- **Purpose**: The fixed IP address associated with a device.
- **Fields**:
  - address (IPv4 address)
  - subnet (e.g., 192.168.1.0/24)
  - device_id
- **Relationships**:
  - Assigned to one Device
- **Validation rules**:
  - address must be within subnet
  - address must not conflict with another Device address

## Entity: Hostname

- **Purpose**: The unique name used to identify a device.
- **Fields**:
  - name
  - device_id
- **Relationships**:
  - Associated with one Device
- **Validation rules**:
  - name must be unique within the site

## Entity: Network Structure

- **Purpose**: Logical grouping of site, networks, and devices.
- **Fields**:
  - site_name
  - networks (list)
  - devices (list)
- **Relationships**:
  - Contains Devices and Address Assignments
- **Validation rules**:
  - All devices reference a valid site_name

## Entity: Configuration Source

- **Purpose**: The central location that stores network, device, and addressing
  values.
- **Fields**:
  - source_path
  - last_updated
  - schema_version
- **Relationships**:
  - Contains Network Structure data
- **Validation rules**:
  - Required keys for site, networks, devices, and addressing are present
