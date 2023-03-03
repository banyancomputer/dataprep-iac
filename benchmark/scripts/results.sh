#!/usr/bin/env bash

# Source pipeline_throughput.sh
. env/env.benchmark
. env/env.ssh

mkdir -p local_result

# If the test was run with the local Ansible inventory, we need to copy the results
if [ "$ANSIBLE_INVENTORY" = "inventory/awshost" ]; then
  scp -r -i "$EC2_PEM_PATH" "$TARGET_USER@$EC2_PUBLIC_DNS:$RESULT_PATH/*" results
else
  cp -r "$RESULT_PATH" local_result
fi