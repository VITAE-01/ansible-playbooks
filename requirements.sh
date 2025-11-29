#!/bin/bash

# Install collections from nexus repository
NEXUS_USER=$1
NEXUS_PASSWORD=$2
COLLECTION_FILE=$3

if [[ $# -ne 3 ]]; then
    echo "Error: Invalid number of arguments."
    echo "Usage: $0 <NEXUS_USER> <NEXUS_PASSWORD> <COLLECTION_FILE>"
    exit 1
fi

# check if collection file exists
if [[ ! -f "$COLLECTION_FILE" ]]; then
    echo "Error: Collection file '$COLLECTION_FILE' not found."
    exit 1
fi

sed -n 'l' "$COLLECTION_FILE"
cat -A "$COLLECTION_FILE"


# Loop through each URL in the collection file
while IFS= read -r url; do
    # Skip empty lines and comments urls
    if [[ -z "$url" || "$url" =~ ^# ]]; then
        continue
    fi

    echo "Installing collection from nexus repository: $url"

    # filename=$(basename "$url")
    # base="${filename%.tar.gz}"
    
    # echo "Installing collection: $base from nexus repository..."

    # # Use curl to download the collection binary with authentication
    # curl -fSL -u "$NEXUS_USER:$NEXUS_PASSWORD" "$url" -O "$filename"

    # # Install the collection using ansible-galaxy
    # ansible-galaxy collection install "$filename"

    # if [[ $? -ne 0 ]]; then
    #     echo "Error: Failed to install collection '$filename'."
    #     exit 1
    # fi

    # # Remove the downloaded binary file after installation
    # rm -f "$filename"
    # echo "Successfully installed collection: $base"
done < "$COLLECTION_FILE"
