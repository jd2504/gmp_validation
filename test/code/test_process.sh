#!/bin/bash

dir="."

for file in "$dir"/proc_*; do
    # Extract filename from the path
    filename=$(basename -- "$file")

    # Get the current date and time
    datetime=$(date '+%Y-%m-%d %H:%M:%S')

    # Check if the file is present in tracking.txt and if it has not been processed yet
    if awk -F'\t' -v filename="$filename" '$4 == filename && $6 == "0"' tracking.txt ; then
        echo "Processing $file..."

        # Your code to process the file goes here

        # After processing the file, update its status in tracking.txt
        
    else
        echo "$file has already been processed."
    fi
done
