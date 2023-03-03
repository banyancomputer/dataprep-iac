#!/usr/bin/env bash

# Source pipeline_throughput.sh
. env/env.instance

mkdir -p results

# This is annoying to do in Ansible, so we do it here
if [ "$INSTANCE_PROVIDER" = "aws" ]; then
  . inventory/aws/env.ssh
  echo "Copying results from EC2 Instance @ $EC2_PUBLIC_DNS"
  mkdir -p results/aws
  scp -r -i "$EC2_PEM_PATH" "$TARGET_USER@$EC2_PUBLIC_DNS:$RESULT_PATH/*" results/aws
elif [ "$INSTANCE_PROVIDER" = "hetzner" ]; then
  echo "Copying results from Hetzner Instance @ user@167.235.7.231"
  mkdir -p results/hetzner
  scp -r -i ~/.ssh/id_hetzner "user@167.235.7.231:$RESULT_PATH/*" results/hetzner
elif [ "$INSTANCE_PROVIDER" = "local" ]; then
  echo "Copying results from local machine"
  mkdir -p results/local
  cp -r "$RESULT_PATH" results/local
else
  echo "Unknown instance provider: $INSTANCE_PROVIDER"
  echo "Cannot copy results"
  exit 0
fi
