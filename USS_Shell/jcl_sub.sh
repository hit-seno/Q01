#!/bin/sh

joblog_rexx=$HOME/REXX/joblog.rex
default_SleepTime=5

if [ $# -lt 1 ]
then
        echo "Usage:"
        echo " # " $0 "'JCL_name' [SleepTime]"
	echo " "
	echo " Example1:"
	echo "  # " $0 "'CICSSHR.CICS004.JCLLIB(LISTC)'"
	echo "   default SleepTime=5 "
	echo " "
        echo " Example2:"
        echo "  # " $0 "'CICSSHR.CICS004.JCLLIB(LISTC)' 10"
        echo " "
        exit 1
fi

JCLName="//'$1'"

if [ $# -lt 2 ]
then
	SleepTime=${default_SleepTime}
elif [ $2 -ge 0 ] 
then
	SleepTime=$2
else
	SleepTime=${default_SleepTime}
fi

JobID=$(submit -j ${JCLName})

echo "JobID:" ${JobID}
echo "sleep " $SleepTime
sleep $SleepTime 

${joblog_rexx} ${JobID}


