#!/usr/bin/env bash
#
#  day_17.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1677011787 -> 21/02/23 17:36:27
#
#----------------------------------Data input---------------------------------#
if [[ "$1" == test ]]
then
    data_input="data/day_17_test"
    echo Use test data input
else
    data_input="data/day_17"
    echo "use source data input"
fi
#----------------------------------Read data input----------------------------#
read move < "$data_input"

for ((rock=0; rock<2021; rock++)); do
	rock_shape=$(( rock % 5 ))
	
	echo "rock_shape $rock_shape "
done


#--------------------------------------|--------------------------------------#
