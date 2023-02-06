#!/usr/bin/env bash

# Source .env-aws
. .env

# Populate the test set with random data on the Target system
# Should create $TEST_SET_COUNT directories with $TEST_SET_SIZE files each at $TEST_SET_PATH
# Makes sure $PACKED_PATH and $UNPACKED_PATH are empty

# A helper script to make calling Ansible easier
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$TARGET_USER" \
  -e "test_set_path=$TEST_SET_PATH" \
  -e "packed_path=$PACKED_PATH" \
  -e "unpacked_path=$UNPACKED_PATH" \
  -e "test_set_count=$TEST_SET_COUNT" \
  -e "test_set_size=$TEST_SET_SIZE" \
  ./ansible/populate.yml