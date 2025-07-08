#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <pdf_file_path>"
    exit 1
fi

input_file="$1"
filename=$(basename "$input_file" .pdf)
directory=$(dirname "$input_file")
temp_dir=$(mktemp -d)

total_pages=$(pdfinfo "$input_file" | grep Pages | awk '{print $2}')
split_point=$((total_pages / 2))

output_file1="${directory}/${filename}_1.pdf"
output_file2="${directory}/${filename}_2.pdf"

pdfseparate "$input_file" "$temp_dir/page-%d.pdf"

first_half_pages=$(find "$temp_dir" -name "page-*.pdf" | sort -V | head -n "$split_point")
pdfunite $first_half_pages "$output_file1"

second_half_pages=$(find "$temp_dir" -name "page-*.pdf" | sort -V | tail -n $((total_pages - split_point)))
pdfunite $second_half_pages "$output_file2"

rm -rf "$temp_dir"

echo "Split complete: $output_file1 and $output_file2"
