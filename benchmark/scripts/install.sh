#!/usr/bin/env bash

# Source pipeline_throughput.sh-aws
. env/env.instance
. env/env.git

# Install necessary dependencies for running tests on the Target system

# Helper script to make calling Ansible easier
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_CALLBACKS_ENABLED=profile_tasks
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$TARGET_USER" \
  -e "bench_path=$BENCH_PATH" \
  -e "dataprep_repo=$DATAPREP_REPO" \
  -e "dataprep_branch=$DATAPREP_BRANCH" \
  ./ansible/install.yml