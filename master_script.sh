#!/bin/bash

# 1. Download data and rename 
# Script to download CDC data from years $1 to $3 with interval of $2 between
# e.g. 1983 10 2013 --> 1983, 1993, 2003, 2013

# Ensure you're in the bash_scripts folder
cd bash_scripts

sh download_data.sh $1 $2 $3

# 2. Unzip files
sh unzip.sh

# 3. Run a script on all files to extract the relevant columns using cut -
# These columns differ by year; figuring them out is the real headache.
# Had to make some education recoding choices for 2008 and earlier...see https://nscresearchcenter.org/wp-content/uploads/SCND_Report_2019.pdf for info I used when making these decisions
sh extract_columns.sh

# 4. Scan data into R, separate, label columns, and save dataframes as R data files
sh r_cleaning.sh $1 $2 $3

# 5. Load R dataframes, combine, and plot.
Rscript ../R_scripts/plot_script.R ../data/extracted/*.rds

# Files will be saved to the root dir.
