#!/bin/bash

# day_xx.sh

#-----------------------------------Test input--------------------------------#
test -z "$1" && echo "Erro!"  && exit 1 
#-----------------------------------Variable----------------------------------#
declare -A head
declare -A tail
declare -i distance_x
declare -i distance_y
declare -a move
h_x=0	#  head position x
h_y=0	#  head position y
t_x=0	#  tail position x
t_y=0	#  tail position y

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

	##  Motion
    
	for (( i=0 ; i<${command[1]} ; i++ ))
	do
        echo "h->($h_x,$h_y)"
		h_x_old=$h_x
		h_y_old=$h_y
		let $operation_head
		distance_x=$h_x-$t_x
		distance_y=$h_y-$t_y
		


		head="$h_x $h_y"

        t1=( "$t1_x $t1_y" )

        move=( $(motion $head $t1) )
        motion $head $t1
        #declare -p move
        

        t1=( $(move_exec "${move[@]}" "$t1") )

        declare -p t1

		if [ ${distance_x#-} = "2" ] || [ ${distance_y#-} = "2" ]
		then
			t_x=$h_x_old
			t_y=$h_y_old
		fi
				
		tail[$t_x,$t_y]=1
	done
	echo "head -> ($h_x, $h_y) tail -> ($t_x, $t_y) "
done < $1




#---------------------------------First Star----------------------------------#
declare -p tail
echo ${#tail[*]}
#---------------------------------Second Star---------------------------------#
#-------------------------------------END-------------------------------------#
#-----------------------------------Results-----------------------------------#
#--------------------------------------|--------------------------------------#
