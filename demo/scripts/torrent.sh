#!/usr/bin/env bash

# Source pipeline_throughput.sh-aws
. env/env.instance
. env/env.ifttt

# Install necessary dependencies for running tests on the Target system

# Helper script to make calling Ansible easier
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_CALLBACKS_ENABLED=profile_tasks
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$TARGET_USER" \
  -e "dataset_path=$DATASET_PATH" \
  -e "ifttt_test_webhook_key=$IFTTT_TEST_WEBHOOK_KEY" \
  ./ansible/torrent.yml