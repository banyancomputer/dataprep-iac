#!/usr/bin/env bash

. env/env.host
. env/env.user
. env/env.dataprep

mkdir -p results

# Open the file at $ANSIBLE_INVENTORY
# Get the first line
# Get the first string
HOST_STRING=$(head -n 1 $ANSIBLE_INVENTORY)

# Get the IP address from the first string
IP=$(echo $HOST_STRING | cut -d' ' -f1)
echo "Copying results from Host @ $USER@$IP:${RESULT_PATH:?}"
mkdir -p results/$IP
scp -r -i "$SSH_KEY_PATH" "$USER@$IP:${RESULT_PATH:?}/*" results/"$IP"