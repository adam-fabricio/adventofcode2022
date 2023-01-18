#!/bin/bash
#
# day_xx.sh
#
#-----------------------------------Versions  --------------------------------#
#    1.0.0 -> Adam: make a init version of skeleton of project
#	 1.0.1 -> Adam: error of sixtaxe teste for test.
#-----------------------------------Test input--------------------------------#
#-----------------------------------Variable----------------------------------#

read -p "Day: "  day

echo "#!/usr/bin/env bash"
echo "#"
echo "#  day_$day.sh"
echo "#"
echo "#---------------------------------Start Date----------------------------------#"
echo "#"
echo "#    $(date +"%s -> %d/%m/%y %H:%M:%S")"
echo "#"
echo "#----------------------------------Data input---------------------------------#"
echo "if [[ \"\$1\" == test ]]"
echo "then"
echo "    data_input=\"data/day_${day}_test\""
echo "    echo "Use test data input""
echo "else"
echo "    data_input=\"data/day_$day\""
echo "    echo \"use source data input\""
echo "fi"
echo "#----------------------------------Read data input----------------------------#"
echo "line_number=1"
echo "while read line"
echo "do"
echo "    echo \"\$line_number -> \$line\" "
echo "    let line_number++"
echo "done < \"\$data_input\" "
echo "#--------------------------------------|--------------------------------------#"
