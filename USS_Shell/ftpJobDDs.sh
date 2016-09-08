#!/bin/sh

str_time=$(date +"%Y%m%d%H%M%S")
temp_ftpcommand_file=temp_ftpcommand_${LOGNAME}${str_time}.txt
temp_JobDDList_file=temp_JobDDList_${LOGNAME}${str_time}.txt


if [ $# -lt 2 ]
then
	echo "Usage:"
	echo " # " $0 "<OutputDir> <JOBNAME>"
	exit 1
fi

OutputDir=$1
myJobName=$2

if [ ! -d ${OutputDir} ]
then
	echo "create directory: " ${OutputDir}
	mkdir ${OutputDir}
fi

./getJobDDList.sh ${myJobName} > ${temp_JobDDList_file}

### create ftp command (initial part)
echo "9.188.216.204" 		> ${temp_ftpcommand_file}
echo "CICS004"			>> ${temp_ftpcommand_file}
echo "CICS004"			>> ${temp_ftpcommand_file}
echo "quote site FILETYPE=JES"	>> ${temp_ftpcommand_file}
echo "quote site JESJOBNAME=*"	>> ${temp_ftpcommand_file}
echo "quote site JESOWNER=*"	>> ${temp_ftpcommand_file}
echo "quote site JESGETBYDSN"	>> ${temp_ftpcommand_file}
echo "lcd " ${OutputDir}	>> ${temp_ftpcommand_file}

### create ftp command (get file part)
while read DDName DSName
do 
	echo get ${DSName} ${DDName}.txt >> ${temp_ftpcommand_file=}
done < ${temp_JobDDList_file}

echo "quit" >> ${temp_ftpcommand_file}

### execute ftp
ftp < ${temp_ftpcommand_file}


rm ${temp_ftpcommand_file}
rm ${temp_JobDDList_file}




