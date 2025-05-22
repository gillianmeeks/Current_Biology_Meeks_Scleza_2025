#!/bin/bash

# Usage and Define Parameters	
if [ "$#" -lt 4 ]; then
    echo "Chromosome Specific IBD Coverage and Proportion Calculator"
    echo " "
    echo "Description: This program computes the proportion of IBD segments across every base pair in a dataset for a specified chromosome. It generates three output files:"
    echo "  1. Chromosome-specific IBD data file"
    echo "  2. IBD coverage file = A tab-delimited file where every base pair in a specified chromosome has a number of IBD segments that include a given base pair."
    echo "  3. IBD proportion file = A CSV file that with computed proportions of IBD at every base pair given the number of possible haplotypes for the dataset."
    echo " "
    echo "Usage: $0 <input_file> <chromosome_number> <chromosome_length> <number_individuals> [cleaned_output] [coverage_output] [proportion_output]"
    echo " "
    echo "Example:"
    echo "./averageIBDcalculator_singlechr.sh plink.csv 6 1000000 200"
    echo "./averageIBDcalculator_singlechr.sh plink.csv 6 1000000 200 outputfile1.csv outputfile2.txt outputfile3.csv"
    echo " "
    echo "Where:"
    echo "- <input_file> = a genome-wide CSV file containing columns chromosome,id1,id2,start_bp,end_bp"
    echo "- <chromosome_number> = the chromosome number itself (e.g., chromosome 6)"
    echo "- <chromosome_length> = the length of the chromosome (e.g., 1000000)"
    echo "- <number_individuals> = the number of individuals in the dataset (e.g., 200)"
    echo " "
    echo "Optional Arguments:"
    echo "Note: If all three desired output file names are not explicitly included, default names will be assigned to the three output files"
    echo "- [cleaned_output] (optional) = Output File 1: A chromosome-specific simplified CSV file"
    echo "- [coverage_output] (optional) = Output File 2: Contains coverage values for each base pair in the chromosome"
    echo "- [proportion_output] (optional) = Output File 3: Final output file with IBD proportions for each base pair in the chromosome"
    exit 1
fi

# Required arguments
input_file=$1
chromosome_number=$2
chromosome_length=$3
individuals_number=$4

# Optional and Default Output file names
if [ "$#" -ge 7 ]; then
    cleaned_output="$5"
    coverage_output="$6"
    proportion_output="$7"
else
    cleaned_output="chr${chromosome_number}_simplified.csv"
    coverage_output="chr${chromosome_number}_ibdcoverage.txt"
    proportion_output="chr${chromosome_number}_ibdproportion.csv"
fi

echo "These the intermediate and output file names:"
echo "Step 1 Intermediate File: $cleaned_output"
echo "Step 2 Intermediate File: $coverage_output"
echo "Step 3 Final Output File: $proportion_output"

# Step 1: Prepare Chromosome File
awk -F',' -v chr="$chromosome_number" 'NR==1 || $1 == chr {print}' "$input_file" > "$cleaned_output"

echo "Filtered file created: $cleaned_output"

# Step 2: Run Sweepline Script
python3 ./sweepline_script.py "$cleaned_output" "$chromosome_length" "$coverage_output"

echo "IBD Coverage generated and saved to $coverage_output"

# Step 3: Calculating the Proportions
choose_2=$(((individuals_number * (individuals_number - 1)) / 2))
number_haplotypes=$((choose_2 * 2)) 
sed 's/\t/,/g' "$coverage_output" | awk -F',' -v haplotypes="$number_haplotypes" '{print $1, $2, $2/haplotypes}' | sed 's/ /,/g' | sed 's/coverage,0/coverage,frequency/g' > "$proportion_output"

echo "Proportions calculation saved to $proportion_output"
