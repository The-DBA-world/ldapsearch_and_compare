#!/bin/bash

# File names
file1="file1.txt"
file2="file2.txt"
output_file="unique_values.txt"

# Empty the output file
> $output_file

# Read each line of file1 and compare it with each line of file2
while IFS= read -r line1; do
  unique=true
  while IFS= read -r line2; do
    if [ "$line1" = "$line2" ]; then
      unique=false
      break
    fi
  done < "$file2"
  if $unique; then
    echo "$line1" >> "$output_file"
  fi
done < "$file1"

# Now do the same for file2, to find lines unique to file2
while IFS= read -r line2; do
  unique=true
  while IFS= read -r line1; do
    if [ "$line2" = "$line1" ]; then
      unique=false
      break
    fi
  done < "$file1"
  if $unique; then
    echo "$line2" >> "$output_file"
  fi
done < "$file2"
