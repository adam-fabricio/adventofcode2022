#  '\e[FUNDO;ATTR;CORm \e[m'
#
#
#ATTR (atributos da letra):
#
#    00 - Nenhum
#    01 - Negrito
#    04 - Sublinhado
#    05 - Piscar
#    07 - Inversa (Troca cor da letra por cor de fundo da letra e vice-versa)
#    08 - Oculta 
#
#
#COR (a cor da letra):
#
#    30 - Preto
#    31 - Vermelho
#    32 - Verde
#    33 - Amarelo
#    34 - Azul
#    35 - Rosa
#    36 - Azul Claro
#    37 - Branco 
#
#
#FUNDO (cor de fundo da letra):
#
#    40 - Preto
#    41 - Vermelho
#    42 - Verde
#    43 - Amarelo
#    44 - Azul
#    45 - Rosa
#    47 - Azul Claro
#    48 - Branco 
#
#
#A minha configuração atual do shell é a seguinte:
#
#PS1='\e[01;31m\u\e[m \e[01;34m\W \$ \e[m' 

PS1='\e[44;30m\s \e[42;30m➤\u \e[43;30m \w \e[41;30m$(branch=$(git rev-parse \
--abbrev-ref HEAD 2> /dev/null); [ $branch ] && echo -n "  $branch ")\e[m $ '

#PS1="\[\033[00;30m\033[42m\]✚\u \[\033[00m\]\[\033[00;30m\033[44m\]\w \[\033[00m\]\[\033[00;30m\033[41m\]\$(git symbolic-ref --short HEAD 2> /dev/null )\[\033[00m\] $ "
