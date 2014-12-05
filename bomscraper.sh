#!/bin/bash
base_address="ftp://ftp2.bom.gov.au/anon/gen/radar"
image_path="images"
pattern="(IDR[0-9]{3}\.T\.[0-9]{12}\.png)"
find "$image_path" -empty -delete 
raw_list=$(curl -v "$base_address")
while read -r line; do
    [[ $line =~ $pattern ]]
    file="${BASH_REMATCH[1]}"
    if [[ "$file" && ! -f "$image_path/$file" ]]; then
        echo "grabbing file $file"
        curl -m 10 -v "$base_address/$file" > "$image_path/$file"
    fi
done <<< "$raw_list"