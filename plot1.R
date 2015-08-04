##Read and extract data for chosen dates in february
        file<-"household_power_consumption.txt"
        data<-read.table(file, header=TRUE, sep=";", skip = 65000, nrows=5000)
        labels<-read.table(file,nrows=1, sep=";", colClasses="character")
        colnames(data)<-labels
        data2<-data[grepl("1/2/2007",data$Date) | grepl("2/2/2007", data$Date),]


## create first chart
png("plot1.png")
hist(data2$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts")
dev.off()

