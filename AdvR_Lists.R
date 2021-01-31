#Lists
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


#adding and deleting list components
list_rl1
list_rl1[4]<-"New Information"
list_rl1
#anotherway to add a componentn via the $
#we will add:
#Vector: All hours where utilisation is unknown (NA’s)
RL1
RL1[is.na(RL1$Utilization),]
RL1[is.na(RL1$Utilization),"PosixTime"]
list_rl1$UnknownHours <- RL1[is.na(RL1$Utilization),"PosixTime"]
list_rl1

#remove component, use of NULL
list_rl1[4]<-NULL
list_rl1
#notice: Numeration has shifted and no need to renumerate
list_rl1[4]

#add another component
#Dataframe: For this machine
list_rl1$Data <- RL1
list_rl1
summary(list_rl1)
str(list_rl1)

#subsetting a list
#challange
list_rl1[[4]][1]
list_rl1$UnknownHours[1]
#subsetting a list
list_rl1[1:3]
list_rl1[c(1,4)]
sublist_rl1 <- list_rl1[c("Machine","Stats")]
sublist_rl1
sublist_rl1[[2]][2]
sublist_rl1$Stats[2]
#double square brackets are not for subsetting
#list_rl1[[1:3]] #error
library(ggplot2)
p<-ggplot(data=util)
p+geom_line(aes(x=PosixTime, y=Utilization))
p+geom_line(aes(x=PosixTime, y=Utilization,colour=Machine), size=0.2) + 
  facet_grid(Machine~.) + 
  geom_hline(yintercept = 0.90, color="Gray", size=1.3, linetype=3)
#adding plot
myplot<-p+geom_line(aes(x=PosixTime, y=Utilization,colour=Machine), size=0.2) + 
  facet_grid(Machine~.) + 
  geom_hline(yintercept = 0.90, color="Gray", size=1.3, linetype=3)

list_rl1$Plot<-myplot
list_rl1

summary(list_rl1)
str(list_rl1)



