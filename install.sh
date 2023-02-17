#!/usr/bin/env bash

# Source pipeline_throughput.sh-aws
. env/env.benchmark

# Install necessary dependencies for running tests on the Target system

# Helper script to make calling Ansible easier
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$TARGET_USER" \
  -e "bench_path=$BENCH_PATH" \
  ./ansible/install.yml