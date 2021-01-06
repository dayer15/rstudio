

#stats<-read.csv(file.choose(),stringsAsFactors = T)

#stats



#second method
#getwd()

stats<-read.csv("P2-Demographic-Data.csv", stringsAsFactors = T)


#filtering data frames

head(stats)

filter<-stats$Internet.users <2
stats[filter,]

stats[stats$Birth.rate>40,]
stats[stats$Birth.rate>40 & stats$Internet.users<2,]

stats[stats$Income.Group == "High income",]

levels(stats$Income.Group)

stats[stats$Country.Name == "Malta",]

filter<-NULL
rm(filter)


# ggplot2----------------------------------------
install.packages("ggplot2")
library(ggplot2)
?qplot

qplot(data=stats,x=Internet.users)
qplot(data=stats,x=Income.Group, y=Birth.rate, size=I(3), colour=I("blue"))

qplot(data=stats,x=Income.Group, y=Birth.rate, geom="boxplot")


# ggplot2---------------------------------------- visualisation

qplot(data=stats, x=Internet.users, y=Birth.rate)
qplot(data=stats, x=Internet.users, y=Birth.rate, size=I(1), colour=I("Red"))
qplot(data=stats, x=Internet.users, y=Birth.rate, size=I(1), colour=Income.Group)


#---------------creating dataframes
mydf <- data.frame(Countries_2012_Dataset,Codes_2012_Dataset,Regions_2012_Dataset)

head(mydf)
colnames(mydf)<- c("Country", "Code", "Region")
rm(mydf)

mydf <- data.frame(Country=Countries_2012_Dataset,Code=Codes_2012_Dataset,Region=Regions_2012_Dataset, stringsAsFactors = T)
head(mydf)

summary(mydf)


#merge

head(stats)
head(mydf)

merged <- merge(stats, mydf, by.x="Country.Code", by.y="Code")
head(merged)

merged$Country<-NULL
str(merged)
tail(merged)

#visualisation 2 - with new split

qplot(data=merged, x=Internet.users,y=Birth.rate, color=Region, size=I(5), shape=I(19))
#trancparancy
qplot(data=merged, x=Internet.users,y=Birth.rate, color=Region, size=I(5), shape=I(19), alpha=I(0.6))
#title
qplot(data=merged, x=Internet.users,y=Birth.rate, color=Region, size=I(5), shape=I(19), alpha=I(0.6), main="Birth Rate vs Internet users as per regions")

#homework section 5

hwDF<-read.csv(file.choose(),stringsAsFactors = T)

head(hwDF)

data1960<-hwDF[hwDF$Year=="1960",]
data2013<-hwDF[hwDF$Year=="2013",]

summary(data1960)
summary(data2013)

head(data1960)

add1960<-data.frame(Code=data1960$Country.Code, Life.Exp=Life_Expectancy_At_Birth_1960)
add2013<-data.frame(Code=data1960$Country.Code, Life.Exp=Life_Expectancy_At_Birth_2013)

head(data1960)
head(add1960)

merged1960<- merge(data1960, add1960, by.x = "Country.Code", by.y = "Code")
merged2013<- merge(data2013, add2013, by.x = "Country.Code", by.y = "Code")

str(merged1960)
summary(merged1960)

head(merged1960)

library(ggplot2)
qplot(data=merged1960, x=Fertility.Rate, y=Life.Exp, color=Region, size=I(5), alpha=I(0.4), main="Life Expectancy Vs Fertility (1960)")
qplot(data=merged2013, x=Fertility.Rate, y=Life.Exp, color=Region, size=I(5), alpha=I(0.4), main="Life Expectancy Vs Fertility (1960)")


#section6
movierating<-read.csv(file.choose(),stringsAsFactors = T)
head(movierating)
colnames(movierating)<-c("Film","Genre","CriticRating","AudienceRating","BudgetMillions","Year")
head(movierating)
movies<-movierating
str(movies)
summary(movies)
#convert column factor so it has levels it is easier to segregate if if you are not doing math operations with it.
factor(movies$Year)
movies$Year<-factor(movies$Year)

#aesthetics
library(ggplot2)
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))

#addgeom
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating)) + 
  geom_point()
#colour
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                        color=Genre)) + 
  geom_point()
#size
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                        color=Genre, size=Genre)) + 
  geom_point()

#size better way
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                        color=Genre, size=BudgetMillions)) + 
  geom_point()
?ggplot()

#plotting with layers

p<-ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, 
                           color=Genre, size=BudgetMillions)) 
p + geom_point()
p + geom_line()
p + geom_line() + geom_point()

# overriding aesthetics

q<- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,color=Genre, size=BudgetMillions)) 

q+geom_point()

#overriding aes
#ex1
q+geom_point(aes(size=CriticRating))
#ex2
q+geom_point(aes(colour=BudgetMillions))
#q remains same
q+geom_point()
#ex3
q+geom_point(aes(x=BudgetMillions)) + 
  xlab("Buget Millions")
#ex4 reduce line size
p + geom_line() + geom_point()
p + geom_line(size=1) + geom_point()

#mapping vs setting parametri idu u AES ako su varijable a mapiraju se za sve tocke
r<-ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))
r+geom_point()

#mapping
r+geom_point(aes(color=Genre))
#settings
r+geom_point(color="DarkGreen")
#error
#r+geom_point(aes(color="DarkGreen"))

### 1. mapping
r+geom_point(aes(size=BudgetMillions))
#seeting
r+geom_point(size=10)
#ERROR
#r+geom_point(aes(size=10))

#istograms and density charts
s<-ggplot(data=movies, aes(x=BudgetMillions))
s+geom_histogram(binwidth=10)

#add coulour
s+geom_histogram(binwidth=10,aes(fill=Genre), colour="Black")
#chart 3 (we will improve it)

#sometimes you might need density chart
s+geom_density(aes(fill=Genre), position="stack")

t<-ggplot(data=movies, aes(x=AudienceRating))
t+geom_histogram(binwidth = 5, fill="White", colour="Blue")

#another way
t<-ggplot(data=movies)

t + geom_histogram(binwidth = 5, aes(x=AudienceRating), fill="white",colour="Blue")

#>>>>>4
t + geom_histogram(binwidth = 5, aes(x=CriticRating), fill="white",colour="Blue")

?geom_smooth

#
u<-ggplot(data=movies, aes(x=CriticRating,y=AudienceRating, colour=Genre))
u+geom_point()+geom_smooth(fill=NA)

#boxplots
u<-ggplot(data=movies, aes(x=Genre, y=AudienceRating, colour=Genre))
u+geom_boxplot(size=1.2)
u+geom_boxplot(size=1.2)+geom_point()
#tip/hack
u+geom_boxplot(size=1.2)+geom_jitter()
#anotherway
u+geom_jitter()+geom_boxplot(size=0.8, alpha=0.5)

cr<-ggplot(data=movies,aes(x=Genre,y=AudienceRating, colour=Genre))
cr + geom_jitter() + geom_boxplot(size=0.7,alpha=0.6)

y<-ggplot(data=movies,aes(x=BudgetMillions))
y+geom_histogram(binwidth=5,aes(fill=Genre),color="Black")

#separate histograms=facets
y+geom_histogram(binwidth=5,aes(fill=Genre),color="Black")+facet_grid(Genre~., scales="free")

#scatterplots
w<-ggplot(data=movies,aes(x=CriticRating,y=AudienceRating,color=Genre))

w+geom_point(size=3) + facet_grid(Genre~.)
w+geom_point(size=3) + facet_grid(.~Year)

w+geom_point(size=3) + facet_grid(Genre~Year)

w+geom_point(size=3)+ geom_smooth() + facet_grid(Genre~Year)

w+geom_point(aes(size=BudgetMillions))+ geom_smooth() + facet_grid(Genre~Year)

#we will improve
m<-ggplot(data=movies, aes(x=CriticRating,y=AudienceRating,size=BudgetMillions,color=Genre))
m+geom_point()
m+geom_point()+xlim(50,100)+ylim(50,100)
#
n<-ggplot(data=movies,aes(x=BudgetMillions))
n+geom_histogram(binwidth = 10,aes(fill=Genre),color="Black")
#not working properly as it cuts of
n+geom_histogram(binwidth = 10,aes(fill=Genre),color="Black")+ylim(0,50)
#zoom to something
n+geom_histogram(binwidth = 10,aes(fill=Genre),color="Black")+coord_cartesian(ylim=c(0,50))

#improve no1
w+geom_point(aes(size=BudgetMillions))+ geom_smooth() + facet_grid(Genre~Year)+coord_cartesian(ylim=c(0,100))

#themes
o<-ggplot(data=movies, aes(x=BudgetMillions))
o+geom_histogram(binwidth=10,aes(fill=Genre), colour="Black")
h<-o+geom_histogram(binwidth=10,aes(fill=Genre), colour="Black")
h+xlab("Money Axis")+ylab("Number of Movies")

#label formating
h+xlab("Money Axis")+ylab("Number of Movies")+
  theme(axis.title.x=element_text(color="DarkGreen", size=30), 
        axis.title.y = element_text(color="Red",size=30))

#tick mark formating
h+xlab("Money Axis")+ylab("Number of Movies")+
  theme(axis.title.x=element_text(color="DarkGreen", size=30), 
        axis.title.y = element_text(color="Red",size=30),
        axis.text.x=element_text(size=20),
        axis.text.y=element_text(size=20))

?theme

#legend formating
h+
  xlab("Money Axis")+
  ylab("Number of Movies")+
  ggtitle("Movie Budget distribution")+
  theme(axis.title.x=element_text(color="DarkGreen", size=30), 
        axis.title.y = element_text(color="Red",size=30),
        axis.text.x=element_text(size=20),
        axis.text.y=element_text(size=20),
        legend.title = element_text(size=30),
        legend.text=element_text(size = 15),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        plot.title = element_text(color = "DarkBlue", size=10, family="Courier"))

#davor