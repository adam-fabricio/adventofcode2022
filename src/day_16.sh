#!/usr/bin/env bash
#
#  day_16.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1675535723 -> 04/02/23 15:35:23
#
#----------------------------------Data input---------------------------------#
if [[ "$1" == test ]]
then
    data_input="data/day_16_test"
    echo Use test data input
else
    data_input="data/day_16"
    echo "use source data input"
fi

#----------------------------------Variables----------------------------------#
declare -A flow_rate
declare -A tunnels

#----------------------------------Read data input----------------------------#



line_number=1

while read line
do
   echo "$line_number -> $line"
   valve=$(cut -d" " -f2 <<< $line)
   echo $valve
   flow=$(sed 's/.*=//g ; s/;.*//g' <<<$line)
   echo $flow
   tunnel=$(sed 's/.* to valves\? '//g <<< $line | tr -d ,)
   echo $tunnel
   let line_number++
done < "$data_input"
#--------------------------------------|--------------------------------------#
