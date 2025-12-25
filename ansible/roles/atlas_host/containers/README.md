# Atlas Host Containers

Container definitions for the Atlas host live in this directory as YAML files
named `*.yml`.

## Run Script Convention

For each container definition `ansible/roles/atlas_host/containers/<name>.yml`,
create a matching run script named:

`ansible/scripts/run_container_<name>.sh`
