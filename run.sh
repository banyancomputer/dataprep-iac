#!/usr/bin/env bash

# Source .env
. .env

# Run the tests on the Target system
# Clears the contents of $PACKED_PATH and $UNPACKED_PATH and $MANIFEST_PATH before running
# Should run the benchmark on each directory in $TEST_SET_PATH
# For each trial it should pack the directory into $PACKED_PATH and unpack it into $UNPACKED_PATH
# It should then compare the contents of the unpacked directory to the original directory
# It writes generated Manifests to $MANIFEST_PATH
# It should record results for the trial in $RESULTS_PATH

# A helper script to make calling Ansible easier
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -e "test_set_path=$TEST_SET_PATH" \
  -e "packed_path=$PACKED_PATH" \
  -e "unpacked_path=$UNPACKED_PATH" \
  -e "manifest_path=$MANIFEST_PATH" \
  -e "result_path=$RESULT_PATH" \
  ./ansible/run.yml