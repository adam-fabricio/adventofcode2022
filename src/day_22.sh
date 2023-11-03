#!/usr/bin/env bash
#
#  day_22.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1698894485 -> 02/11/23 00:08:05
#
#----------------------------------Data input---------------------------------#
#---------------------------------spin function-------------------------------#

spin(){
	local lin=${direction[0]}
	local col=${direction[1]}

	case $instruction in 
		"R")
			direction[0]=$(( col ))
			direction[1]=$(( -1 * lin ))
			;;
		"L")
			direction[0]=$(( -1 * col ))
			direction[1]=$(( lin ))
			;;
	esac
}

#---------------------------------move function-------------------------------#
move(){
	for (( i = 0; i < instruction; i++ )); do
		new_row=$(( position[0] + direction[0] ))
		new_col=$(( position[1] + direction[1] ))
		[[ $new_col -eq ${#line[$new_row]} ]] && new_col=${start_col[$new_row]}
		[[ $new_row -eq ${end_row[$new_col]} ]] && new_row=${start_row[$new_col]}
			

		if [[ ${abs_map["$new_row $new_col"]} == "#" ]]; then
			break
		else
			position=( $new_row $new_col )
		fi
	done
	#declare -p position

}

#--------------------------------------|--------------------------------------#
if [[ "$1" == test ]]
then
    data_input="data/day_22_test"
    echo Use test data input
else
    data_input="data/day_22"
    echo "use source data input"
fi
#----------------------------------Read data input----------------------------#
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

for (( row = 0; row < ((${#line[@]} - 2)); row++ )); do
	for (( col = 0; col < ${#line[row]} ; col++ )); do
		abs_map["$row $col"]="${line[row]:$col:1}"
		if [[ "${line[row]:$col:1}" == "." ]]; then
			open_tiles["$row $col"]=1
			[[ -z "${start_col[$row]}" ]] && start_col[$row]=$col
			[[ -z "${start_row[$col]}" ]] && start_row[$col]=$row
		elif [[ "${line[row]:$col:1}" == "#" ]]; then
			[[ -z "${start_col[$row]}" ]] && start_col[$row]=$col
			[[ -z "${start_row[$col]}" ]] && start_row[$col]=$row
			solid_wall["$row $col"]=1
		else
			empty["$row $col"]=1
			[[ -v start_row[$col] && -z "${end_row[$col]}"  ]] \
				&& end_row[$col]=$row
		fi
	done
done
#declare -p start_row end_row
#  starting position. ( row collumm )
col=0
while :
do
	[[ ${abs_map["0 $col"]} == "." ]] && position=( 0 $col ) && break
	let col++
done

#  starting direction ( vertical horizontal )
direction=( 0 1 )

while read -r -a instruction; do
	[[ $instruction =~ ^[0-9]+$ ]] && move || spin
done <<< $(echo ${line[-1]} | grep -oP '\d+|\D+')

declare -p position direction

#--------------------------------------|--------------------------------------#
