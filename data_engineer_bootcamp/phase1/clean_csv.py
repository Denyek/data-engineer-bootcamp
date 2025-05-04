# import required libraries
import argparse  # For handling command-line arguments
import os        # For file path manipulation

# Create the argument parser
parser = argparse.ArgumentParser(description="Clean a CSV file by removing empty lines and replacing tabs with commas.")

# Define expected arguments: input file path and output file path
parser.add_argument("input_file", help="Path to the input CSV file")
parser.add_argument("output_file", help="Path to the output cleaned CSV file")

# Parse the command-line arguments
args = parser.parse_args()

# Open the input file for reading
with open(args.input_file, 'r') as infile:
        # Read all lines into a list
            lines = infile.readlines()

            # Clean the lines:
            # - Remove lines that are empty or contain only whitespace
            # - Replace all tabs with commas
            cleaned_lines = [line.replace('\t', ',') for line in lines if line.strip() != ""]

            # Open the output file for writing
            with open(args.output_file, 'w') as outfile:
                    # Write the cleaned lines to the output file
                        outfile.writelines(cleaned_lines)

                        # Print confirmation message
                        print(f"File cleaned and saved as: {args.output_file}")
