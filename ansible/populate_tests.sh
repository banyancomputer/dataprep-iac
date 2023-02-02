#!/usr/bin/env bash

# Arguments
# $1: test_set_path
# $2: test_set_count
# $3: test_set_size

echo "Populating test set $1 with $2 test sets of size $3"

# Make the simple test set
mkdir -p $1/simple
touch $1/simple/test.txt
echo "test" > $1/simple/test.txt