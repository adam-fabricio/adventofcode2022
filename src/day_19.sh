#!/usr/bin/env bash
#
#  day_19.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1679265755 -> 19/03/23 19:42:35
#
#----------------------------------Data input---------------------------------#
if [[ "$1" == test ]]
then
    data_input="data/day_19_test"
    echo Use test data input
else
    data_input="data/day_19"
    echo "use source data input"
fi
#----------------------------------Read data input----------------------------#
id=1
while read -a line; do
	ore_robot=( "${line[6]}" )
	clay_robot=( "${line[12]}" )
	obsidian_robot=( "${line[18]}" "${line[21]}" )
	geode_robot=( "${line[27]}" "0" "${line[30]}" )
	echo "$id -> ore_robot[ ${ore_robot[@]} ] clay_robot[ ${clay_robot[@]} ]\
 obsidian_robot[ ${obsidian_robot[@]} ] geode_robot[ ${geode_robot[@]} ]"
    let id++
done < "$data_input" 
#--------------------------------------|--------------------------------------#
