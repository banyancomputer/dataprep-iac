#!/usr/bin/env bash

# Source pipeline_throughput.sh-aws
. env/env.instance

# Setup an instance

# A helper script to make calling Ansible easier
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_CALLBACKS_ENABLED=profile_tasks

# Note (amiller68): There's probably a better way to do this with Ansible, but for now this is it
# Case switch depending on the instance provider
if [[ "$INSTANCE_PROVIDER" = "aws" ]]; then
  echo "Setting up AWS instance..."
  # Run the aws setup playbook
  ansible-playbook -i "$ANSIBLE_INVENTORY" \
    -u "$TARGET_USER" \
    -e "bench_path=$BENCH_PATH" \
    -e "input_mount=$INPUT_MOUNT" \
    -e "packed_mount=$PACKED_MOUNT" \
    -e "unpacked_mount=$UNPACKED_MOUNT" \
    -e "unpacked_device=$TF_VAR_UNPACKED_DEVICE" \
    ./ansible/setup/aws.yml
elif [[ "$INSTANCE_PROVIDER" = "hetzner" ]]; then
  echo "Setting up Hetzner instance..."
  # Run the hetzner setup playbook
  ansible-playbook -i "$ANSIBLE_INVENTORY" \
    -u "$TARGET_USER" \
    -e "bench_path=$BENCH_PATH" \
    ./ansible/setup/hetzner.yml
else
  echo "$INSTANCE_PROVIDER is not a valid instance provider."
  echo "Instance does not require setup."
  exit 0
fi
