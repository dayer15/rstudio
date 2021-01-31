x<-100
x
y<-200

z<- x+y
z
print(z)

davor_mass<-92
davor_height<-189
BMI<-davor_height/davor_mass^2
BMI


x<-10
x
typeof(x)

x<-c("R")
x
typeof(x)
?c

#hide
.age<-21
.age
ls(all.names = T)
ls.str()


t<-c("a","b","c","d","e")
t[c(-2,-3)]

a1<- c(1,2,3)
a2<-c(1,2)
b1<- a1-a2

asia<-1:10
asia

davor1<-seq(from=10, to=100, by=15)
davor1

?seq



davor_mass<-as.integer(readline(prompt="Enter mass in kg: "))
davor_height<-as.double(readline(prompt="Enter height in m: "))
BMI<-davor_mass/davor_height^2
cat("The bmi value is", BMI)

kidsage<-c(13,15,18,21,24,27,29)
sum(kidsage)
mean(kidsage)
sd(kidsage)
kidsage[4]
diff1and5<-abs(kidsage[5]-kidsage[1])
diff1and5
diff2and5<-abs(kidsage[7]-kidsage[2])
diff2and5

luas<-read.csv(choose.files())

luas<-read.csv(choose.files(),stringsAsFactors = T)
str(luas)
summary(luas)

luas[,"RedLine"]
luas$RedLine

luas[,"GreenLine"]
luas$GreenLine

luas[6,"RedLine"]
luas$RedLine[luas$Month == "June"]
luas[luas$Month == "June","RedLine"]

luas[Month="June",]

luas[10,"GreenLine"]
mean(luas[,"RedLine"])

diff4eachMonth<- luas$RedLine - luas$GreenLine
diff4eachMonth
names(diff4eachMonth)<-luas$Month

print(z)

#import google stock data
#googlestock <- read.csv(choose.files())
googlestock <- read.csv("GOOG_May18.csv")

#overview of data
head(googlestock,10)
tail(googlestock,10)
summary(googlestock)
str(googlestock)

#show close
googlestock$Close

#show volume
googlestock$Volume

#three ways to show data
googlestock[10,"Close"]
googlestock$Close[10]
googlestock[googlestock$Date=="14/05/2018","Close"]

#volume on 10th date
googlestock[10, "Volume"]

#calculating value
googlestock$Value <- googlestock$Close * googlestock$Volume
googlestock$Value[10]

#sum of all values
sum(googlestock$Value)

