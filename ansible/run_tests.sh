#!/usr/bin/env bash

# Arguments
# $1: test_set_path
# $2: packed_path
# $3: unpacked_path
# $4: manifest_path

# Make a

echo "Running test on $1"

# Iterate over the directories in the test set
for dir in $1/*; do
  # Run the dataprep binary on the directory and time it
  echo "Packing $dir"
  # Declare a name for out manifest
  manifest_file=$4/$(basename $dir).json
  time dataprep pack --input-dir $dir --output-dir $2 --manifest-file $manifest_file
  echo "Unpacking $dir"
  time dataprep unpack --input-dir $3 --output-dir $3 --manifest-file $manifest_file
  echo "Comparing $2 and $3"
  # If the directories are different, exit with an error
  if ! diff -r $2 $3; then
    echo "Test failed"
    exit 1
  fi
  echo "Test passed"
done

echo "Testing complete"