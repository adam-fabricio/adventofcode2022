#!/usr/bin/env bash
#
#  day_15.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1674068124 -> 18/01/23 15:55:24
#    1674087435 -> 18/01/23 21:17:15 -> First star
#
#------------------------------------Vas-------------------------------------#
declare -A candidate_beacon

#----------------------------------Data input---------------------------------#

if [[ "$1" == test ]]
then
    data_input="data/day_15_test"
	echo Use test data input
	row=10
else
	data_input="data/day_15"
	echo "use source data input"
	row=2000000
fi
#----------------------------------Read data input----------------------------#

while read line
do
	sensor_x=$(sed -r 's/^S.*r at x=// ; s/,.*//' <<< $line)
	sensor_y=$(sed -r 's/^S.*r at x=[-+]?[0-9]+, y=// ; s/:.*//' <<< $line)
	beacon_x=$(sed -r 's/^.*x=// ; s/,.*//' <<< $line)
	beacon_y=$(sed -r 's/.*=//' <<< $line)
	distance_x=$(( $sensor_x - $beacon_x ))
	distance_y=$(( $sensor_y - $beacon_y ))
	distance_to_beacon=$(( ${distance_x#-} + ${distance_y#-} ))
    distance_to_row=$(( $sensor_y - $row ))
    signal=$(( ${distance_to_beacon#-} - ${distance_to_row#-} ))

## First Star

#    if [[ $signal -ge 0 ]]; then
#        i=$(($sensor_x-${signal#-}))
#        while [ $i -le $(($sensor_x+${signal#-})) ]
#        do
#            row_array[$i]=1
#            let i++
#        done
#    fi

	echo "sensor -> ($sensor_x,$sensor_y) Raio = $((distance_to_beacon+1))"
	x_min=$((sensor_x-distance_to_beacon-1))
	[[ x_min -lt 0 ]] && x_min=0
	x_max=$((sensor_x+distance_to_beacon+1))
	[[ x_max -gt 4000000 ]] && x_max=4000000
	for (( x=x_min ; x<=x_max ; x++ ))
	do
		delta_x=$((sensor_x-x))
		y=$((sensor_y+distance_to_beacon+1-${delta_x#-}))
		candidate_beacon["$x,$y"]=1
		y=$((sensor_y-distance_to_beacon-1+${delta_x#-}))
		candidate_beacon["$x,$y"]=1

	done
	echo -n "${#candidate_beacon[@]} -> "
	echo ${!candidate_beacon[@]}
	unset candidate_beacon
	declare -A candidate_beacon


done < "$data_input" 

#echo "row= $(( ${#row_array[@]} -1 ))"

#--------------------------------------|--------------------------------------#
#-----------------------------------Test input--------------------------------#
