# network-image-builder

This role allows an operator to customize vendor networking images for use in CI.

The method taken here should work with any network platform.

## Sample playbook

```yaml
- hosts: localhost
  connection: local
  gather_facts: no

  tasks:
    - include_role:
        name: network-image-builder
      vars:
        src_image_path: "{{ item.src_image_path }}"
        image_name: "{{ item.image_name }}"
      with_items:
        - src_image_path: /home/ricky/images/nxosv-final.7.0.3.I7.3.qcow2
          image_name: nxos
        - src_image_path: /home/ricky/images/vEOS-lab-4.20.1F-combined.vmdk
          image_name: eos
```

NOTE: To avoid the playbook timing out, ensure the following are set:

* `ANSIBLE_HOST_KEY_CHECKING=False`
* `ANSIBLE_PERSISTENT_COMMAND_TIMEOUT=60`

## Build process

* Stock image, defined by `src_image_path`
* Image version is identified by `checksum_to_platform_version` map
* Stock image is cloned into working directory `output_directory`
* Bootstrap

  * Stock image is booted via qemu
  * Platform specific bootstrap is loaded from `tasks/{platform}/{version}/bootstrap.yaml`

* Platform specific configuration is loaded from `tasks/{platform}/{version}/configuration.yaml`

  * Which use `{platform}_config` to load in `templates/{platform}/{version}/config.j2`
  * non-privileged port for SSH so that we don't conflict with the Linux host

* Build outputs:

  * `run_{platform}.sh`
  * `inventories/{platform}`
  * `{platform}.qcow2`

Connect

```sh
./run_{platform}.sh
# Once booted exit telnet
ssh admin@localhost -p 8022 -o StrictHostkeyChecking=no -o UserKnownHostsFile=/dev/null
```

## Adding a new platform

* Download stock image
* Add to `checksum_to_platform_version` map in `defaults/main.yml`
* Create platform specific bootstrap & configuration
  * `tasks/{platform}/{version}/bootstrap.yaml`
  * `tasks/{platform}/{version}/configuration.yaml`
  * `templates/{platform}/{version}/config.j2`
