#!/bin/bash

output_file="llmopen.temp"

find . -type f -name "*.$1" | sort | while read -r file; do
    echo -e "// $file\n\`\`\`$1" >> "$output_file"
    cat "$file" >> "$output_file"
    echo -e "\`\`\`\n" >> "$output_file"
done

nvim "$output_file"
rm $output_file
