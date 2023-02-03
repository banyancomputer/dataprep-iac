#!/usr/bin/env bash

# Source .env
. .env

# Setup an EC2 instance to mount the necessary volumes
# Should be called on deployed Ec2 instance

# A helper script to make calling Ansible easier
ansible-playbook -i "$ANSIBLE_INVENTORY" \
  -e "test_set_path=$TEST_SET_PATH" \
  -e "test_set_device=$TEST_SET_DEVICE" \
  -e "packed_path=$PACKED_PATH" \
  -e "packed_device=$PACKED_DEVICE" \
  -e "unpacked_path=$UNPACKED_PATH" \
  -e "unpacked_device=$UNPACKED_DEVICE" \
  ./ansible/ec2_setup.yml