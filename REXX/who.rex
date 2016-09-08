/* REXX */
rc=isfcalls('ON')
     /* Issue the WHO command */
Address SDSF "ISFEXEC WHO"
     /* The responses are returned in the isfresp stem */
do ix=1 to isfresp.0
  Say "isfresp."ix "is:" isfresp.ix
end
rc=isfcalls('OFF')
exit

