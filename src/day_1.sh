#!/bin/bash

if test -z "$1"
then
	echo 'erro'
	exit 1
fi

soma=0
top_1=0
top_2=0
top_3=0
while read linha
do
	if test -z "$linha"
	then
		if [[ "$soma" -gt "$top_3" ]]
		then
			if [[ "$soma" -gt $top_2 ]]
			then
				if [[ "$soma" -gt $top_1 ]]
				then
					top_3="$top_2"
					top_2="$top_1"
					top_1="$soma"
				else
					top_3="$top_2"
					top_2="$soma"
				fi
			else
				top_3="$soma"
			fi
		fi
		soma=0
		continue
	fi
	soma=$(( $soma + "$linha" ))

done < "$1"

echo "Primeiro ->" "$top_1"
echo "Segundo ->" "$top_2"
echo "Terceiro ->" "$top_3"
echo
echo "Soma" $(( $top_1 + $top_2 + $top_3))
