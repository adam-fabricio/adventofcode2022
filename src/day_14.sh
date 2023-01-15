#!/usr/bin/env bash
#
#  day_14.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1673756388 -> 15/01/23 01:19:48
#
#----------------------------------Data input---------------------------------#
if [[ "$1" == teste ]]
then
    data_input="data/day_14_test"
    echo Use test data input
else
    data_input="data/day_14"
    echo "use source data input"
fi
#-------------------------------------Vars------------------------------------#
declare -A solid
#----------------------------------Read data input----------------------------#

line_number=1
while read list_coordinates
do
	IFS=' -> ' read -a coordinates <<< "$list_coordinates"
	coordinates=( ${coordinates[@]} )
	for (( i=1 ; i<${#coordinates[@]} ; i++ ))
	do
		x0=$(cut -d',' -f1 <<< ${coordinates[i-1]})
		y0=$(cut -d',' -f2 <<< ${coordinates[i-1]})
		x1=$(cut -d',' -f1 <<< ${coordinates[i]})
		y1=$(cut -d',' -f2 <<< ${coordinates[i]})
		for line in $(eval echo {$x0..$x1})
		do
			for col in $(eval echo {$y0..$y1})
			do
				if [[ -z "${solid[$line,$col]}" ]]
				then
					solid["$line,$col"]=1
				fi
			done
		done
	done
    let line_number++
done < "$data_input" 

echo "${#solid[@]}"
#--------------------------------------|--------------------------------------#
#--------------------------------------|--------------------------------------#
