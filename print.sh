
for ((lin=0; lin<=30; lin++ )); do
	echo -ne "$lin ->\t"
	for ((col=0; col<=30 ; col++)); do
		x_0=$1
		y_0=$2
		r_0=$3
		delta_x_0=$(( x_0 - col ))
		delta_x_0=${delta_x_0#-}

		x_1=$4
		y_1=$5
		r_1=$6
		delta_x_1=$(( x_1 - col ))
		delta_x_1=${delta_x_1#-}
		
		if [[ col -eq 14 ]] && [[ lin -eq 11 ]]; then
			echo -n 'X'
		elif [[ delta_x_0 -le r_0 ]] && [[ lin -eq $((y_0-r_0+delta_x_0)) ]]; then
			echo -n 'A'
		elif [[ delta_x_0 -le r_0 ]] && [[ lin -eq $((y_0+r_0-delta_x_0)) ]]; then
			echo -n 'A'
		elif [[ delta_x_1 -le r_1 ]] && [[ lin -eq $((y_1-r_1+delta_x_1)) ]]; then
			echo -n 'B'
		elif [[ delta_x_1 -le r_1 ]] && [[ lin -eq $((y_1+r_1-delta_x_1)) ]]; then
			echo -n 'B'
		elif [[	col -ge x_0 ]] && [[ col -le x_1 ]] && [[ lin -eq $((col-3)) ]]
		then
			echo -n 'L'
		elif [[ lin -eq $((25-col)) ]]; then
			echo -n 'Z'
		else
			echo -n '.'
		fi
	done
	echo
done
