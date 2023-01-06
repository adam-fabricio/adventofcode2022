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
declare -a neighbors
declare -i elevation 
read -r max_lin max_col <<< $(wc -lL < $1)
#-----------------------------------Functions---------------------------------#
#-----------------------------------MAP Parser--------------------------------#
while read -N 1 char
do
    if [[ "$char" =~ [a-zA-Z] ]] 
    then
        [ "$char" = "S" ] && start="$col $lin"
        [ "$char" = "E" ] && finish="$col $lin"
        map[$col $lin]=$( printf "%d\n" "'$char" )
        col=col+1 
    else
        lin=lin+1
        col=1 
        continue
    fi
done < $1
#--------------------------------------|--------------------------------------#

##---------------------------------First Star----------------------------------#
#
#map[$start]="98 0"
#map[$finish]="122"
#
#visited+=( "$start" )
#queue+=( "$start" )
#
#
#while :
#do
#	read -r col lin <<< "${queue[0]}"
#    #----------------------------Create neighbor---------------------------#
#    [[ "$lin" -gt 1 ]] && neighbors+=( "$col $(($lin-1))" ) 
#    [[ "$lin" -lt "$max_lin" ]] && neighbors+=( "$col $(($lin+1))" )
#    [[ "$col" -gt 1 ]] && neighbors+=( "$(($col-1)) $lin" ) 
#    [[ "$col" -lt "$max_col" ]] && neighbors+=( "$(($col+1)) $lin" )
#    #---------------------------check neighbor-----------------------------#
#    for neighbor in "${neighbors[@]}"
#    do
#        #-----check if the neighbor has already been visited----#
#        for each_visited in "${visited[@]}"
#        do
#            [[ "$each_visited" == "$neighbor" ]] && continue 2
#        done
#        #-----------Get value for map---------------------------#
#        read -r map_value map_dist <<< ${map[$col $lin]}
#        #--------------------Check elevation--------------------#
#        #elevation=${map_value}-${map[$neighbor]}
#        elevation=${map[$neighbor]}-$map_value
#        [[ ${elevation} -gt 1 ]] && continue
#        #------------------Add to queue-------------------------#
#        queue+=( "$neighbor" )
#        #----------------mark as visited array------------------#
#        visited+=( "$neighbor" )
#        #----------------Add distance to map--------------------#
#        map["$neighbor"]+=" $(($map_dist+1))"
#        #------Check if best signal position--------------------#
#        [[ "$neighbor" == "$finish" ]] && break 2
#    done
#    
#    #----------------------unset neighbors-----------------------------------#
#	neighbors=( )
#    queue=( "${queue[@]:1}" )
#done
##exit
#echo "${map[$finish]}"
#
#
#---------------------------------Second Star---------------------------------#
map[$start]="97"
map[$finish]="122 0"

visited+=( "$finish" )
queue+=( "$finish" )


while :
do
	read -r col lin <<< "${queue[0]}"
    #----------------------------Create neighbor---------------------------#
    [[ "$lin" -gt 1 ]] && neighbors+=( "$col $(($lin-1))" ) 
    [[ "$lin" -lt "$max_lin" ]] && neighbors+=( "$col $(($lin+1))" )
    [[ "$col" -gt 1 ]] && neighbors+=( "$(($col-1)) $lin" ) 
    [[ "$col" -lt "$max_col" ]] && neighbors+=( "$(($col+1)) $lin" )
    #---------------------------check neighbor-----------------------------#
    for neighbor in "${neighbors[@]}"
    do
        #-----check if the neighbor has already been visited----#
        for each_visited in "${visited[@]}"
        do
            [[ "$each_visited" == "$neighbor" ]] && continue 2
        done
        #-----------Get value for map---------------------------#
        read -r map_value map_dist <<< ${map[$col $lin]}
        #--------------------Check elevation--------------------#
		elevation=${map[$neighbor]}-$map_value
        [[ ${elevation} -lt -1 ]] && continue
        #------------------Add to queue-------------------------#
        queue+=( "$neighbor" )
        #----------------mark as visited array------------------#
        visited+=( "$neighbor" )
        #----------------Add distance to map--------------------#
        map["$neighbor"]+=" $(($map_dist+1))"
        #------Check if best signal position--------------------#
		echo "map[neighbor] -> ${map[$neighbor]}"
        [[ ${map[$neighbor]}_value == "97"* ]] && break 3 
    done
    #declare -p queue
	#----------------------unset neighbors-----------------------------------#
	neighbors=( )
    queue=( "${queue[@]:1}" )
done
#declare -p map
for ((i=1 ; i<=$max_lin ; i++ ))
do
	echo -n "$i->"
	for ((j=1 ; j<=$max_col; j++ ))
	do
		read -r loc val <<< ${map[$j $i]}
		echo -ne "$loc|$val\t"
	done
	echo -n "<-$i"
	echo
done

#-------------------------------------END-------------------------------------#
#-----------------------------------Results-----------------------------------#
#--------------------------------------|--------------------------------------#

