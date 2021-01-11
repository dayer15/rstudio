#install.packages("ggplot2")
#library("ggplot2")

#DL location: https://www.superdatascience.com/pages/rcourse-advanced

#Load csv and preview data
#basic import: f500<-read.csv(file.choose(),stringsAsFactors = T)
#advanced na.strings are chaning blank to NA
f500<-read.csv(file.choose(),stringsAsFactors = T, na.strings = c(""))

head(f500,20)
tail(f500,10)
str(f500)
summary(f500)

#Change from non-factors to factor
f500$ID<-factor(f500$ID)
f500$Inception<-factor(f500$Inception)

#Factor Variable Trap (FVT)
#convering intor numberif for characters
a<-c("12","13","14","12","12")
a
typeof(a)
b<- as.numeric(a)
b
typeof(b)

#converting into numerics for factors
z<- factor(c("12","13","14","12","12"))
z
typeof(z)

y<- as.numeric(z)
y
typeof(y)
#-------------real conversion correct way: to character and then to numeric!!!!!!!!
x<-as.numeric(as.character(z))
typeof(x)

#FVT example
head(f500)
str(f500)
#producing artificially factor
#f500$Profit<-factor(f500$Profit) #dangerous
#conversion to ingr
summary(f500)
#f500$Profit<-as.numeric(f500$Profit) #dangerous
head(f500)

#GSUB() and SUB()
f500$Expenses<-gsub(" Dollars","",f500$Expenses)
f500$Expenses<-gsub(",","",f500$Expenses)
head(f500)
str(f500)
#dollar sign is special sign and needs escape sequence
f500$Revenue<-gsub("\\$","",f500$Revenue)
f500$Revenue<-gsub(",","",f500$Revenue)
head(f500)
str(f500)
#growth removing of %
f500$Growth<-gsub("%","",f500$Growth)
str(f500)
head(f500)

#converting to numeric
f500$Expenses<-as.numeric(f500$Expenses)
f500$Revenue<-as.numeric(f500$Revenue)
f500$Growth<-as.numeric(f500$Growth)
str(f500)
summary(f500)

#Deal with missing data
#1. predict with 100% accuracy 
#2. Leave record as is (if script knows how to deal with it) 
#3. Remove record 
#4. Replace with mean or median
#5. fill in by exploring correlations and mililarities
#6. introduce dummy variable for "missingness"

#What is an NA
?NA
TRUE #1 =logical true
FALSE #0
NA # we dont know
TRUE==FALSE
TRUE==5
TRUE==1
FALSE==FALSE
FALSE==1
NA==TRUE
NA==FALSE
NA==15
NA==NA #is still NA

#Locating missing data (elegant way)
head(f500,24)
f500[!complete.cases(f500),] #updated to import f500<-read.csv(file.choose(),stringsAsFactors = T, na.strings = c("")) so blank space is swapped with NA
str(f500)

#Filtering using which() for non-missing data
head(f500)
which(f500$Revenue == 9746272) #this is giving row number and then i filter and show just those rows
f500[which(f500$Revenue == 9746272),]
head(f500)
f500[which(f500$Employees==45),]

#filtering: using is.na() for missing data
head(f500,24)
f500$Expenses==NA
f500[f500$Expenses==NA,]
a1<-c(1,24,536,NA, 76,NA)
is.na(a1)
f500[is.na(f500$Expenses),]

#removing records with missing data
f500_backup<-f500
f500[!complete.cases(f500),]
f500[is.na(f500$Industry),]
f500[!is.na(f500$Industry),] #opposite
f500<-f500[!is.na(f500$Industry),] #opposite
options(max.print=25000)
f500

#reseting dataframe index
rownames(f500)<-1:nrow(f500)
f500
#or
rownames(f500)<-NULL #if you NULL it will automatically assign numeration.
f500

#replacing missing data: Factual analysis
f500[!complete.cases(f500),]
f500[is.na(f500$State),]
f500[is.na(f500$State)&f500$City=="New York","State"]<-"NY"
f500[is.na(f500$State)&f500$City=="New York","State"]
#check:
f500[c(11,377),]

f500[is.na(f500$State)&f500$City=="San Francisco","State"]<-"CA"
f500[c(82,265),]

#Replacing data median imputation method part 1
f500[!complete.cases(f500),]
summary(f500)
med_empl_retail<-median(f500[f500$Industry=="Retail","Employees"],na.rm=TRUE)
  #mean(f500[f500$Industry=="Retail","Employees"],na.rm=TRUE)
f500[is.na(f500$Employees & f500$Industry=="Retail"),]
f500[is.na(f500$Employees & f500$Industry=="Retail"),"Employees"]<-med_empl_retail
f500[3,]
  #other one
med_empl_finserv<-median(f500[f500$Industry=="Financial Services","Employees"],na.rm=TRUE)
f500[is.na(f500$Employees & f500$Industry=="Financial Services"),"Employees"]<-med_empl_finserv
f500[330,]

#Replacing data median imputation method part 2
f500[!complete.cases(f500),]

med_growth_constr <- median(f500[f500$Industry=="Construction","Growth"],na.rm=TRUE)
med_growth_constr
f500[is.na(f500$Growth) & f500$Industry=="Construction","Growth"]<-med_growth_constr
f500[8,]

f500[!complete.cases(f500),]

#Replacing data median imputation method part 2
med_rev_constr <- median(f500[f500$Industry=="Construction","Revenue"],na.rm=TRUE)
med_rev_constr
f500[is.na(f500$Revenue) & f500$Industry=="Construction","Revenue"]<-med_rev_constr
f500[c(8,42),]
f500[!complete.cases(f500),]

#Revenue exercise
med_exp_constr<-median(f500[f500$Industry=="Construction","Expenses"],na.rm = T)
med_exp_constr
f500[f500$Industry=="Construction" & is.na(f500$Expenses)& is.na(f500$Profit),]
f500[f500$Industry=="Construction" & is.na(f500$Expenses),"Expenses"]<-med_exp_constr
f500[!complete.cases(f500),]

