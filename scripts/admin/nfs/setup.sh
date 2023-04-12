#!/usr/bin/env bash

source env/env.host
source env/env.user
source env/env.nfs

# A helper script to make calling Ansible easier
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_CALLBACKS_ENABLED=profile_tasks
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$USER" \
  -e "export_path=/exports" \
  ./ansible/admin/nfs/setup.yml