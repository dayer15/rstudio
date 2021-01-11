#lists

#Character: Machine name
#Vector: (min, mean, max) utilisation for the month (excluding unknown hours)
#Logical: Has utilisation ever fallen below 90%? TRUE / FALSE
#Vector: All hours where utilisation is unknown (NA’s)
#Dataframe: For this machine
#Plot: For all machines

getwd()

#start
util<-read.csv("P3-Machine-Utilization.csv", stringsAsFactors = T)
head(util,12)
str(util)
summary(util)
#drive utilization column

util$Utilization=1-util$Percent.Idle
head(util,12)
