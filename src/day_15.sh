#!/usr/bin/env bash
#
#  day_15.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1674068124 -> 18/01/23 15:55:24
#
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
	distance=$(( ${distance_x#-} - ${distance_y#-} ))

	echo
	echo "Sensor: ($sensor_x, $sensor_y) beacon: ($beacon_x, $beacon_y)
	distance: $distance"
	echo
done < "$data_input" 
#--------------------------------------|--------------------------------------#
#-----------------------------------Test input--------------------------------#
