#!/usr/bin/env python3

import numpy as np
import pandas as pd
import sys

def calculate_coverage(input_file, chromosome_length, output_file):

    # Step 1: Initialize the coverage array
    coverage = np.zeros(chromosome_length + 2, dtype=np.int32)

    # Step 2: Read CSV file
    print("Reading input file...")
    df = pd.read_csv(input_file)
    
    # Step 3: Process ranges
    print("Marking ranges...")
    for start, end in zip(df['start_bp'], df['end_bp']):
        coverage[start] += 1
        coverage[end + 1] -= 1
    
    # Step 4: Calculate cumulative coverage
    print("Computing coverage...")
    for i in range(1, chromosome_length + 1):
        coverage[i] += coverage[i - 1]
    
    # Step 5: Write output to a file
    print("Saving results to {}...".format(output_file))
    with open(output_file, 'w') as out:
        out.write("base_pair\tcoverage\n")
        for i in range(1, chromosome_length + 1):
            out.write(str(i) + "\t" + str(coverage[i]) + "\n")
    
    print("Coverage calculation complete! Results saved.")

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: ./sweepline_script.py <input_csv_file> <chromosome_length> <output_file_name>")
        sys.exit(1)

    input_file = sys.argv[1]
    try:
        chromosome_length = int(sys.argv[2])
    except ValueError:
        print("Error: chromosome_length must be an integer.")
        sys.exit(1)
    output_file = sys.argv[3]
    calculate_coverage(input_file, chromosome_length, output_file)
