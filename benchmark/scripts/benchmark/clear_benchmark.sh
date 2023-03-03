#!/usr/bin/env bash

# Source our environment variables
. env/env.benchmark

# Check if our Benchmarks are still running

# A helper script to make calling Ansible easier
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$TARGET_USER" \
  -e "bench_path=$BENCH_PATH" \
  -e "packed_path=$PACKED_PATH" \
  -e "unpacked_path=$UNPACKED_PATH" \
  -e "manifest_path=$MANIFEST_PATH" \
  -e "result_path=$RESULT_PATH" \
  ./ansible/clear_benchmark.yml