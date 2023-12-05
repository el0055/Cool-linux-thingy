#!/bin/bash

# Function to count the number of files in the current directory
function count_files() {
    file_count=$(ls | wc -l)
    echo "Number of files: $file_count"
}

# Function to list all files with their sizes, highlighting hidden files in red
function list_files_with_sizes() {
    echo "Listing all files with sizes:"
    # Use ANSI escape codes to color hidden files in red
    ls -al --color=always | awk '{if ($0 ~ /\.*\/.*/) print "\033[31m" $9 "\033[0m" "\t" $5 " bytes"; else print $9 "\t" $5 " bytes"}'
}

# Function to calculate the total size of all files in the current directory
function total_size_of_files() {
    echo "Calculating total size of all files:"
    # Use 'du' to calculate disk usage and 'grep' to extract the total size
    total_size=$(du -c | grep total | awk '{print $1}')
    echo "Total size: $total_size bytes"
}

# Function to find and display the largest file in the current directory
function find_largest_file() {
    echo "Finding the largest file:"
    # Use 'ls' and 'awk' to find the largest file based on size
    largest_file=$(ls -l | awk 'NR==1 || $5 > max {max = $5; name = $9} END {print name}')
    echo "Largest file: $largest_file"
}

# Call the functions with an ampersand to run them in the background
count_files &
list_files_with_sizes &
total_size_of_files &
find_largest_file &

# Wait for background processes to finish
wait

echo "All processes completed."




