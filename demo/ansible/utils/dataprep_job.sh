#!/usr/bin/env bash

# Get the Dataset path from the first argument
DATASET_PATH=$1
# Get the Packed path from the second argument
PACKED_PATH=$2
# Get the Ifttt webhook key from the third argument
IFTTT_TEST_WEBHOOK_KEY=$2

# Start the dataprep job in a new tmux session
tmux new -d " \
  dataprep pack -i $DATASET_PATH -o $PACKED_PATH -m manifest.json; \
  curl -X POST -H \"Content-Type: application/json\" -d \
    '{\"Title\": \"Dataprep done\"}' \
    https://maker.ifttt.com/trigger/dataprep/with/key/$IFTTT_TEST_WEBHOOK_KEY; \
  tmux wait -S dataprep;"