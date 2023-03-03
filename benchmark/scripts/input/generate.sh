#!/usr/bin/env bash

# Source our environment variables
. env/env.instance
. env/env.ifttt
. env/env.generate

# Run the Benchmark on the Target system
# Benching script handles populating inputs and cleaning up outputs

# A helper script to make calling Ansible easier
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_CALLBACKS_ENABLED=profile_tasks
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$TARGET_USER" \
  -e "bench_path=$BENCH_PATH" \
  -e "input_path=$INPUT_PATH" \
  -e "ifttt_test_webhook_key=$IFTTT_TEST_WEBHOOK_KEY" \
  -e "file_structures=$FILE_STRUCTURES" \
  -e "file_structures_size=$FILE_STRUCTURES_SIZE" \
  -e "file_structures_max_width=$FILE_STRUCTURES_MAX_WIDTH" \
  -e "file_structures_max_depth=$FILE_STRUCTURES_MAX_DEPTH" \
  ./ansible/input/generate.yml