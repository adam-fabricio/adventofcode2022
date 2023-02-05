#  '\e[FUNDO;ATTR;CORm \e[m'
#
##  ATTR (atributos da letra):
#    00 - Nenhum
#    01 - Negrito
#    04 - Sublinhado
#    05 - Piscar
#    07 - Inversa (Troca cor da letra por cor de fundo da letra e vice-versa)
#    08 - Oculta 
##  COR (a cor da letra):
#    30 - Preto
#    31 - Vermelho
#    32 - Verde
#    33 - Amarelo
#    34 - Azul
#    35 - Rosa
#    36 - Azul Claro
#    37 - Branco 
##  FUNDO (cor de fundo da letra):
#    40 - Preto
#    41 - Vermelho
#    42 - Verde
#    43 - Amarelo
#    44 - Azul
#    45 - Rosa
#    47 - Azul Claro
#    48 - Branco 
#
#PS1='\e[01;31m\u\e[m \e[01;34m\W \$ \e[m' 

#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[01;34m\] \w\[\033[00m\]$(__git_ps1) \$ '
PS1='${debian_chroot:+($debian_chroot)}\[\033[43;30m\] \s \[\033[44;30m\] \u \[\033[42;30m\]  \w \[\033[41;30m\]$(__git_ps1 "  %s ")\[\033[00m\] \$ '
