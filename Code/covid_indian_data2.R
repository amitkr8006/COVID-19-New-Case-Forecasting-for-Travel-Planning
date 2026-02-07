#reading the indian data
data<-read.csv("dataset1.csv")

dates <- as.Date(data[data$State=="Total",1])
xts2 <- xts(x=data[data$State=="Total",4], order.by=dates)
plot(xts2)


#reading the data
data1<-read.csv("who_data.csv")
plot(data1)
India_cum<-data1[data1$Country=="India",c(1,6)]
India_cumulative<-xts(India_cum$Cumulative_cases,order.by = dates)
India_cumulative<-ts(India_cumulative,frequency = 7)
India_cumulative<-decompose(India_cumulative)
#Indian data
dates1<-as.Date(India$Date_reported)
xts1<-xts(India$New_cases,order.by = dates1)
r<-xts1[1121:1134]
dates2<-as.Date(India$Date_reported[1121:1134])

India<-data1[data1$Country=="India",c(1,5)]
dates<-as.Date(India$Date_reported[1:1120])
xts2<-xts(India$New_cases[1:1120],order.by = dates)

#other countries
Bangladesh<-data1[data1$Country=="Bangladesh",c(1,5)]
Bangladesh
bang<-xts(Bangladesh$New_cases,order.by = dates)

nepal<-data1[data1$Country=="Nepal",c(1,5)]
nepal
nep<-xts(nepal$New_cases,order.by = dates)

pakistan<-data1[data1$Country=="Pakistan",c(1,5)]
pak<-xts(pakistan$New_cases,order.by = dates)

bhutan<-data1[data1$Country=="Bhutan",c(1,5)]
bhu<-xts(bhutan$New_cases,order.by = dates)

Maldives<-data1[data1$Country=="Maldives",c(1,5)]
mald<-xts(Maldives$New_cases,order.by = dates)

Sri_Lanka<-data1[data1$Country=="Sri Lanka",c(1,5)]
srl<-xts(Sri_Lanka$New_cases,order.by = dates)

#converting into time series data
xts2<-ts(xts2, frequency=7)
d<-decompose(xts2)
plot(d)


#arima model
model<-arima(xts2,order = c(1,0,3))
f<-forecast(model)
plot(f)

#ets model
model<-ets(xts2)
f<-forecast(model,14)
plot(f)
accuracy(f)

#holt winter model
model <- HoltWinters(xts2, alpha=0.2, beta=0.1, gamma=0.1)
f<-forecast(model,14)
plot(f)
accuracy(f)

#plotting 
forc<-xts(f$mean,order.by = dates2)
plot(forc,main = "forecast",col = "red")
lines(r,col = "blue")
legend("topright", legend=c("Forecasted cases", "actual cases"),col=c("red", "blue"), lty=1:2)


#getting the mean absolute percentage error
predicted<-as.numeric(f$mean)
real<-as.numeric(r)
mape<-100*mean(abs((predicted-real)/real))
mape

