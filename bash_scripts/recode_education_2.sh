# Lazy: paste a modified version of the same function, (without the conditional, since pre-2003 doesn't use flags))
awk 'BEGIN { FS = " " }; { edu=substr($1,3,2) }; 
{   if( edu == 99 || edu == 88 || edu == 77 || edu == 66) edu = "B";
    else if( edu == "17" ) edu = 7;
    else if( edu == "16" ) edu = 6;
    else if( edu >= "14" ) edu = 5;
    else if( edu == "13" ) edu = 4;
    else if( edu == "12" ) edu = 3;
    else if( edu >= "09" ) edu = 2;
    else if( edu >= "01" ) edu = 1;
    else if( edu == "00" ) edu = 0; 
    else edu = "B";;
    print substr($1,1,2) edu substr($1,5,1)
} ' $1