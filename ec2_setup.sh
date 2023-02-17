#!/usr/bin/env bash

# Source pipeline_throughput.sh-aws
. env/env.benchmark

# Setup an EC2 instance to mount the necessary volumes
# Should be called on deployed Ec2 instance

# A helper script to make calling Ansible easier
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -u "$TARGET_USER" \
  -e "input_mount=$INPUT_MOUNT" \
  -e "packed_mount=$PACKED_MOUNT" \
  -e "unpacked_mount=$UNPACKED_MOUNT" \
  -e "input_device=$TF_VAR_INPUT_DEVICE" \
  -e "packed_device=$TF_VAR_PACKED_DEVICE" \
  -e "unpacked_device=$TF_VAR_UNPACKED_DEVICE" \
  -e "input_size_gb=$TF_VAR_INPUT_SIZE_GB" \
  -e "total_input_size_gb=$TF_VAR_TOTAL_INPUT_SIZE_GB" \
  ./ansible/ec2_setup.yml