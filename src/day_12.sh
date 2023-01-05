#!/bin/bash

# day_xx.sh

#-----------------------------------Test input--------------------------------#
test -z "$1" && echo "Erro!"  && exit 1 
#-----------------------------------Variable----------------------------------#
declare -A map
declare -i col=1
declare -i lin=1
declare -- start=""
declare -- finish=""
declare -a visited
declare -a queue
declare -i dist
declare -a neighbor_lin
declare -a neighbor_col
declare -a neighbor
read -r max_lin max_col <<< $(wc -lL < $1)
#-----------------------------------Functions---------------------------------#
#-----------------------------------MAP Parser--------------------------------#
while read -N 1 char
do
    if [[ "$char" =~ [a-zA-Z] ]] 
    then
        [ "$char" = "S" ] && start="$lin $col"
        [ "$char" = "E" ] && finish="$lin $col"
        map[$lin $col]=$( printf "%d\n" "'$char" )
        col=col+1 
    else
        lin=lin+1
        col=1 
        continue
    fi
done < $1
#--------------------------------------|--------------------------------------#
declare -p map start finish
#---------------------------------First Star----------------------------------#
visited+=( "$start" )
queue+=( "$start" )

while :
do
	read -r lin col <<< $(echo "${queue[0]}")
	[[ "$lin" -gt 1 ]] && { let lin--; neighbor_lin+=( "$lin" ); } 
	[[ "$lin" -lt "$max_lin" ]] && { let lin++; neighbor_lin+=( "$lin" ); }
	[[ "$col" -gt 1 ]] && { let col--; neighbor_col+=( "$col" ); } 
	[[ "$col" -lt "$max_col" ]] && { let col++; neighbor_col+=( "$col" ); }
	declare -p neighbor_lin neighbor_col
	break

done

#---------------------------------Second Star---------------------------------#
#-------------------------------------END-------------------------------------#
#-----------------------------------Results-----------------------------------#
#--------------------------------------|--------------------------------------#

