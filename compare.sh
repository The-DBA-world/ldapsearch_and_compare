#!/bin/bash

# File paths
file1_path="file1.txt"
file2_path="file2.txt"
output_file_path="output.txt"

# Initialize an associative array to store unique lines
declare -A unique_lines

# Read file1 and populate the associative array
while IFS= read -r line1; do
    unique_lines["$line1"]=1
done < "$file1_path"

# Read file2 and remove matching lines from the associative array
while IFS= read -r line2; do
    unset "unique_lines[$line2]"
done < "$file2_path"

# Write unique lines to the output file
> "$output_file_path"  # Clear the output file
for unique_line in "${!unique_lines[@]}"; do
    echo "$unique_line" >> "$output_file_path"
done

echo "Unique values written to $output_file_path"
