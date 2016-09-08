#!/bin/sh

sdsf_rexx=$HOME/REXX/sdsf.rex

if [ $# -ne 1 ]
then
	echo "Usage:"
	echo " # " $0 "<SDSF_command_list_file>"
	exit 1
fi

FILENAME=$1

if [ ! -e ${FILENAME} ]
then
	echo ${FILENAME} ": file not found"
	exit 1
fi

idx=0

while read my_command[idx]
do
        echo $idx : ${my_command[$idx]}
	idx=$(( idx+1 ))

done < ${FILENAME}

echo number of commands: ${idx}

i=0
while [[ i -lt idx ]]
do
	echo ""
	echo ""
	echo "************************************************************************************"
	echo "Next Command ("$((i+1))"/"${idx}"): " ${my_command[${i}]}     
	echo "Execute this command: [enter]  /  Skip this command : s  / Finish this script: f "
	echo "************************************************************************************"
        read inputChar?"Input>"
	if [[ ${inputChar} = "s" || ${inputChar} = "S" ]] 
	then
		echo "--- Skip this command ---"
	elif [[ ${inputChar} = "f" || ${inputChar} = "F" ]]
        then
		echo "--- Finish this script ---"
		exit 1
	else
		echo "--- Execute this command ---"
		${sdsf_rexx} ${my_command[${i}]}
	fi

        i=$(( i+1 ))
done


