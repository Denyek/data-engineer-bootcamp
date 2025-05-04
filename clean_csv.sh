#!/bin/bash

INPUT_DIR=$1
OUTPUT_DIR=$2

mkdir -p "$OUTPUT_DIR"

for file in "$INPUT_DIR"/*.csv; do
	    filename=$(basename "$file")
	        sed '/^\s*$/d' "$file" | tr '\t' ',' > "$OUTPUT_DIR/$filename"
	done

	echo "Cleaning complete. Output in $OUTPUT_DIR"

