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
#echo "Rocks ${!solid[@]}"
sand_y=$(( $floor-1 ))
sand_fall="$sand_x,$sand_y"
echo "first sand: $sand"
echo "Abyss in line: $abyss"
echo "###"

while [[ $sand_y -le $abyss ]]; do
	if [[ $sand_fall == $sand_x,$sand_y ]] ; then
		let sand_y--
		sand_fall="500,$sand_y"
	else
		sand_x=500
		sand_y=$(cut -d',' -f2 <<< $sand_fall)
	fi
	while [[ $sand_y -le $abyss ]] ; do
		if [[ -z ${solid[$sand_x,$(($sand_y+1))]} ]]; then
			#echo "desce em linha reta"
			let sand_y++
			continue
		elif [[ -z ${solid[$(($sand_x-1)),$(($sand_y+1))]} ]]; then
			#echo "desce para esquerda"
			let sand_x-- sand_y++
			continue
		elif [[ -z ${solid[$(($sand_x+1)),$(($sand_y+1))]} ]]; then
			#echo "desce para direita"
			let sand_x++ sand_y++
			continue
		else
			#echo "estabiliza"
			solid[$sand_x,$sand_y]=1
			let grains_of_sand++
			break
		fi
	done
	#echo "sand = $sand_x,$sand_y"
	#echo "grains $grains_of_sand"
done
echo "first star: $grains_of_sand"
#--------------------------------------|--------------------------------------#
#--------------------------------------|--------------------------------------#
