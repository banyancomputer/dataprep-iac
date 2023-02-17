#!/usr/bin/env bash

# Source our environment variables
. env/env.benchmark

# Run the Benchmark on the Target system
# Benching script handles populating inputs and cleaning up outputs

# A helper script to make calling Ansible easier
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$TARGET_USER" \
  -e "bench_path=$BENCH_PATH" \
  -e "input_path=$INPUT_PATH" \
  -e "packed_path=$PACKED_PATH" \
  -e "unpacked_path=$UNPACKED_PATH" \
  -e "manifest_path=$MANIFEST_PATH" \
  -e "result_path=$RESULT_PATH" \
  -e "ifttt_test_webhook_key=$IFTTT_TEST_WEBHOOK_KEY" \
  -e "file_structures=$FILE_STRUCTURES" \
  -e "file_structures_size=$FILE_STRUCTURES_SIZE" \
  -e "file_structures_max_width=$FILE_STRUCTURES_MAX_WIDTH" \
  -e "file_structures_max_depth=$FILE_STRUCTURES_MAX_DEPTH" \
  -e "sample_size=$SAMPLE_SIZE" \
  -e "sample_time=$SAMPLE_TIME" \
  -e "warmup_time=$WARMUP_TIME" \
  -e "do_correctness_check=$DO_CORRECTNESS_CHECK" \
  -e "profile_time=$PROFILE_TIME" \
  ./ansible/benchmark.yml