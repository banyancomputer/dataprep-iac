#!/usr/bin/env bash

# Source our environment variables
. env/env.host
. env/env.input
. env/env.user

export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$USER" \
  -e "input_path=$INPUT_PATH" \
  ./ansible/input/clear.yml