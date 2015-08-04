##Read and extract data for chosen dates in february
file<-"household_power_consumption.txt"
data<-read.table(file, header=TRUE, sep=";", skip = 65000, nrows=5000)
labels<-read.table(file,nrows=1, sep=";", colClasses="character")
colnames(data)<-labels
data2<-data[grepl("1/2/2007",data$Date) | grepl("2/2/2007", data$Date),]

## create second chart
data2$Date<-as.Date(data2$Date, "%d/%m/%Y")
data2$Time<-strptime(data2$Time, "%H:%M:%S")

library(lubridate)
m<-month(data2$Date)
d<-day(data2$Date)
y<-year(data2$Date)
h<-hour(data2$Time)
min<-minute(data2$Time)
s<-second(data2$Time)

data2<-mutate(data2, datetime=ISOdatetime(y,m,d,h,min,s))

png("plot2.png")
plot(data2$datetime, data2$Global_active_power, ylab="Global Active Power (kilowatts)", type="l", xlab="")
dev.off()
