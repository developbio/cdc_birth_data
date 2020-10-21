#!/bin/bash
set -e

# Create the directory to store our data
mkdir -p ../data

# Check to make sure years are correct
if [ "$1" -lt 1983 -o "$3" -gt $(($(date +%Y) - 1)) -o "$1" -gt "$3"] 
then
    echo "Accessible CDC data only goes back until 1983. Please choose another starting year."
    echo "The most current data is from 2019. CDC birth data for year Y usually comes out 6-12 months after the end of that calendar year. Please choose another ending year."
    echo "Ensure the arguments are in order: start_year, increment, end year."
    exit 1
fi

# FTP download the data
for year in $(seq $1 $2 $3)
do
    if [ $year -lt 1994 ] # The filename structure changes in 1994
    then
        wget "ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/Datasets/DVS/natality/Nat${year}.zip" -O "../data/${year}.zip"
    else
        wget "ftp://ftp.cdc.gov/pub/Health_Statistics/NCHS/Datasets/DVS/natality/Nat${year}us.zip" -O "../data/${year}.zip"
    fi
done