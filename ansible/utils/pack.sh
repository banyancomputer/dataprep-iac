#!/usr/bin/env bash

# Get the Dataset path from the first argument
INPUT_PATH=$1
# Get the Packed path from the second argument
OUTPUT_PATH=$2
# Get the Manifest path from the third argument
MANIFEST_PATH=$3
# Get the Ifttt webhook key from the fourth argument
IFTTT_TEST_WEBHOOK_KEY=$4

# Start the dataprep job in a new tmux session
# Send notification to IFTTT when done
dataprep pack -i "$INPUT_PATH" -o "$OUTPUT_PATH" -m "$MANIFEST_PATH";
curl -X POST -H \"Content-Type: application/json\" -d \
  "{\"Title\": \"Dataprep Pack\", \"Input\": \"$INPUT_PATH\", \"Output\": \"$OUTPUT_PATH\"}" \
  https://maker.ifttt.com/trigger/dataprep_event/with/key/"$IFTTT_TEST_WEBHOOK_KEY";