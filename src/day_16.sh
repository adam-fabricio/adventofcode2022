#!/usr/bin/bash
#
#  day_16.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1675535723 -> 04/02/23 15:35:23
#
#----------------------------------Data input---------------------------------#
if [[ "$1" == test ]]
then
    data_input="data/day_16_test"
    echo Use test data input
else
    data_input="data/day_16"
    echo "use source data input"
fi

#----------------------------------Variables----------------------------------#
declare -a relevant_valve
declare -A flow_rate
declare -A tunnels
declare -A dist
declare -i inf=$((2**62-1))

#----------------------------------Read data input----------------------------#

while read line
do
   test -z "$line" && continue
   valve=$(cut -d" " -f2 <<< $line)
   flow=$(sed 's/.*=//g ; s/;.*//g' <<<$line)
   tunnel=$(sed 's/.* to valves\? '//g <<< $line | tr -d ,)
   flow_rate["$valve"]="$flow"
   tunnels["$valve"]="$tunnel"
   [ $flow -ne 0 ] && relevant_valve+=( $valve )
done < "$data_input"

declare -p flow_rate tunnels relevant_valve

#-------------------------Floyd-Warshal algorithm-----------------------------#

##  create matrix of distance
for initial_room in ${!tunnels[@]}; do
	for room in ${!tunnels[@]}; do
		if [[ ${tunnels[$initial_room]} == *"$room"* ]]; then
			dist["${initial_room}-${room}"]=1
		else
			dist["${initial_room}-${room}"]=$inf
		fi
	done
done

##  calculate minor distance!
##  for each Matrix
for k in ${!tunnels[@]}; do
	##  for each line
	for i in ${!tunnels[@]}; do
		## for each room (collunm)
		for j in ${!tunnels[@]}; do
			# calc minimun distance
			if [[ ${dist["$i-$j"]} -gt ${dist["$i-$k"]}+${dist["$k-$j"]} ]]
				then
				dist[$i-$j]=$((${dist[$i-$k]} + ${dist[$k-$j]}))
			fi
		done
	done
done
#
#-------------------------------Visit rooms-----------------------------------#

function visit () {
	local room=$1
	local -A valves_open=
	local time
	local -A max_flow
	


#--------------------------------------|--------------------------------------#

