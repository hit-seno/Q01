/* REXX */

PARSE ARG myJobId 

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
do ix=1 to JOBID.0
  if JOBID.ix = myJobId then
    do

      /*****************************************/                               
      /* Issue the ? (JDS) action against the  */                               
      /* row to list the data sets in the job. */                               
      /******************************************/      
      Address SDSF "ISFACT ST TOKEN('"TOKEN.ix"') PARM(NP ?) (prefix jds_)" 
      lrc=rc                                                                    
      /* call msgrtn */
      if lrc<>0 then                                                            
        exit 20 

      do jx=1 to jds_DDNAME.0
        Address SDSF "ISFBROWSE ST TOKEN('"jds_TOKEN.jx"')"
        USS_FILE=JOBID.ix||"_"||jds_DDNAME.jx||".txt"
        Say "Create file:" USS_FILE
        RC=STREAM(USS_FILE, 'C', 'OPEN WRITE REPLACE')
        /* Say 'File Open:' RC */
        do kx=1 to isfline.0
          /* Say "isfline."||kx||":" isfline.kx */
          RC=LINEOUT(USS_FILE, isfline.kx,)
        end
        RC=STREAM(USS_FILE, 'C', 'CLOSE')
        /* Say 'File Close:' RC */
      end

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

