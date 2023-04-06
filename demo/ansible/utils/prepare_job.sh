#!/usr/bin/env bash

# Get the Dataset path from the first argument
EXPORT_PATH=$1
# Get the Packed path from the second argument
PACKED_PATH=$2
# Get the Ifttt webhook key from the third argument
IFTTT_TEST_WEBHOOK_KEY=$3

# Start the dataprep job in a new tmux session
tmux new -d " \
  ulimit -s 65536; \
  cd $PACKED_PATH; \
  md5sum * | tr -s ' ' | tr ' ' ',' > $EXPORT_PATH/packed.csv; \
  curl -X POST -H \"Content-Type: application/json\" -d \
    '{\"Title\": \"Prepare done\"}' \
    https://maker.ifttt.com/trigger/dataprep/with/key/$IFTTT_TEST_WEBHOOK_KEY; \
  tmux wait -S prepare;"