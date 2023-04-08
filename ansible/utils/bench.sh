# Get our input path
INPUT_PATH=$1
# Get our packed path
PACKED_PATH=$2
# Get the unpacked path
UNPACKED_PATH=$3
# Get the manifest path
MANIFEST_PATH=$4
# Get the result path
RESULT_PATH=$5
# Get the Ifttt webhook key
IFTTT_TEST_WEBHOOK_KEY=$6


# Measure:
# How long it takes to pack and unpack an input
# Record how long it takes and the size of the input and output
# Record the size of the manifest
benchFunc () {
  echo "Benchmarking dataprep pack and unpack"
  echo "Benching following inputs:"
  ls $INPUT_PATH

  # Iterate over files and directories in the input path
  for input in $INPUT_PATH/*; do
    echo "Benching $input"
    # Get the name of the input
    input_name=$(basename -- "$input")
    # Time how long it takes to pack the input
    time dataprep \
      pack \
      -i $input \
      -o $PACKED_PATH/$input_name.packed \
      -m $MANIFEST_PATH/$input_name.json > $RESULT_PATH/$input_name.packed

    # Time how long it takes to unpack the input
    time dataprep \
      unpack \
      -i $PACKED_PATH/$input_name.packed \
      -o $UNPACKED_PATH/$input_name.unpacked \
      -m $MANIFEST_PATH/$input_name.json > $RESULT_PATH/$input_name.unpacked

    # Get the size of the input, packed input, unpacked input, and manifest
    input_size=$(du -sh $input | awk '{print $1}')
    packed_size=$(du -sh $PACKED_PATH/$input_name.packed | awk '{print $1}')
    unpacked_size=$(du -sh $UNPACKED_PATH/$input_name.unpacked | awk '{print $1}')
    manifest_size=$(du -sh $MANIFEST_PATH/$input_name.json | awk '{print $1}')

    # Write the results to the result file
    echo "input_name,input_size,packed_size,unpacked_size,manifest_size" > $RESULT_PATH/$input_name.sizes
    echo "$input_name,$input_size,$packed_size,$unpacked_size,$manifest_size" >> $RESULT_PATH/$input_name.sizes
  done
}


# Start the torrent job in a new tmux session
tmux new -d " \
  benchFunc; \
  curl -X POST -H \"Content-Type: application/json\" -d \
    '{\"Title\": \"Benchmark done\"}' \
    https://maker.ifttt.com/trigger/dataprep_event/with/key/$IFTTT_TEST_WEBHOOK_KEY; \
  tmux wait -S bench;"