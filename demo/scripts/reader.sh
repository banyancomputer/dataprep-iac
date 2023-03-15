#!/usr/bin/env bash

. env/env.user

# Get the user name from the first argument
export READER_NAME=$1
# Get the path to the ssh-pub-key from the first argument
export READER_HOSTNAME=$2

# A helper script to make calling Ansible easier
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_CALLBACKS_ENABLED=profile_tasks
# Create the user with the specified ssh-pub-key, name, and admin status
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$USER" \
  -e "reader_name=$READER_NAME" \
  -e "reader_hostname=$READER_HOSTNAME" \
  ./ansible/admin/reader.yml