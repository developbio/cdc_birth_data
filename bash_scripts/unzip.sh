#!/bin/bash

# create directory to store files
mkdir -p ../data/unzipped

# check to make sure p7zip is installed
if dpkg --get-selections | grep -q "p7zip[[:space:]]*install$" > /dev/null
then
    echo "p7zip is installed. Proceed."  
else
    echo "Please install p7zip to unzip the 2015 file."
    echo "You can install by typing, e.g., 'sudo apt-get install p7zip-full'"
fi


# unzip the files
# 2015 use a different compression method, hence the conditional. 

for file in ../data/*.zip
do
    echo "Unzippping $year now."
    # strip all but the year
    year=$(basename $file .zip)
    
    # All years but 2015
    if [ $year -eq 2015 ]; then
        7z x ${file} -so > ../data/unzipped/${year}.txt
    # 2015 uses PPMd 
    else
        unzip -p ${file} > ../data/unzipped/${year}.txt
    fi
    echo "$year unzipped"
done

