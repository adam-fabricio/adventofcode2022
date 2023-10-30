#!/usr/bin/env bash
#
#  day_21.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1698676479 -> 30/10/23 11:34:39
#
#----------------------------------Data input---------------------------------#
if [[ "$1" == test ]]
then
    data_input="data/day_21_test"
    echo Use test data input
else
    data_input="data/day_21"
    echo "use source data input"
fi
#----------------------------------Read data input----------------------------#
line_number=1
while read line
do
    echo "$line_number -> $line" 
    let line_number++
done < "$data_input" 
#--------------------------------------|--------------------------------------#
