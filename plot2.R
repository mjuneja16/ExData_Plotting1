hpcData = read.table("household_power_consumption.txt",sep=";", col.names=c("Date","Time","GAp","GAr","V","Gi","SM1","SM2","SM3"),fill=FALSE,header=TRUE, na.strings="?")
##reading data from txt file and renaming columns
hpcData$Date<-strptime(as.character(hpcData$Date),"%d/%m/%Y")
hpcData$Date<-format(hpcData$Date,"%Y-%m-%d")
hpcData$Time<-strptime(as.character(hpcData$Time),format="%H:%M:%S")
hpcData$Time<-format(hpcData$Time,"%H:%M:%S")
hpcDataFeb<-subset(hpcData, Date =="2007-02-01" | Date == "2007-02-02" | (Date == "2007-02-03" & Time == "00:00:00"))
##subsetting the data over 2-day period in February 2007
library(chron)
hpcDataFeb$DateTime=chron(dates=hpcDataFeb[,1],times=hpcDataFeb[,2],format=c('y-m-d','h:m:s'))
hpcDataFeb$DateTime<-as.POSIXlt(hpcDataFeb$DateTime,tz="GMT")
png(filename="plot2.png",width=480,height=480,units="px")
##Opening PNG device in the working directory
plot(hpcDataFeb$DateTime,hpcDataFeb$GAp, type = "s", xlab="", ylab="Global Active Power (kilowatts)")
##Creating plot and sending it to the PNG device (no plot appears on the screen)
dev.off()
##closing the PNG file device
