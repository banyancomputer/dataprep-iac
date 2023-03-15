#!/usr/bin/env bash

. env/env.user

# A helper script to make calling Ansible easier
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_CALLBACKS_ENABLED=profile_tasks
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$USER" \
  -e "dataset_path=$ROOT_PATH/dataset" \
  -e "export_path=$EXPORT_PATH" \
  -e "packed_path=/home/exports/$USER/packed" \
  ./ansible/prepare.yml