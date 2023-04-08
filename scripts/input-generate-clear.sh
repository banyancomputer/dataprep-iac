#!/usr/bin/env bash

# Source our environment variables
. env/env.host
. env/env.input

# Check if our Benchmarks are still running

# A helper script to make calling Ansible easier
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$TARGET_USER" \
  -e "input_path=$ROOT_PATH/$INPUT_PATH" \
  ./ansible/input/clear.yml