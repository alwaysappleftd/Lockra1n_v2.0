#!/bin/bash

# Change current directory to working directory
cd "$(dirname "$0")"

# Function to decode FairPlayKeyData from Plist
decode_fairplay_key_data_from_plist() {
    local plist_file=$1
    local xml_file="${plist_file}.xml"
    local encoded_data
    local decoded_data
    local inner_encoded_data
    local final_decoded_data
    local decoded_file="${output_dir}/$(basename 'IC-Info.sisv')"


    # Convert binary plist to XML format if necessary
    if file "$plist_file" | grep -q "binary"; then
        plutil -convert xml1 "$plist_file" -o "$xml_file"
    else
        cp "$plist_file" "$xml_file"
    fi

    # Extract the base64 encoded FairPlayKeyData
    encoded_data=$(grep -A 1 '<key>FairPlayKeyData</key>' "$xml_file" | sed -n 's:.*<data>\(.*\)</data>.*:\1:p')

    # Check if data was extracted
    if [[ -z "$encoded_data" ]]; then
        echo "FairPlayKeyData not found in the file."
        rm "$xml_file" # Clean up the temporary XML file
        return 1
    fi

    # Decode the first layer of base64 content
    decoded_data=$(echo "$encoded_data" | base64 --decode)

    # Extract the inner base64 encoded string (Assuming it's the entire content)
    inner_encoded_data=$(echo "$decoded_data" | tr -d '\n')

    # Decode the second layer of base64 content
    final_decoded_data=$(echo "$inner_encoded_data" | base64 --decode)

    # Save the final decoded data to a file
    echo "$final_decoded_data" > "$decoded_file"
    echo "Decoded FairPlayKeyData saved to $decoded_file"

    rm "$xml_file" # Clean up the temporary XML file
}

# Check for command-line argument
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <path_to_plist_file> <output_directory>"
    exit 1
fi

# Get the file path from the first command-line argument
plist_file_path=$1
output_dir=$2

# Check if file exists
if [[ ! -f "$plist_file_path" ]]; then
    echo "File not found!"
    exit 1
fi

# Decode and save FairPlayKeyData
decode_fairplay_key_data_from_plist "$plist_file_path"
