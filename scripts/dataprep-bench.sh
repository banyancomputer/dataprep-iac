#!/usr/bin/env bash

. env/env.user
. env/env.ifttt
. env/env.host
. env/env.bench

# A helper script to make calling Ansible easier
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_CALLBACKS_ENABLED=profile_tasks
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$USER" \
  -e "input_path=$INPUT_PATH" \
  -e "packed_path=$PACKED_PATH" \
  -e "unpacked_path=$UNPACKED_PATH" \
  -e "manifest_path=$MANIFEST_PATH" \
  -e "result_path=$RESULT_PATH" \
  -e "ifttt_test_webhook_key=$IFTTT_TEST_WEBHOOK_KEY" \
  ./ansible/dataprep/bench.yml