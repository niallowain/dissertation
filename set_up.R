# Load in Libraries

library(tidyr)
library(fda)
library(ggplot2)
library(clustcurv)

#Load the files required

# Laptop
load( "/home/sparklemotion/Downloads/dissing around/AthloneSprintStarts.RData")
RTs = read.csv("/home/sparklemotion/Downloads/AthloneData.csv",header= TRUE, row.names= 1)

#Lab PC

#load("C:\\Users\\116347261\\Downloads\\AthloneSprintStarts.RData")
#RTs = read.csv("C:\\Users\\116347261\\Downloads\\AthloneData.csv",header= TRUE, row.names= 1)



#From given workings 

RTs$Gun = RTs$IAAF.Start - RTs$IAAF.RT
RTs$Gun = signif(RTs$Gun, 5)

file.names[ RTs$IAAF.RT <= 0.1 ]

##################################
####   Four subjects (12,13,14,17) yielded an extra (4th) trial, botched starts et cetera...  

FourTrials = numeric()

for(f in file.names) {
  
  ss = strsplit(f, "")[[1]]
  
  if(any(ss == "D")) {
    ss = rev(ss)[-1]
    ss = rev(ss)[-1]		
    FourTrials = c(FourTrials, as.numeric(paste(ss, collapse = "")))
  }
}

n.trials = rep(3, 20)
n.trials[FourTrials] = 4


##################################
####   Manufacture extra columns in the data frame RTs to distinguish Subject & Trial 

RTs$Subject = rep(seq(20), n.trials)

l = LETTERS[seq(from= 1, to = n.trials[1])]
for(i in 2:20) l = c(l, LETTERS[seq(from= 1, to = n.trials[i])])
RTs$Trial = l 

# A list of sprints is created here 

sprints =  list( S10A, S10B, S10C, S11A ,S11B, S11C, S12A, S12B ,S12C ,S12D, S13A ,S13B, S13C, S13D, S14A, S14B, S14C,
                 S14D ,S15A ,S15B ,S15C ,S16A ,S16B ,S16C ,S17A ,S17B ,S17C ,S17D ,S18A ,S18B ,S18C ,S19A ,S19B ,S19C,
                 S1A  ,S1B  ,S1C  ,S20A ,S20B ,S20C ,S2A  ,S2B  ,S2C  ,S3A  ,S3B  ,S3C  ,S4A  ,S4B , S4C  ,S5A  ,S5B ,
                 S5C , S6A  ,S6B  ,S6C  ,S7A  ,S7B  ,S7C  ,S8A  ,S8B  ,S8C  ,S9A  ,S9B  ,S9C)



#Reordering here for ease 

ath10 = sprints[1:3]
ath11 = sprints[4:6]
ath12 = sprints[7:10]
ath13 = sprints[11:14]
ath14 = sprints[15:18]
ath15 = sprints[19:21]
ath16 = sprints[22:24]
ath17 = sprints[25:28]
ath18 = sprints[29:31]
ath19 = sprints[32:34]
ath1 = sprints[35:37]
ath20  = sprints[38:40]
ath2 = sprints[41:43]
ath3 = sprints[44:46]
ath4 = sprints[47:49]
ath5 = sprints[50:52]
ath6 = sprints[53:55]
ath7 = sprints[56:58]
ath8 = sprints[59:61]
ath9 = sprints[62:64]


#Athletes arranged in order 
athletes = list(ath1,ath2,ath3,ath4,ath5,ath6,ath7,ath8,ath9,ath10,ath11,ath12,ath13,ath14,ath15,ath16,ath17,ath18,ath19,ath20)

