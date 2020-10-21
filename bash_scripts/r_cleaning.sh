#!/bin/bash
for year in $(seq ${1} ${2} ${3})
do
    Rscript ../R_scripts/clean_data.R ../data/extracted/${year}_extracted.txt
    echo "Cleaned ${year} data."
done
echo "Years ${1} to ${3} cleaned, labeled, and written to R data files."