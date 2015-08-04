##Read and extract data for chosen dates in february
        file<-"household_power_consumption.txt"
        data<-read.table(file, header=TRUE, sep=";", skip = 65000, nrows=5000)
        labels<-read.table(file,nrows=1, sep=";", colClasses="character")
        colnames(data)<-labels
        data2<-data[grepl("1/2/2007",data$Date) | grepl("2/2/2007", data$Date),]

#combine date and time to datetime
        library(lubridate)
        data2$Date<-as.Date(data2$Date, "%d/%m/%Y")
        data2$Time<-strptime(data2$Time, "%H:%M:%S")
        
        m<-month(data2$Date)
        d<-day(data2$Date)
        y<-year(data2$Date)
        h<-hour(data2$Time)
        min<-minute(data2$Time)
        s<-second(data2$Time)
        
        data2<-mutate(data2, datetime=ISOdatetime(y,m,d,h,min,s))

## create third chart
        png("plot3.png")
        plot(data2$datetime, data2$Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
        points(data2$datetime, data2$Sub_metering_1, col="black", type="l")
        points(data2$datetime, data2$Sub_metering_2, col="red", type="l")
        points(data2$datetime, data2$Sub_metering_3, col="blue", type="l")
        legend("topright", lwd=2, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        dev.off()

