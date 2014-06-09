hpcData = read.table("household_power_consumption.txt",sep=";", col.names=c("Date","Time","GAp","GAr","V","Gi","SM1","SM2","SM3"),fill=FALSE,header=TRUE, na.strings="?")
##reading data from txt file and renaming columns
hpcData$Date<-strptime(as.character(hpcData$Date),"%d/%m/%Y")
hpcData$Date<-format(hpcData$Date,"%Y-%m-%d")
hpcData$Time<-strptime(as.character(hpcData$Time),format="%H:%M:%S")
hpcData$Time<-format(hpcData$Time,"%H:%M:%S")
hpcDataFeb<-subset(hpcData, Date =="2007-02-01" | Date == "2007-02-02")
##subsetting the data over 2-day period in February 2007 
hist(hpcDataFeb[,3],xlab="Global Active Power (kilowatts)",main="Global Active Power",col ="orangered")
##plotting histogram of Global Active Power on screen device
dev.copy(png,file="plot1.png",width=480,height=480,units="px")
##saving the plot to PNG file device
dev.off()
##closing the PNG file device
