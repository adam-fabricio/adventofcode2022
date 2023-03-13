#!/usr/bin/env bash
#
#  day_18.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1678665296 -> 12/03/23 20:54:56
#    1678668914 -> 12/03/23 21:55:14
#
#----------------------------------Data input---------------------------------#
if [[ "$1" == test ]]
then
    data_input="data/day_18_test"
    echo Use test data input
else
    data_input="data/day_18"
    echo "use source data input"
fi

#----------------------------------Variables----------------------------------#
declare -A cubes
#----------------------------------Read data input----------------------------#

line_number=1
while read line
do
	cubes["${line//,/ }"]=1
done < "$data_input"
#--------------------------------------|--------------------------------------#
ans=0
for cube in "${!cubes[@]}"; do
	read x y z <<< "$cube"
	[[ "${cubes[$((x-1)) $y $z]}" ]] || ((ans+=1))
	[[ "${cubes[$((x+1)) $y $z]}" ]] || ((ans+=1))

	[[ "${cubes[$x $((y-1)) $z]}" ]] || ((ans+=1))
	[[ "${cubes[$x $((y+1)) $z]}" ]] || ((ans+=1))
	
	[[ "${cubes[$x $y $((z+1))]}" ]] || ((ans+=1))
	[[ "${cubes[$x $y $((z-1))]}" ]] || ((ans+=1))
done


echo "$ans"
