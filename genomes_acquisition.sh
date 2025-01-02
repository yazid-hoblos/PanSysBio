#!/bin/bash

# Checking required arguments
if [ $# -ne 2 ]; then
    echo "Required syntax: $0 <accession_ids_list_file> <output_folder>"
    exit 1
fi

ACCESSION_FILE="$1"
OUTPUT_FOLDER="$2"

# Verify file exists
if [ ! -f "$ACCESSION_FILE" ]; then
    echo "Error: File '$ACCESSION_FILE' not found."
    exit 1
fi

mkdir -p "$OUTPUT_FOLDER"

# Directories for downloaded and unzipped files
DOWNLOAD_DIR="$OUTPUT_FOLDER/downloads"
UNZIP_DIR="$OUTPUT_FOLDER/unzipped"

mkdir -p "$DOWNLOAD_DIR"
mkdir -p "$UNZIP_DIR"

# for each accession ID
while IFS= read -r ACCESSION_ID || [[ -n "$ACCESSION_ID" ]]; do
    if [[ -z "$ACCESSION_ID" ]]; then
        continue
    fi
    
    ZIP_FILE="$DOWNLOAD_DIR/${ACCESSION_ID}.zip"
    
    echo "Downloading dataset for accession ID: $ACCESSION_ID"
    datasets download genome accession "$ACCESSION_ID" --filename "$ZIP_FILE"
    
    echo "Unzipping $ZIP_FILE"
    unzip -o "$ZIP_FILE" -d "$UNZIP_DIR/$ACCESSION_ID"
done < "$ACCESSION_FILE"

echo "All datasets downloaded and unzipped successfully."
echo "Downloaded files are in: $DOWNLOAD_DIR"
echo "Unzipped files are in: $UNZIP_DIR"
