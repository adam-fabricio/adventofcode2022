#!/bin/bash
#
#  day_16.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1675535723 -> 04/02/23 15:35:23
#	 1676730203 -> 18/02/23 11:23:23
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
declare -A valve_index
declare -i inf=$((2**62-1))

#----------------------------------Read data input----------------------------#

echo -e "Parsin... \n"

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

#------------------------------index------------------------------------------#
echo "create index... \n"

index=1
for valve in ${relevant_valve[@]}; do
	valve_index[$valve]=$index
	(( index = index << 1 ))
done
1

#-------------------------Floyd-Warshal algorithm-----------------------------#

echo -e "Floyd-Warshal algorithm... \n"

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
for k in "${!tunnels[@]}"; do
	##  for each line
	for i in "${!tunnels[@]}"; do
		## for each room (collunm)
		for j in "${!tunnels[@]}"; do
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

echo -e "Visit rooms... \n"
#$z=0
declare -A total_flow
function visit () {
	local room=$1
	local time=$2
	local visited=$3
	local open_valve=$4
		time=$(( $time -1 ))
		open_valve=$(( time * ${flow_rate[$room]} + ${open_valve:-0} ))
	for neighbor in "${relevant_valve[@]}"; do
		if ((${visited:-0}&${valve_index[$neighbor]})) || [[ $time -le 0 ]] ; then
		continue
	else
		visited_a=$(( "${visited:-0}" | "${valve_index[$neighbor]}" ))
		visit $neighbor "$(( $time - ${dist[${room}-${neighbor}]} ))" "$visited_a" "$open_valve"
		fi
	done
	#echo "$z ${visited:-0} -> ${open_valve}"
	#let z++
	if [[ ${total_flow[${visited:-0}]} -lt ${open_valve} ]]; then
		total_flow["${visited:-0}"]="${open_valve}"
	fi
}
#---------------------------------Get Max Value-------------------------------#
visit "AA" "31"

echo -e "get max value... \n"

max=0
for key in "${!total_flow[@]}"; do
	echo "${key} -> ${total_flow[$key]}"
	[[ $max -lt ${total_flow[$key]} ]] && max=${total_flow[$key]}
done

echo $max

