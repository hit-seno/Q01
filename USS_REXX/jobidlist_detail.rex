/* REXX */

PARSE ARG myJobName

rc=isfcalls("on")
     /*************************/
     /* Access the ST display */
     /*************************/
Address SDSF "ISFEXEC ST"
lrc=rc
/* call msgrtn */
if lrc<>0 then
  exit 20
     /****************************/
     /* Loop for all target jobs */
     /****************************/
numrows=isfrows
do ix=1 to numrows   /* Loop for all rows returned */
  if pos(myJobName, JNAME.ix) = 1 then  /* If this is desired row */
    do
      /* if pos("JOB",JOBID.ix) = 1 then */  /* If this JOBID is started with "JOB" */
        say JNAME.ix JOBID.ix OWNERID.ix JPRIO.ix QUEUE.ix RETCODE.ix 
    end
end

rc=isfcalls("off")
exit

     /*************************************/                                    
     /* Subroutine to list error messages */                                    
     /*************************************/                                    
msgrtn: procedure expose isfmsg isfmsg2.                                        
     /************************************************/                         
     /* The isfmsg variable contains a short message */                         
     /************************************************/                         
if isfmsg<>"" then                                                              
  Say "isfmsg is:" isfmsg                                                       
     /****************************************************/                     
     /* The isfmsg2 stem contains additional messages    */                     
     /****************************************************/                     
do ix=1 to isfmsg2.0                                                            
  Say "isfmsg2."ix "is:" isfmsg2.ix                                             
end                                                                             
return                       

