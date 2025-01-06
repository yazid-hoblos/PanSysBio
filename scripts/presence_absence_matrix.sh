#!/bin/bash

# Checking required arguments
if [ $# -ne 2 ]; then
    echo "Required syntax: $0 <annotations_folder> <output_folder>"
    exit 1
fi

ANNOTATIONS="$1"
OUTPUT_FOLDER="$2"

# Verify directory exists
if [ ! -d "$ANNOTATIONS" ]; then
    echo "Error: File '$Annotations' not found."
    exit 1
fi

mkdir -p "$OUTPUT_FOLDER"

awk '{print "tests/simple_test/prokka_output/" substr($0, 1, length($0)-4) "/" $0}' $ANNOTATIONS/gff_files_list.txt > tmp.txt

panaroo -i temp.txt -o $OUTPUT_FOLDER --clean-mode strict

rm tmp.txt

echo "Gene Presence-Absence matrix was successfully constructed in "$OUTPUT_FOLDER"."
