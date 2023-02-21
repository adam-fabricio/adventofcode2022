#!/bin/bash

# day_xx.sh

#-----------------------------------Test input--------------------------------#
test -z "$1" && echo "Erro!"  && exit 1 
#-----------------------------------Variable----------------------------------#
declare -A head
declare -A tail_1
declare -A tail_9
declare -a tails

h_x=0	#  head position x
h_y=0	#  head position y

#-----------------------------------Functions---------------------------------#
motion() {
	local ret
    declare -i dist_x
	declare -i dist_y
	declare -i dist
	declare -i x=0
	declare -i y=0
    
	dist_x=$1-"${3:-0}"
	dist_y=$2-"${4:-0}"
	dist=${dist_x#-}+${dist_y#-}

	if [ $dist = "3" ] 
	then
		[[ "$dist_x" -gt "0" ]] && x=1 || x=-1
		[[ "$dist_y" -gt "0" ]] && y=1 || y=-1
	else
		[ ${dist_x} -eq "2"  ] && x=1
		[ ${dist_x} -eq "-2" ] && x=-1
		[ ${dist_y} -eq "2"  ] && y=1
		[ ${dist_y} -eq "-2" ] && y=-1

	fi
    ret=("$x" "$y")
    echo "${ret[*]}"
}

move_exec () {
    declare -i x=0
    declare -i y=0

    coordinates=( $* ) 

    x=${coordinates[0]}+${coordinates[2]:-0}
    y=${coordinates[1]}+${coordinates[3]:-0}
    
    echo "$x $y" 
}

#------------------------------------Codes------------------------------------#
while read -a command
do
	case "${command[0]}" in
		R)
			operation_head=h_x++
			operation_tail=t_x++
			;;

		L)	
			operation_head=h_x--
			operation_tail=t_x--
			;;

		U)	
			operation_head=h_y++
			operation_tail=t_y++
			;;

		D)
			operation_head=h_y--
			operation_tail=t_y++
			;;
	esac

    
	for (( i=0 ; i<${command[1]} ; i++ ))
	do
		let $operation_head

        head="$h_x $h_y"
        move=$(motion $head ${tails[1]})
        tails[1]=$(move_exec "${move}" "${tails[1]}")
	    
        for idx in {2..9}
        do
            move=$(motion ${tails[$idx-1]} ${tails[$idx]})
            tails[$idx]=$(move_exec "${move}" "${tails[$idx]}")
        done
        tail_1[${tails[1]}]=1
        tail_9[${tails[9]}]=1
	done
done < $1




#---------------------------------First Star----------------------------------#
echo ${#tail_1[*]}
#---------------------------------Second Star---------------------------------#
echo ${#tail_9[*]}
#-------------------------------------END-------------------------------------#
#-----------------------------------Results-----------------------------------#
#--------------------------------------|--------------------------------------#
