This role allows an operator to customize vendor networking images.

Sample playbook:
```
- hosts: localhost
  connection: local
  gather_facts: no

  vars:
    build_params:
      - src_image_path: /home/user/images/iosv.qcow2
        image_name: iosv
      - src_image_path: /home/user/images/iosvl2.qcow2
        image_name: iosvl2

  roles:
    - build-networking-image
```
