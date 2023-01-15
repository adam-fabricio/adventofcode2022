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
declare -i line_number=1
declare -i abyss=0
declare -i floor
declare -- sand
declare -- sand_fall
declare -i sand_x=500
declare -i sand_y
#----------------------------------Read data input----------------------------#
while read list_coordinates
do
	IFS=' -> ' read -a coordinates <<< "$list_coordinates"
	coordinates=( ${coordinates[@]} )
	for (( i=1 ; i<${#coordinates[@]} ; i++ ))
	do	
		#  Split ordered pair
		x0=$(cut -d',' -f1 <<< ${coordinates[i-1]})
		y0=$(cut -d',' -f2 <<< ${coordinates[i-1]})
		x1=$(cut -d',' -f1 <<< ${coordinates[i]})
		y1=$(cut -d',' -f2 <<< ${coordinates[i]})
		
		#  Find the abyss 	
		[[ $y0 -gt $abyss ]] && abyss=$y0
		[[ $y1 -gt $abyss ]] && abyss=$y1
	    
		for x in $(eval echo {$x0..$x1})
		do
			for y in $(eval echo {$y0..$y1})
			do
				if [[ -z "${solid[$x,$y]}" ]]
				then
					solid["$x,$y"]=1
				fi
				#  Find the first floor in col 500
				if [[ $x -eq 500 ]]
				then
					[[ -z $floor ]] && floor=$y
					[[ $y -lt $floor ]] && floor=$y
				fi
			done
		done
	done
done < "$data_input" 
echo "Number of rocks: ${#solid[@]}"
#echo "Rocks ${!solid[@]}"
sand_y=$floor
set -x
sand_fall="$sand_x,$sand_y"
echo "first sand: $sand"
declare -p sand
set +x
echo "Abyss in line: $abyss"

while [[ $sand_x -le $abyss ]]; then
	while :
		
		[[ $sand_x,$sand_y+1
	
	
	


#--------------------------------------|--------------------------------------#
#--------------------------------------|--------------------------------------#
