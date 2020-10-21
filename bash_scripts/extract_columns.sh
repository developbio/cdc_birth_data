#!/bin/bash

mkdir -p ../data/extracted
for path in ../data/unzipped/*.txt
do
    file=$(basename $path)
    year=$(basename $file .txt)
    
    # 2014 - 2019
    if [ $year -ge 2014 ]; then
        cut -c 75-76,124,179 $path > ../data/extracted/${year}_extracted.txt
   
    # 2009 - 2013; substantial education missingness
    elif [ $year -ge 2009 ]; then
        cut -c 7,89-90,155,212 $path > ../data/extracted/${year}_extracted.txt
    
    # 2004 - 2008, age coding is sane; use reporting flag to recode education
    elif [ $year -ge 2004 ]; then
        cut -c 7,89-90,155-157,212 $path | sh recode_education.sh > ../data/extracted/${year}_extracted.txt

    # 2003, wack age-coding; recode age
    elif [ $year -eq 2003 ]; then
        cut -c 7,89-90,155-157,212 $path | sh recode_education.sh | sh recode_age_2003.sh > ../data/extracted/${year}_extracted.txt
    
    # 1989 - 2002
    elif [ $year -ge 1989 ]; then
        cut -c 70-71,83-84,102 $path | sh recode_education_2.sh > ../data/extracted/${year}_extracted.txt
    
    # 1969 - 1988, switch columns around
    else
        cut -c 41-42,98-99,67 $path | awk '{ print substr($1,1,2) substr($1,4,5) substr($1, 3, 1)}' | sh recode_education_2.sh > ../data/extracted/${year}_extracted.txt
    fi
    echo "Extracted $file"
done