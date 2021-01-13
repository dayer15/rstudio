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
tail(util,12)
#handling data-times in R
?POSIXct
util$PosixTime<-as.POSIXct(util$Timestamp,format="%d/%m/%Y %H:%M")
head(util,12)
summary(util)
#TIP: how to rearange columns in a dataframe
util$Timestamp<-NULL
head(util,12)
util<-util[,c(4,1,2,3)] #rearange
head(util,12)


#what is a list?
#data object which can contain mix of data
summary(util)
RL1<-util[util$Machine=="RL1",]
summary(RL1)
#remove legacy memory
RL1$Machine <- factor(RL1$Machine)
summary(RL1)

#construct list
#Character: Machine name
#Vector: (min, mean, max) utilisation for the month (excluding unknown hours)
#Logical: Has utilisation ever fallen below 90%? TRUE / FALSE
util_stats_rl1<-c(min(RL1$Utilization,na.rm=T), mean(RL1$Utilization,na.rm=T), max(RL1$Utilization,na.rm=T))
util_stats_rl1
util_under_90_flag<- length(which(RL1$Utilization <0.9)) > 0
util_under_90_flag
list_rl1 <- list("RL1", util_stats_rl1, util_under_90_flag)
list_rl1
#naming components
list_rl1
names(list_rl1) <- c("Machine","Stats","LowTreshhold")
list_rl1
#another way, like with dataframes:
rm(list_rl1)
list_rl1 <- list(Machine="RL1", Stats=util_stats_rl1, LowTreshold=util_under_90_flag)
list_rl1

#extracting components of a list
#three ways
#[] will always return a list
#[[]] will always return the actual object
#$ same as [[] but prettier]

list_rl1
list_rl1[1]
list_rl1[[1]]
list_rl1$Machine

typeof(list_rl1[2])
typeof(list_rl1[[2]])
typeof(list_rl1$Stats)

#how would you access the 3rd element of the vector max utilization
list_rl1$Stats[3]

2