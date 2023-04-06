#!/usr/bin/env bash

# Get the Packed path from the first argument
UNPACKED_PATH=$1
# Get the Ifttt webhook key from the second argument
IFTTT_TEST_WEBHOOK_KEY=$2

# Start the dataprep job in a new tmux session
tmux new -d " \
  dataprep unpack -o $UNPACKED_PATH -m manifest.json; \
  curl -X POST -H \"Content-Type: application/json\" -d \
    '{\"Title\": \"Unpacking done\"}' \
    https://maker.ifttt.com/trigger/dataprep/with/key/$IFTTT_TEST_WEBHOOK_KEY; \
  tmux wait -S unpack;"