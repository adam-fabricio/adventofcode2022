#!/usr/bin/env bash
#
#  day_19.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1697465275 -> 16/10/23 11:07:55
#
#----------------------------------Data input---------------------------------#
if [[ "$1" == test ]]
then
    data_input="data/day_19_test"
    echo Use test data input
else
    data_input="data/day_19"
    echo "use source data input"
fi
#------------------------------Função: imprime_lista--------------------------#

imprime_lista() {
	local -n lista="$1"
	echo "imprimindo lista:"
	for chave in "${!lista[@]}"; do
		echo "$chave -> ${lista[$chave]}"
	done
}

#------------------------------Função: maior_valor----------------------------#

maior_valor() {
	#Função para encontrar o maior valor em uma lista
	if [[ $# -lt 1 ]]; then
		echo "Erro: Nenhuma lista de valores."
		return 1
	fi
		
	#  transforma a lista em um item por linha e envia a saida para ->
	#  sort que ordena de forma numerica e decrescente ->
	#  imprime a primeira linha
	printf "%s\n" "$@" | sort --numeric-sort --reverse | head --line 1
}

#------------------------------Função calcula_qualidade-----------------------#
calcula_qualidade() {
	local -i tempo="$1"
	local -a visitado
	local -i melhor_valor=0


	#  Cria a fila
	#  fila=(ore clay obsidian geode robo_ore robo_clay robo_obsidian
	#        robo_geode, tempo)
	local -a fila=( "0 0 0 0 1 0 0 0 $tempo 0" )
	

	while [[ ${#fila[@]} -gt 0 ]]; do
		# pega o valor da fila e guarda em atual
		local atual=( ${fila[0]} )
		fila=( "${fila[@]:1}" )

		[[ ${atual[9]} -eq 7 && ${atual[7]} -eq 0 ]] && continue

		#  caso pase tempo limite
		[[ "${atual[8]}" -eq 0 ]] && continue

		#  caso seja repitido o caso
		[[ " ${visitado[@]} " =~ " ${atual[@]} " ]] && continue
		visitado+=("${atual[@]}")

		#  calcula melhor valor
		melhor_valor=$(maior_valor "$melhor_valor" "${atual[3]}")

		echo "antes da coleta: ${atual[@]} -> $melhor_valor -> ${#fila[@]}"

		local coleta[0]=$(( atual[0] + atual[4] ))
		local coleta[1]=$(( atual[1] + atual[5] ))
		local coleta[2]=$(( atual[2] + atual[6] ))
		local coleta[3]=$(( atual[3] + atual[7] ))
		local coleta[4]=$(( atual[4] ))
		local coleta[5]=$(( atual[5] ))
		local coleta[6]=$(( atual[6] ))
		local coleta[7]=$(( atual[7] ))
		local coleta[8]=$(( atual[8] - 1 ))
		local coleta[9]=${atual[9]}

		echo "Depois da coleta: ${coleta[@]}"

		# Compras
		# Compra Geode
		if [[ atual[0] -ge custo_geode_ore \
			&& atual[2] -ge custo_geode_obsidian \
			&& $(( atual[9] & 8 )) -ne 8 ]]
		then
			compra=("${coleta[@]}")
			compra[0]=$(( compra[0] - custo_geode_ore ))
			compra[2]=$(( compra[2] - custo_geode_obisidian ))
			compra[7]=$(( compra[7] + 1 ))
			coleta[9]=$(( 8 | coleta[9] ))
			temp="${compra[@]}"
			fila+=("${temp[@]}")
			#echo "xxxx ${coleta[9]}"
			echo "Depois da Compra de Geode: ${temp[@]}"
			continue
		fi
			
		# Compra obsidian
		if [[ atual[0] -ge custo_obsidian_ore \
			&& atual[1] -ge custo_obsidian_clay \
			&& atual[6] -lt custo_max_obsidian \
			&& $(( atual[9] & 1 )) -ne 1 ]]
		then
			compra=("${coleta[@]}")
			compra[0]=$(( compra[0] - custo_obsidian_ore ))
			compra[1]=$(( compra[1] - custo_obisidian_clay ))
			compra[6]=$(( compra[6] + 1 ))
			compra[9]=0
			temp="${compra[@]}"
			fila+=("${temp[@]}")
			coleta[9]=$(( 1 | coleta[9] ))
			#echo "xxx ${coleta[9]}"
			echo "Depois da Compra de obsidian: ${temp[@]}"
		fi

		# Compra clay
		if [[ atual[0] -ge custo_clay \
			&& atual[5] -lt custo_max_clay \
			&& $(( atual[9] & 2 )) -ne 2 ]]
		then
			compra=("${coleta[@]}")
			compra[0]=$(( compra[0] - custo_clay ))
			compra[5]=$(( compra[5] + 1 ))
			compra[9]=0
			temp="${compra[@]}"
			fila+=("${temp[@]}")
			coleta[9]=$(( 2 | coleta[9] ))
			#echo "xx ${coleta[9]}"
			echo "Depois da Compra de clay: ${temp[@]}"
		fi

		# Compra ore
		if [[ atual[0] -ge custo_ore \
			&& atual[4] -lt custo_max_ore \
			&& $(( atual[9] & 4 )) -ne 4 ]]
		then
			compra=("${coleta[@]}")
			compra[0]=$(( compra[0] - custo_ore ))
			compra[4]=$(( compra[4] + 1 ))
			compra[9]=0
			temp="${compra[@]}"
			fila+=("${temp[@]}")
			coleta[9]=$(( 4 | coleta[9] ))
			#echo "x ${coleta[9]}"
			echo "Depois da Compra de ore: ${temp[@]}"
		fi

		# Sem compra
		temp="${coleta[@]}"
		fila+=("${temp[@]}")
	done


}

#----------------------------------Variaveis----------------------------------#
declare -A planta
declare -a nivel_qualidade

#------------------------------------Main-------------------------------------#

while read -a line; do
	#  Da entrada gera as variaveis
	

	id="${line[1]//:/}"
	custo_ore="${line[6]}"
	custo_clay="${line[12]}"
	custo_obsidian_ore="${line[18]}"
	custo_obsidian_clay="${line[21]}"
	custo_geode_ore="${line[27]}"
	custo_geode_obsidian="${line[30]}"

	#  Máximo de cada robo.
	custo_max_ore=$(maior_valor "$custo_ore" "$custo_clay"\
		"$custo_obsidian_ore" "$custo_geode_ore")
	custo_max_clay="$custo_obsidian_clay"
	custo_max_obsidian="$custo_geode_obsidian"
	
	imprime_lista "planta"

	# nivel_qualidade["$id"]=$( calcula_qualidade "planta" "$tempo" )
	calcula_qualidade 24

	echo "Nivel de Qualidade: ${nivel_qualidade["$id"]} "

	exit
done < "$data_input"

#--------------------------------------|--------------------------------------#
