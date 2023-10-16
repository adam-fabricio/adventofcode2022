#!/usr/bin/env bash
#
#  day_19.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1697465275 -> 16/10/23 11:07:55
#
#----------------------------------Data input---------------------------------#
if [[ "$1" == test ]]
then
    data_input="data/day_19_test"
    echo Use test data input
else
    data_input="data/day_19"
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
