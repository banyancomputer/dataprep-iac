#!/usr/bin/env bash

. env/env.user
. env/env.ifttt

# A helper script to make calling Ansible easier
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_CALLBACKS_ENABLED=profile_tasks
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$USER" \
  -e "dataset_path=$ROOT_PATH/dataset" \
  -e "packed_path=$EXPORT_PATH/packed" \
  -e "ifttt_test_webhook_key=$IFTTT_TEST_WEBHOOK_KEY" \
  ./ansible/run.yml