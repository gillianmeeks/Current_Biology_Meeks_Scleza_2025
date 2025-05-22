#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
	echo "Genome-Wide IBD Proportion Calculator"
	echo " "
	echo "Usage: ./automate_allchr.sh <input_file> <chromosome_lengths_file> <number_of individuals>"
exit 1
fi

# Required Arguments
input_file=$1
chromosome_lengths_file=$2
number_individuals=$3

echo "Starting genome-wide IBD calculation..."

# Run IBD Proportion Calculator for each chromosome
while IFS=',' read -r chr length; do
	if [[ "$chr" == "chromosome" ]]; then
		continue
	fi

	echo "Chromosome ${chr} of length ${length}"

	./averageIBDcalculator_singlechr.sh "${input_file}" "${chr}" "${length}" "${number_individuals}" 
done < "${chromosome_lengths_file}"
