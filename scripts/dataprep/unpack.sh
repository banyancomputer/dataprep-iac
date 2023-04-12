#!/usr/bin/env bash

. env/env.user
. env/env.host
. env/env.ifttt

# Get the args from cmd line
INPUT_PATH=$1
OUTPUT_PATH=$2
MANIFEST_PATH=$3

# A helper script to make calling Ansible easier
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_CALLBACKS_ENABLED=profile_tasks
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$USER" \
  -e "input_path=$INPUT_PATH" \
  -e "output_path=$OUTPUT_PATH" \
  -e "manifest_path=$MANIFEST_PATH" \
  -e "ifttt_test_webhook_key=$IFTTT_TEST_WEBHOOK_KEY" \
  ./ansible/dataprep/unpack.yml