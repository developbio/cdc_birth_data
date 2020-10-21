#!/bin/bash

# 2003 - 2008
awk 'BEGIN { FS = " " }; { flag=substr($1,1,1); edu=substr($2,1,2) }; 
{ if( flag == "S" )
    if( edu == 99 ) edu = "B";
    else if( edu >= "17" ) edu = 7;
    else if( edu == "16" ) edu = 6;
    else if( edu >= "14" ) edu = 5;
    else if( edu == "13" ) edu = 4;
    else if( edu == "12" ) edu = 3;
    else if( edu >= "09" ) edu = 2;
    else if( edu >= "01" ) edu = 1;
    else if( edu == "00" ) edu = 0; 
    else edu = "B";;
    print $1 edu substr($2,3,3)} ' $1
    


    
