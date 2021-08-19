# Load in Libraries

library(tidyr)
library(fda)
library(ggplot2)
library(clustcurv)

#Isolating starts

starts = RTs$IAAF.Start
i = 1
runtimes = list()
handdat = list()
feetdat = list()
handcoefs = list()
feetcoefs = list()
for(athlete in athletes){
  
  # Set up each athlete 
  
  individual = athlete 
  j = 1
  
  
  for(sprint in individual){
    
    # associated start time
    time_t = starts[i]
    
    # runs above start time 
    test_run = which(sprint[,1]>=time_t)
    
    # Obtain maximum time for fit 
    max_t = max(sprint[test_run])
    
    #Runs between these times
    runtimes[[i]] = sprint[test_run]
    
    
    # Times
    x = sprint[test_run,1]
    
    # Temp for hands
    y = sprint[test_run,2]
    
    # Temp for feet
    z = sprint[test_run,3]
    
    #keep relevant data stored in a list after this loop
    handdat[[i]] = y
    feetdat[[i]] = z
    
    
    # Apply B-Spline  
    totaldat = as.data.frame(cbind(x,y))
    
    # Range of times
    rangeval = c(time_t,max_t)
    
    # Create knots
    knots = seq(time_t,max_t, length.out = 10)
    
    # B-spline basis
    sample.basis = create.bspline.basis(rangeval = rangeval, breaks = knots, norder = 3)
    
    # Associated names
    fdnames = c('time (seconds)', 'Athlete', 'Force')
    
    #  fit the data by least squares
    basismat = eval.basis(x,sample.basis)
    
    forcebasismat = eval.basis(sample.basis,x)
    forcecoef = solve(crossprod(forcebasismat),crossprod(forcebasismat,y))
    handforcefd =  fd(forcecoef,sample.basis)
    
    # Add to list 
    
    handcoefs[[i]] = handforcefd
    
    
    forcecoef2 = solve(crossprod(forcebasismat),crossprod(forcebasismat,z))
    footforcefd =  fd(forcecoef2,sample.basis)
    
    # Add to list 
    
    feetcoefs[[i]] = footforcefd
    
    
    i = i + 1
    
      
  }
  
  
  
}





