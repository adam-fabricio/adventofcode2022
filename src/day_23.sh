#!/usr/bin/env bash
#
#  day_23.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1700256028 -> 17/11/23 18:20:28
#
#----------------------------------Data input---------------------------------#
if [[ "$1" == test ]]
then
    data_input="data/day_23_test"
    echo Use test data input
else
    data_input="data/day_23"
    echo "use source data input"
fi
#----------------------------------Read data input----------------------------#

declare -a elves moves
declare -A occupied
mapfile -t line < "$data_input"

#  Parsing. take  position of the elves.
for (( y=0; y<${#line[@]}; y++ )); do
	for (( x=0; x<${#line[y]}; x++ )); do
		[[ ${line[y]:$x:1} == "#" ]] && elves+=("$x $y") && occupied["$x $y"]=1
	done
done

echo "elf ${#elves[@]} occupied ${#occupied[@]}"

#  Creat a list of moves

moves+=("0 -1")	#  north
moves+=("0 1")	#  south
moves+=("-1 0")	#  west
moves+=("1 0")	#  east

for (( i=0; i<10; i++ )); do
	echo "${moves[$(( i % 4 ))]}"
done
#--------------------------------------|--------------------------------------#
