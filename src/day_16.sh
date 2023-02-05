#!/usr/bin/ bash
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
	local declare -a visited_valves=$3

	visited_valve+=( $current_valve )




