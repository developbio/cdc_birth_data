#!/bin/bash

# If year == 2003, recode the age
    # age == 01 --> actual_age < 15
    # for all values of age > 01, actual_age = age + 13

awk '{age=substr($0, 2, 2)} {
    if (age >= "01") age=age+13;
    else age=14 };
    { print substr($0,1,1) age substr($0, 3)}' $1 | cut -c1-3,5-8
