#!/usr/bin/env bash

# Get the Dataset path from the first argument
DATASET_PATH=$1
# Get the Ifttt webhook key from the first argument
IFTTT_TEST_WEBHOOK_KEY=$2

# Start the torrent job in a new tmux session
tmux new -d " \
  aria2c -d $DATASET_PATH --seed-time=0 -Z -i $DATASET_PATH/torrents.txt; \
  curl -X POST -H \"Content-Type: application/json\" -d \
    '{\"Title\": \"Torrent done\"}' \
    https://maker.ifttt.com/trigger/dataprep/with/key/$IFTTT_TEST_WEBHOOK_KEY; \
  tmux wait -S aria2;"