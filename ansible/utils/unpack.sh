#!/usr/bin/env bash

# Get the Output path from the first argument
OUTPUT_PATH=$1
# Get the Manifest path from the second argument
MANIFEST_PATH=$2
# Get the Ifttt webhook key from the second argument
IFTTT_TEST_WEBHOOK_KEY=$3

# Start the dataprep job in a new tmux session
dataprep unpack  -i "$INPUT_PATH" -o "$OUTPUT_PATH" -m "$MANIFEST_PATH";
curl -X POST -H \"Content-Type: application/json\" -d \
  "{\"Title\": \"Unpacking done\"}" \
  https://maker.ifttt.com/trigger/dataprep_event/with/key/"$IFTTT_TEST_WEBHOOK_KEY";