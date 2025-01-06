#!/bin/bash

# Checking required arguments
if [ $# -ne 2 ]; then
    echo "Required syntax: $0 <genomes_folder> <output_folder>"
    exit 1
fi

GENOMES="$1"
OUTPUT_FOLDER="$2"

# Verify directory exists
if [ ! -d "$GENOMES" ]; then
    echo "Error: File '$GENOMES' not found."
    exit 1
fi

mkdir -p "$OUTPUT_FOLDER"

# for each data folder
for folder in $GENOMES/*; do

    genome=$(basename "$folder")

    prokka --outdir $OUTPUT_FOLDER/$genome/ --prefix $genome --kingdom Bacteria --evalue 1e-9 --coverage 80 --quiet $folder/*.fna

done

echo "All gennomes were annotated succesfully successfully in "$OUTPUT_FOLDER"."
