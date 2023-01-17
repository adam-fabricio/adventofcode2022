#!/usr/bin/env bash
#
#  day_14.sh
#
#---------------------------------Start Date----------------------------------#
#   start day     -> 1673756388 -> 15/01/23 01:19:48
#	first atempt  -> 1673847310 -> 16/01/23 02:35:10 - 614 - too higih
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
declare -i grains_of_sand=0
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

echo "###"
echo "Number of rocks: ${#solid[@]}"
rocks=${#solid[@]}
#echo "Rocks ${!solid[@]}"
sand_y=$(( $floor-1 ))
sand_fall="$sand_x,$sand_y"
echo "first sand: $sand"
echo "Abyss in line: $abyss"
echo "###"

raw_sand=$sand_y

#  while grain of sand not fall into abyss
while : ; do
	#  while gains of sand does not reach the rocks or fall into abyss
	while : ; do
		#  check if there anything below  
		if [[ -z ${solid[$sand_x,$(($sand_y+1))]} ]]; then
			#echo "desce em linha reta"
			let sand_y++
		#  check if there anything down left
		elif [[ -z ${solid[$(($sand_x-1)),$(($sand_y+1))]} ]]; then
			#echo "desce para esquerda"
			let sand_x-- sand_y++
		#  check if there anything down right	
		elif [[ -z ${solid[$(($sand_x+1)),$(($sand_y+1))]} ]]; then
			#echo "desce para direita"
			let sand_x++ sand_y++
		#   stable 	
		else
			#echo "estabiliza"
			solid[$sand_x,$sand_y]=1
			break
		fi
		set -x
		if [[ -z $first_star ]] && [[ $sand_y -ge $abyss ]]; then
		    first_star=$(( ${#solid[@]} - $rocks ))
		fi
		set +x

		if [[ $sand_y -eq $(( $floor + 1)) ]]; then
		    solid[$sand_x,$sand_y]=1
		    break
		fi
	done
	sand_x=500
	if [[ $sand_y -eq 0 ]]; then
	    second_star=$(( ${#solid[@]} - $rocks ))
	    break
	fi
	[[ $raw_sand -eq $sand_y ]] && let raw_sand--
	sand_y=$raw_sand
done
echo "first star: $first_star"
echo "second star: $second_star"
#--------------------------------------|--------------------------------------#
#--------------------------------------|--------------------------------------#
