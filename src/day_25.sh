#!/usr/bin/env bash
#
#  day_25.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1700875423 -> 24/11/23 22:23:43
#
#----------------------------------Data input---------------------------------#
if [[ "$1" == test ]]
then
    data_input="data/day_25_test"
    echo Use test data input
else
    data_input="data/day_25"
    echo "use source data input"
fi
#----------------------------------Read data input----------------------------#
line_number=1

mapfile -t line < "$data_input"
#--------------------------------------|--------------------------------------#

for item in ${line[@]}; do
	decimal=0
	for (( i=0; i<${#item}; i++ )); do
		case "${item:$i:1}" in
			= ) val=-2	;;
			- ) val=-1	;;
			0 ) val=0	;;
			1 ) val=1	;;
			2 ) val=2	;;
		esac
		decimal=$(( decimal + val * ( 5 ** ( ${#item} - 1 - i ) ) ))
	done
	total=$(( total + decimal ))
done

echo "*****************************"
echo "Total: $total"
echo "*****************************"

while (( total != 0 )) ; do
	remainder=$(( total % 5 ))
	total=$(( total / 5 ))
	if (( remainder == 3 )); then
		remainder="="
		let total++
	elif (( remainder == 4)); then
		remainder="-"
		let total++
	fi
	result=$remainder$result
done

echo "SNAFU: $result"
echo "*****************************"

