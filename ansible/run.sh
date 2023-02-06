#!/usr/bin/env bash

# Arguments
# $1: test_set_path
# $2: packed_path
# $3: unpacked_path
# $4: manifest_path
# $5: result_path

# Make a

echo "Running test on $1"

TIMESTAMP=$(date +%s)

echo "TIMESTAMP: $TIMESTAMP"

# Iterate over the directories in the test set
for dir in $1/*; do
   # Clear the contents of the packed and unpacked directories
   echo "Clearing $2 and $3"
   rm -rf "{2:?}/*"
   rm -rf "{3:?}/*"

  # Run the dataprep binary on the directory and time it
  echo "Packing $dir to $2"
  # Declare a name for out manifest
  manifest_file=$4/$(basename $dir)-$TIMESTAMP.json
  time dataprep pack --input-dir $dir --output-dir $2 --manifest-file $manifest_file
  echo "Unpacking $2 to $3"
  time dataprep unpack --input-dir $2 --output-dir $3 --manifest-file $manifest_file
  echo "Comparing $dir and $3"
  # If the directories are different, exit with an error
  test_result=""
  if ! diff -r $dir $3; then
    test_result="Test failed"
  else
    test_result="Test passed"
  fi
  # Echo the results to the console
  echo "$test_result"
  # Write the results to a file
  results_file=$5/$(basename $dir)-$TIMESTAMP.txt
  echo "$test_result" >> "$results_file"
done

echo "Testing complete"