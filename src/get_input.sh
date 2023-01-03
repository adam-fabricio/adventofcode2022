#!/bin/bash
#
# get_input.sh   -   Get data input from adventofcode
#
#------------------------------------Usage------------------------------------#
#
# Usage: bash src/get_input.sh <day> <year>  > 1.in
#   if not inform day the default value is 1
#   if not inform year the default value is 2022
#
#----------------------------------Description--------------------------------#
# Get input of https://adventofcode.com
# You must fill in SESSION following the instructions below.
# DO NOT run this in a loop, just once.
#
# 1) Go to https://adventofcode.com/2022/day/1/input
# You can find SESSION by using Chrome tools:
# 2.1) right-click -> inspect -> click "Network".
# You can find SESSION by using Firefox tools:
# 2.2)right-click -> inspect -> click "storage"
# 3) Refresh
# 4) Click click
# 5) Click cookies
# 6) Grab the value for session. 
# 7) Save a in file in ./session.conf
#
#-----------------------------------Variable----------------------------------#
session_address=./session.conf
day=${1:-1}
year=${2:-2022}
#---------------------------------Get Input-----------------------------------#
read session < $session_address
#-------------------------------Assembly url----------------------------------#

url="https://adventofcode.com/$year/day/$day/input --cookie session=$session"


#------------------------------------Codes------------------------------------#
curl $url
