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

visible_tree_flag=0
visible_tree=0
#-----------------------------------Functions---------------------------------#
#------------------------------------Codes------------------------------------#
mapfile -t woodland < $1

max_lin_tree="${#woodland}"
max_col_tree="${#woodland[0]}"

#---------------------------------First Star----------------------------------#
for (( tree_pos_y=0 ; tree_pos_y<$max_lin_tree ; tree_pos_y++ ))
do
    for (( tree_pos_x=0 ; tree_pos_x<$max_col_tree ; tree_pos_x++ ))
    do
        tree=${woodland[$tree_pos_y]:$tree_pos_x:1}
        ### --- Check the Edge --- ###
        [[ "$tree_pos_x" -eq 0 ]] && { let visible_tree++;  continue ; }
        [[ "$tree_pos_x" -eq "$max_col_tree"-1 ]] && { let visible_tree++;  continue ; }
        [[ "$tree_pos_y" -eq 0 ]] && { let visible_tree++;  continue ; }
        [[ "$tree_pos_y" -eq "$max_lin_tree"-1 ]] && { let visible_tree++;  continue ; }
        
        
        ### --- Look at West --- ###
        for (( west=$tree_pos_x-1 ; west>-1 ; west-- ))
        do
            if [[ "$tree" -le "${woodland[$tree_pos_y]:$west:1}" ]]
            then
                visible_tree_flag=0
                break
            else
                [[ "$west" -eq 0 ]] && visible_tree_flag=1
            fi
        done
        [[ "$visible_tree_flag" -eq 1 ]] && { let visible_tree++ ; continue ; }

        ### --- Look at North --- ###
        for (( north=$tree_pos_y-1 ; north>-1 ; north-- ))
        do
            if [[ "$tree" -le "${woodland[$north]:$tree_pos_x:1}" ]]
            then
                visible_tree_flag=0
                break
            else
                [[ "$north" -eq 0 ]] && visible_tree_flag=1
            fi
        done
        [[ "$visible_tree_flag" -eq 1 ]] && { let visible_tree++ ; continue ; }
        
        ### --- Look at East --- ###
        for (( east="$tree_pos_x"+1 ; east<"$max_col_tree"+1 ; east++ ))
        do
            if [[ "$tree" -le "${woodland[$tree_pos_y]:$east:1}" ]]
            then
                visible_tree_flag=0
                break
            else
                [[ "$east" -eq "$max_col_tree" ]] && visible_tree_flag=1
            fi
        done
        [[ "$visible_tree_flag" -eq 1 ]] && { let visible_tree++ ; continue ; }
        
        ### --- Look at South  --- ###
        for (( south=$tree_pos_y+1 ; south<$max_lin_tree+1 ; south++ ))
        do
            if [[ "$tree" -le "${woodland[$south]:$tree_pos_x:1}" ]]
            then
                visible_tree_flag=0
                break
            else
                [[ "$south" -eq "$max_lin_tree" ]] && visible_tree_flag=1  ### Suspeito
            fi
        done
        [[ "$visible_tree_flag" -eq 1 ]] && { let visible_tree++ ; continue ; }
        
    done
done

#---------------------------------Second Star---------------------------------#
#-------------------------------------END-------------------------------------#
#-----------------------------------Results-----------------------------------#
echo "First Star -> $visible_tree"
#--------------------------------------|--------------------------------------#
