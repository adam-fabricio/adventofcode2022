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
    west_tallest_tree=-1
    for (( tree_pos_x=0 ; tree_pos_x<$max_col_tree ; tree_pos_x++ ))
    do
        tree="${woodland[$tree_pos_y]:$tree_pos_x:1}"
        echo "($visible_tree)  | [$tree_pos_x, $tree_pos_y] -> $tree "
        
        
        if [[ "$tree_pos_x" -eq "$max_col_tree"-1 ]] 
        then
            let visible_tree++
            [[ $tree_pos_x -eq 0 ]] && west_tallest_tree=$tree
            continue
        fi

        if [[ "$tree_pos_y" -eq "$max_lin_tree"-1 ]] 
        then
            let visible_tree++
            continue
        fi
        
        [[ "$tree_pos_y" -eq 0 ]] && north_tallest_tree[$tree_pos_x]=-1
        
        
        if [[ "$tree" -gt "${north_tallest_tree[$tree_pos_x]}" ]]
        then
            let visible_tree++
            north_tallest_tree[$tree_pos_x]=$tree
        elif [[ "$tree" -gt "$west_tallest_tree" ]]
        then
            let visible_tree++
            west_tallest_tree=$tree
        else
            for ((est=$tree_pos_x+1;est<$max_lin_tree; est++ ))
            do
                if [[ "$tree" -le "${woodland[$tree_pos_y]:$est:1}" ]]
                then
                    for (( south=$tree_pos_y+1; south<$max_col_tree; south++ ))
                    do
                    if [[ "$tree" -le "${woodland[$south]:$tree_pos_x:1}" ]]
                    then
                        break
                    else
                        let visible_tree++
                        break
                    fi
                    done
                else 
                    let visible_tree++
                    break
                fi
                break
            done
        fi
        [[ $tree_pos_x -eq 0 ]] && west_tallest_tree=$tree
        
    done
done
echo $visible_tree



#---------------------------------First Star----------------------------------#
#---------------------------------Second Star---------------------------------#
#-------------------------------------END-------------------------------------#
#-----------------------------------Results-----------------------------------#
#--------------------------------------|--------------------------------------#
