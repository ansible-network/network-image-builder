This role allows an operator to customize vendor networking images.

Sample playbook:
```
- hosts: localhost
  connection: local
  gather_facts: no

  vars:
    build_params:
      - src_image_path: /home/user/images/nxosv-final.7.0.3.I7.3.qcow2
        image_name: nxos

  roles:
    - build-networking-image
```
