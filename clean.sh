#!/usr/bin/env bash

# Source our environment variables
. env/env.benchmark

# Check if our Benchmarks are still running

# A helper script to make calling Ansible easier
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$TARGET_USER" \
  -e "bench_path=$BENCH_PATH" \
  ./ansible/clean.yml