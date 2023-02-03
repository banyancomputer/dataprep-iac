#!/usr/bin/env bash

# Source .env
. .env

# Copy all the results from the Target system to the local system

# Make sure the "results" directory exists in the current directory
mkdir -p ./result

# A helper script to make calling Ansible easier
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -e "result_path=$RESULT_PATH" \
  -e "local_result_path=../result" \
  ./ansible/result.yml