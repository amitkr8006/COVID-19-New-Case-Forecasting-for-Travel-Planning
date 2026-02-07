install.packages("xts")
install.packages("forecast")
library(xts)
library(forecast)

#taking the input
cat("1. India \n2. Nepal \n3. Pakistan \n4. Bangladesh \n5. Bhutan \n6. Maldives \n7. Sri Lanka \n")
country<-as.integer(readline("Enter the country you want to visit : "))

#reading the data
who_data<-read.csv("who_data.csv")



#1
#Indian data
India<-who_data[who_data$Country=="India",c(1,5)]
dates<-as.Date(India$Date_reported)
ind<-xts(India$New_cases,order.by = dates)

#other countries
#2
nepal<-who_data[who_data$Country=="Nepal",c(1,5)]
nep<-xts(nepal$New_cases,order.by = dates)

#3
pakistan<-who_data[who_data$Country=="Pakistan",c(1,5)]
pak<-xts(pakistan$New_cases,order.by = dates)

#4
Bangladesh<-who_data[who_data$Country=="Bangladesh",c(1,5)]
bang<-xts(Bangladesh$New_cases,order.by = dates)

#5
bhutan<-who_data[who_data$Country=="Bhutan",c(1,5)]
bhu<-xts(bhutan$New_cases,order.by = dates)

#6
Maldives<-who_data[who_data$Country=="Maldives",c(1,5)]
mald<-xts(Maldives$New_cases,order.by = dates)

#7
Sri_Lanka<-who_data[who_data$Country=="Sri Lanka",c(1,5)]
srl<-xts(Sri_Lanka$New_cases,order.by = dates)


covid_forecst<-function(data)
{
  
  #ets model
  model<-ets(data)
  f<-forecast(model,14)
  
  plot(f)
  #print(summary(f))
  #checkresiduals(model)
  return(f$mean)
  
}

if(country==1)
{
  p<-covid_forecst(ind)
}else if(country==2)
{
  p<-covid_forecst(nep)
}else if(country==3)
{
  p<-covid_forecst(pak)
}else if(country==4)
{
  p<-covid_forecst(bang)
}else if(country==5)
{
  p<-covid_forecst(bhu)
}else if(country==6)
{
  p<-covid_forecst(mald)
}else if(country==7)
{
  p<-covid_forecst(srl)
}else
{
  cat("\nEnter the valid country ")
}

#preventing the cases from being negative
min<-ceiling(min(p))
if(min<0) min<-0
max<-ceiling(max(p))
if(max<0) max<-0

#printing the expected cases
cat("\nExpected covid-19 daily cases for next two weeks would be between: ",min," - ",max)

