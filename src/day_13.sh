#!/usr/bin/env bash
#
#  day_13.sh
#
#----------------------------------Time Cap-----------------------------------#
#  start  ->    1673098337 -> 07/01/23 10:32:17
#  parser ->    1673113343 -> 07/01/23 14:42:23
#----------------------------------Data input---------------------------------#
if [[ "$1" == "teste" ]]
then
    data_input="data/day_13_test"
    echo Use test data input
else
    data_input="data/day_13"
    echo "use source data input"
fi
#----------------------------------Read data input----------------------------#
i=1
packtes=$(tr "\n" " " < "$data_input" | sed 's/  /\n/g')
while read -a package 
do
    echo -n "$i-> " 
    declare -p package
    let i++
done <<< "$packtes" 
#--------------------------------------|--------------------------------------#
