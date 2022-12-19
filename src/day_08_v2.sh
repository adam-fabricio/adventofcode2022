#!/bin/bash

# day_08.sh

#-----------------------------------Test input--------------------------------#
test -z "$1" && echo "Erro!"  && exit 1 
#-----------------------------------Variable----------------------------------#

declare -a north_tallest_tree
declare -a west_tallest_tree
declare -a east_tallest_tree
declare -a south_tallest_tree

tree_pos_x=0
tree_pos_y=0

mapfile -t woodland < $1

max_lin_tree="${#woodland}"
max_col_tree="${#woodland[0]}"

visible_tree=0
#-----------------------------------Functions---------------------------------#
#------------------------------------Codes------------------------------------#
for (( tree_pos_y=0 ; tree_pos_y<$max_lin_tree ; tree_pos_y++ ))
do
    for (( tree_pos_x=0 ; tree_pos_x<$max_col_tree ; tree_pos_x++ ))
    do
        tree=${woodland[$tree_pos_y]:$tree_pos_x:1}
        [[ "$tree_pos_x" -eq 0 ]] && { let visible_tree++;  continue ; }
        [[ "$tree_pos_x" -eq "$max_col_tree"-1 ]] && { let visible_tree++;  continue ; }
        [[ "$tree_pos_y" -eq 0 ]] && { let visible_tree++;  continue ; }
        [[ "$tree_pos_y" -eq "$max_lin_tree"-1 ]] && { let visible_tree++;  continue ; }
        
        for (( east=$tree_pos_x-1 ; east>-1 ; east-- ))
        do
            if [[ "$tree" -le "${woodland[$tree_pos_y]:$east:1}" ]]
            then
                break
            else
                [[ "$east" -eq 0 ]] && let visible_tree++
            fi
        done
        #for (( east=$tree_pos_x-1 ; east>-1 ; east++ ))
        echo -n $tree
        
    done
    echo
done
echo $visible_tree



#---------------------------------First Star----------------------------------#
#---------------------------------Second Star---------------------------------#
#-------------------------------------END-------------------------------------#
#-----------------------------------Results-----------------------------------#
#--------------------------------------|--------------------------------------#
