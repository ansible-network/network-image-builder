This role allows an operator to customize vendor networking images.

Sample playbook:
```
- hosts: localhost
  connection: local
  gather_facts: no

  tasks:
    - include_role:
        name: build-networking-image
      vars:
        src_image_path: "{{ item.src_image_path }}"
        image_name: "{{ item.image_name }}"
      with_items:
        - src_image_path: /home/ricky/images/nxosv-final.7.0.3.I7.3.qcow2
          image_name: nxos
        - src_image_path: /home/ricky/images/vEOS-lab-4.20.1F-combined.vmdk
          image_name: eos
```

NOTE: Make sure you pass ANSIBLE_HOST_KEY_CHECKING=False and ANSIBLE_PERSISTENT_COMMAND_TIMEOUT=60 to the playbook invoking the role,
otherwise the configure step may fail with a timeout.
