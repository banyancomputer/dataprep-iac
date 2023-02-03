#!/usr/bin/env bash

# Source .env
. .env

# Populate the test set with random data on the Target system
# Should create $TEST_SET_COUNT directories with $TEST_SET_SIZE files each at $TEST_SET_PATH
# Makes sure $PACKED_PATH and $UNPACKED_PATH are empty

# A helper script to make calling Ansible easier
sudo ansible-playbook -i inventory/localhost \
  -e "test_set_path=$TEST_SET_PATH" \
  -e "packed_path=$PACKED_PATH" \
  -e "unpacked_path=$UNPACKED_PATH" \
  -e "test_set_count=$TEST_SET_COUNT" \
  -e "test_set_size=$TEST_SET_PATH" \
  ./ansible/populate.yml