#!/usr/bin/env bash
#
#  day_22.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1698894485 -> 02/11/23 00:08:05
#
#----------------------------------Data input---------------------------------#
if [[ "$1" == test ]]
then
    data_input="data/day_22_test"
    echo Use test data input
else
    data_input="data/day_22"
    echo "use source data input"
fi
#----------------------------------Read data input----------------------------#
declare -a directions
declare -A abs_map
declare -A open_tiles
declare -A solid_wall
declare -A empty
line_number=1

mapfile -t line < "$data_input"

for (( i = 0; i < "${#line[@]}"; i++ ))
do
	printf "%02d -> %s\n" $line_number "${line[i]}"
    let line_number++
done < "$data_input"

while read -r -a temp_directions; do
	directions+=( "$temp_directions" )
done <<< $(echo ${line[-1]} | grep -oP '\d+|\D+')

for (( row = 0; row < ((${#line[@]} - 2)); row++ )); do
	for (( col = 0; col < ${#line[row]} ; col++ )); do
		abs_map["$row $col"]="${line[row]:$col:1}"
		if [[ "${line[row]:$col:1}" == "." ]]; then
			open_tiles["$row $col"]=1
		elif [[ "${line[row]:$col:1}" == "#" ]]; then
			solid_wall["$row $col"]=1
		else
			empty["$row $col"]=1
		fi
	done
done
declare -p abs_map open_tiles solid_wall empty directions


#--------------------------------------|--------------------------------------#
