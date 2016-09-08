/* REXX */

PARSE ARG myJobId 

/* say "myJobId:" myJobId  "/ myDD:" myDD */

/*myJobId="JOB05587"*/

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
      /* say JNAME.ix JOBID.ix OWNERID.ix */

      /*****************************************/                               
      /* Issue the ? (JDS) action against the  */                               
      /* row to list the data sets in the job. */                               
      /******************************************/      
      Address SDSF "ISFACT ST TOKEN('"TOKEN.ix"') PARM(NP ?) (prefix jds_)" 
      lrc=rc                                                                    
      /* call msgrtn */
      if lrc<>0 then                                                            
        exit 20 

      /**********************************************/                          
      /* Find the JESMSGLG data set and read it     */                          
      /* using ISFBROWSE.  Use isflinelim to limit  */                          
      /* the number of REXX variables returned.     */                          
      /**********************************************/ 
      isflinelim = 500
      do jx=1 to jds_DDNAME.0
        say JNAME.ix||"_"||jds_DDNAME.jx JOBID.ix||"."||jds_DSName.jx 
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

