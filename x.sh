#!/bin/bash

printa_valores() {
	local -A arr1=("$1")
	local -i dia="$2"

	arr1["nome"]="Fabricio"

	for k in "${!arr1[@]}"; do
		echo "$k -> ${arr1[$k]}"
	done
}

declare -A arr
arr["nome"]="Adam"
arr["peso"]=108
arr["idade"]=37

dia=15

printa_valores "${arr[@]}" "$dia"

echo valores

for k in "${!arr[@]}"; do
	echo "$k -> ${arr[$k]}"
done
