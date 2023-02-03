#!/usr/bin/env bash

# Source .env
. .env

# Install necessary dependencies for running tests on the Target system

# Helper script to make calling Ansible easier
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -e "install_path=$INSTALL_PATH" \
  ./ansible/install.yml