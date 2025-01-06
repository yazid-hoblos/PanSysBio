#!/bin/bash

# Checking required arguments
if [ $# -ne 1 ]; then
    echo "Required syntax: $0 <data_folder>"
    exit 1
fi

DATA_FOLDER="$1"

# Verify directory exists
if [ ! -d "$DATA_FOLDER" ]; then
    echo "Error: Directory '$DATA_FOLDER' not found."
    exit 1
fi

# for each data folder
for folder in $DATA_FOLDER/unzipped/*; do

    accession_id=$(basename "$folder")
    
    mv $folder/ncbi_dataset/data/$accession_id/*.fna "$folder"
    mv $folder/ncbi_dataset/data/*json* "$folder"
    
    rm -rf "$folder/ncbi_dataset"
    rm $folder/*.md $folder/*.txt
done 

echo "All genomes directories are restructured successfully in "$DATA_FOLDER"unzipped."
