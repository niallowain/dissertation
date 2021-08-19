# Creating lists of fd components 

footsplinescoefs = list()
footsplinesrangevals = list()
footsplinesparams = list()

for(i in seq(1,64)){
  footsplinescoefs[[i]] = feetcoefs[[i]]$coefs
  footsplinesrangevals[[i]] = feetcoefs[[i]]$basis$rangeval
  footsplinesparams[[i]] = feetcoefs[[i]]$basis$params
  
}


# Using chapter 8 of FDA (2009)
# Set up a functional data object specifically for feet
fdfootnames = list("Time (seconds)", "Athlete", "Force")
fdhandnames = list("Time (seconds)", "Athlete", "Force")
athletes = RTs$Subject

accelfdUN = deriv.fd(feetcoefs,2)
accelmeanfdUN = mean(accelfdUN)

regList = register.fd(accelmeanfdUN,accelfdUN)



# Using 'clustcurv' library


#regclustcurves(x = runtimes, y = handdat , z = feetdat, nboot = 500,
             #  algorithm = 'kmedians', cluster = TRUE, seed = 300716)
