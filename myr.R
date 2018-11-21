library(ggplot2)
library(readr)
library(RColorBrewer)
library(dplyr)
library(gridExtra)
library(corrplot)
library(caret)
library(ggmap)
library(tidyverse)
library(moderndive)
library(GGally)

housing <- read.csv(file.path("C:", "housing.csv"))#read data 
#housing
#str(housing)
summary(housing)#summary of each variable
g1<-ggplot(housing,aes(x=price))+geom_density(fill="purple")
g2<-ggplot(housing,aes(x=sqft_living))+geom_histogram(binwidth=1,fill="red")
grid.arrange(g1,g2,nrow=1,ncol=2)
# house price and Qft living are rightly skewed so we do log tranformation and 
#examine their distributions
housing<-housing %>% 
  mutate(log_price=log10(price))
ggplot(housing,aes(x=log_price))+geom_histogram(fill="yellow4",binwidth=0.10)

housing<-housing %>% 
  mutate(log_size=log10(sqft_living))
ggplot(housing,aes(x=log_size))+geom_histogram(fill="blue4")
#Most of house price lies between 5.4 to 6 million. 
# examining the variable BATHROOM and plotting a histogram
ggplot(housing,aes(x=bathrooms))+geom_histogram(fill="purple4",binwidth=0.5,size=0.1)+
  scale_x_continuous(limits=c(1,8))
#plot log price vs log_size

ggplot(housing, aes(x=log_size,y=log_price))+geom_point(shape=18, color="blue")+
  geom_smooth(method=lm, se= FALSE, linetype="dashed", color="darkred")
#bedrooms vs log_price
ggplot(housing, aes(x=bedrooms, y= log_price))+geom_point(alpha=0.5,size=2)+
  geom_smooth(method="lm",se=F)+
  labs("title=Sqft Living vs Price")+theme(legend.position="none")
# treating one outlier in bedroom variable and removing that row

housing %>% filter(bedrooms<30)%>%
  ggplot(aes(x=bedrooms,y=log_price,col=bedrooms))+
  geom_point(alpha=0.5,size=2)+
  geom_smooth(method="lm",se=F)+
  labs("title=Bedrooms vs Price")+theme(legend.position="none")
#House condition and prices
table(housing$condition)
# 1 being the worst and 5 being the best rated house

# creating a table of relative mean prices of house according to their conditions

housing %>%group_by(factor(condition))%>%summarise(mean_price=mean(log_price),sd=sd(log_price),count=n())
#Distribution of house prices according to condition

ggplot(housing,aes(factor(condition),log_price,fill=factor(condition)))+
  geom_boxplot(alpha=0.6)+scale_fill_manual(values=rainbow(6))+
  theme(legend.position="none")+
  labs(x="House Condition")
#From the above plot its very clear that house prices were high if the condition was good.
#plotting the relationship between log price and log size  accross factors of variable condition(1-5)

options(repr.plot.width=8, repr.plot.height=5)
ggplot(housing,aes(x=log_size,y=log_price,color=factor(condition)))+geom_point(size=0.5)+
  geom_smooth(method="lm",se=F,alpha=0.6,size=0.5,color="black")+ scale_color_manual(values =rainbow(n=6))+facet_wrap(~condition)
# plotting the distribution  of Yr_built

options(repr.plot.width=6, repr.plot.height=3)
housing %>% ggplot(aes(yr_built))+geom_histogram(binwidth=5,fill=rainbow(1),alpha=0.5)+
  scale_x_continuous(limits=c(1900,2016))
#Houseview variable creation 
housing$houseview<-ifelse(housing$waterfront==1,TRUE,FALSE)

housing%>%
  select(log_price, houseview) %>%
  glimpse()
ggplot(housing, aes(x = houseview, y = log_price,fill=houseview)) +
  geom_boxplot(alpha=0.5) +
  labs(x = "waterfront", y = "logprice")+
  scale_fill_manual(values=rainbow(n=12))
#Houses that have view of waterfront tend to be much expensive than house not having a view. Most of the houses doesn't have water front, see below the price difference between those. 
#count of number houses having waterfront view and their mean prices


housing %>%
  group_by(houseview) %>%
  summarize(mean_price = mean(log_price), house_count = n())
#Grade vs price

table(housing$grade)
#comparison of log price and log size accross the factors of variable Grade


ggplot(housing,aes(x=log_size,y=log_price,color=factor(grade)))+geom_point(size=0.3)+
  geom_smooth(method="lm",se=F,alpha=0.6,size=0.5,color="black")+ scale_color_manual(values =rainbow(n=12))+
  facet_wrap(~grade)+
  theme(legend.position="none") 
#table of house floors
table1<- table(housing$floors)
table1
# histogram of floors vs house count
housing %>% group_by(flr=factor(floors))%>%summarise(floor_cnt=n())%>%
  ggplot(aes(x=flr,floor_cnt,fill=flr))+
  geom_bar(stat="identity",alpha=0.5)+
  scale_fill_manual(values =rainbow(n=6))+
  theme(legend.position="none")+
  labs(x="floors",y="No of houses")
#distribution of house prices according to floors
ggplot(housing,aes(factor(floors),log_price,fill=factor(floors)))+geom_boxplot(alpha=0.5)+
  labs(x = "Floors", y = "logprice")+
  scale_fill_manual(values=rainbow(n=8))+
  theme(legend.position="none")
set.seed(1234)
id<-sample(2,nrow(housing),prob=c(0.70,0.30),replace=TRUE)
train<-housing[id==1,]
test<-housing[id==2,]
str(train)
#correlation plot between price and independent variables
plot1<-ggpairs(data=train, columns=3:7,
               mapping = aes(color = "dark green"),
               axisLabels="show")
plot1
## Checking Relationship between price, floors, waterfront, view, condition and grade
plot2<-ggpairs(data=train, columns=c(3,8:12),
               mapping = aes(color = "dark green"),
               axisLabels="show")
plot2
## Checking Relationship between price, yr built, lat and long
plot3=ggpairs(data=train, columns=c(3,15,18,19),
              mapping = aes(color = "dark green"),
              axisLabels="show")
plot3
## Price vs. Sqft_living ->> Nice correlation, as sqft increases, price increases as well.
boxplot1=boxplot(price~sqft_living, data=train, 
                 col=(c("gold","darkgreen")),
                 main="Price vs. Sqft_living", xlab="Sqft_living", ylab="Price")
## Price vs. Bathrooms ->> Nice correlation, as # of bathrooms increases [median of bar plot], price increases as well, with one expection in when bathroom=7
boxplot2=boxplot(price~bathrooms, data=train, 
                 col=(c("gold","darkgreen")),
                 main="Price vs. Bathrooms", xlab="Bathrooms", ylab="Price")
## Price vs. Grade ->> Nice correlation, grade increases [median of bar plot], price increases as well
boxplot3=boxplot(price~grade, data=train, 
                 col=(c("gold","purple")),
                 main="Price vs. Grade", xlab="Grade", ylab="Price")
## Price vs. View ->> Nice correlation, view increases [median of bar plot], price increases as well
boxplot4=boxplot(price~view, data=train, 
                 col=(c("gold","purple")),
                 main="Price vs. View", xlab="View", ylab="Price")
## Price vs. Lat ->> This is more like a normal dist relationship, price peaks around when lat= 47.64 and declines afterwards, but this can be modeled easily. I would say Lat explains the price as well.
boxplot5=boxplot(price~lat, data=train, 
                 col=(c("gold","purple")),
                 main="Price vs. Lat", xlab="Lat", ylab="Price")
#simple Regression model log price vs log sqft living
Model2 <- lm(data=train,log(price)~log(sqft_living))
summary(Model2)
#By looking at the regression output, we can see the values of Rsq and adjusted Rsq. The values indicate that the model is not a perfect fit which is normally not an easy task. 

#In the previous section I used a simple regression model and found a poor fit. In order to improve this model, I am planning to add more features, but we should be careful about the overfit which can be seen by the difference between the training and test evaluation metrics. When we have more than one feature in a linear regression, it is defined as multiple regression. 
#Another important thing is correlation, if there is very high correlation between two features, keeping both of them is not a good idea most of the time. For instance, sqt_above and sqt_living is highly correlated. This can be estimated when you look at the definitions at the dataset and check to be sure by looking at the correlation matrix.  
#Now, let's include few more variables that have significant association with the variable Price. This model includes Sqft_living, Bedrooms, Bathrooms, View and Grade.
Model3 <- lm(log(price)~log(sqft_living)+bedrooms+bathrooms+view+grade,data=train)
summary(Model3)
#The above regression output shows that the value of adjusted Rsq is slightly higher than the simple regression model but not significantly higher. The Estimate of Bedrooms -0.030 shows that for every unit increase in bedrooms the Price will decline by 0.030 units. 
#lets include the variables sqft living, sqft lot, bedrooms,bathrooms,floors,waterfront,view, grade, yr buit, zipcode. 
model_final<-lm(log(price)~log(sqft_living)+bedrooms+bathrooms+sqft_lot+floors+waterfront+view+grade+yr_built+zipcode,data=train)
summary(model_final)
#By looking at the output, It is clear that the adjusted R sq is the highest among all the models created. This model might be a  
#Better choice among all. 
#computing predicted prices on test data and outputting in csv file.
#notice that we took the exp of the predictions since we used log tranformations
pricehat_finalmodel <- round(exp(predict(model_final,newdata=test)),0)
output <- (cbind('id'=test$id, 'original price'= test$price, 'predicted price'=pricehat_finalmodel))
write.csv(output,file='test data originalpricevspredicted.csv', row.names=F)
#plotting predicted prices vs Actual prices using test data
ggplot(test,aes(x=price,y=pricehat_finalmodel))+geom_point()+geom_abline(color="blue")
