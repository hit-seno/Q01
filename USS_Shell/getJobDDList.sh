#!/bin/sh

jobidlist_rexx=$HOME/REXX/jobidlist.rex
jobddlist_rexx=$HOME/REXX/jobddlist.rex
str_time=$(date +"%Y%m%d%H%M%S")
temp_jobidlist_file=temp_jobidlist_${LOGNAME}${str_time}.txt

#echo ${temp_jobidlist_file}

if [ $# -ne 1 ]
then
	echo "Usage:"
	echo " # " $0 "<JOBNAME>"
	exit 1
fi

myJobName=$1

### get JOBID list and sort with reverse order
${jobidlist_rexx} ${myJobName} | sort -r > ${temp_jobidlist_file}

### get the largest number of JOBID
read myJobId < ${temp_jobidlist_file}
#echo myJobId: ${myJobId}
rm ${temp_jobidlist_file}

### get Dataset List
${jobddlist_rexx} ${myJobId}


