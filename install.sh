#!/usr/bin/env bash

# Source .env-aws
. .env

# Install necessary dependencies for running tests on the Target system

# Helper script to make calling Ansible easier
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$TARGET_USER" \
  -e "install_path=$INSTALL_PATH" \
  ./ansible/install.yml