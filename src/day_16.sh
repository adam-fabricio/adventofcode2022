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
declare -A flow_rate
declare -A tunnels

#----------------------------------Read data input----------------------------#

while read line
do
   test -z "$line" && continue
   valve=$(cut -d" " -f2 <<< $line)
   flow=$(sed 's/.*=//g ; s/;.*//g' <<<$line)
   tunnel=$(sed 's/.* to valves\? '//g <<< $line | tr -d ,)
   flow_rate["$valve"]="$flow"
   tunnels["$valve"]="$tunnel"
done < "$data_input"

# declare -p flow_rate tunnels

#--------------------------------------|--------------------------------------#

function get_max_flow_rate () {
	local current_valve=$1
	local time=$2
	local visited_valves=( $3 )
	local i=0

	##  Subtrair um minuto do tempo
	let time--
	##  Verifica se é pode abrir a válvula
	if test ${flow_rate[$current_valve]} -ne 0; then
		let time--
		self_flow=$(( ${flow_rate[$current_valve]} * $time ))
	else
		self_flow=0
	fi

	##  add valve in list of visited
	visited_valve+=( $current_valve )

	## Print tunnels path
	echo -n "$current_valve g -> "
	
	## Walk through the tunnels
	for valve in ${tunnels[$current_valve]}; do
		
		if [[ " ${visited_valve[@]} " == *" $valve "* ]]; then
			## last tunnel
			continue
		else
			## new path
			[ $i -ne 0 ] && echo -ne "\n$current_valve g ->"
			##  go to next tuneel
			echo -n "$(get_max_flow_rate $valve $time ${visited_valves[@]})"
			##  wayback
			echo -n "$current_valve b -> "
		fi
		let i++
	done
}

echo
get_max_flow_rate "AA" "31"
echo
echo



