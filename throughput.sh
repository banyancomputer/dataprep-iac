#!/usr/bin/env bash

# Source pipeline_throughput.sh-aws
. env/env.benchmark

# Run the tests on the Target system
# Clears the contents of $PACKED_PATH and $UNPACKED_PATH and $MANIFEST_PATH before running
# Should run the benchmark on each directory in $TEST_SET_PATH
# For each trial it should pack the directory into $PACKED_PATH and unpack it into $UNPACKED_PATH
# It should then compare the contents of the unpacked directory to the original directory
# It writes generated Manifests to $MANIFEST_PATH
# It should record results for the trial in $RESULTS_PATH

# A helper script to make calling Ansible easier
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$TARGET_USER" \
  -e "bench_path=$BENCH_PATH" \
  -e "input_path=$INPUT_PATH" \
  -e "packed_path=$PACKED_PATH" \
  -e "unpacked_path=$UNPACKED_PATH" \
  -e "manifest_path=$MANIFEST_PATH" \
  -e "ifttt_webhook_key=$IFTTT_WEBHOOK_KEY" \
  -e "file_structures=$FILE_STRUCTURES" \
  -e "file_structures_size=$FILE_STRUCTURES_SIZE" \
  -e "file_structures_max_width=$FILE_STRUCTURES_MAX_WIDTH" \
  -e "file_structures_max_depth=$FILE_STRUCTURES_MAX_DEPTH" \
  -e "sample_size=$SAMPLE_SIZE" \
  -e "sample_time=$SAMPLE_TIME" \
  -e "warmup_time=$WARMUP_TIME" \
  -e "do_correctness_check=$DO_CORRECTNESS_CHECK" \
  ./ansible/throughput.yml