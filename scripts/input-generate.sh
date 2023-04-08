#!/usr/bin/env bash

# Always source the host
. env/env.host

# Source tool specific envs
. env/env.user
. env/env.ifttt
. env/env.input

export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_CALLBACKS_ENABLED=profile_tasks
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$USER" \
  -e "input_path=$$ROOT_PATH/INPUT_PATH" \
  -e "ifttt_test_webhook_key=$IFTTT_TEST_WEBHOOK_KEY" \
  -e "file_structures=$FILE_STRUCTURES" \
  -e "file_structures_size=$FILE_STRUCTURES_SIZE" \
  -e "file_structures_max_width=$FILE_STRUCTURES_MAX_WIDTH" \
  -e "file_structures_max_depth=$FILE_STRUCTURES_MAX_DEPTH" \
  ./ansible/input/generate.yml