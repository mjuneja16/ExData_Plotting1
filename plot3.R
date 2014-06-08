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
##Using chron to make Date and Time assemble together under a new column named as "DateTime"
hpcDataFeb$DateTime<-as.POSIXlt(hpcDataFeb$DateTime,tz="GMT")
png(filename="plot3.png",width=480,height=480,units="px")
##creating PNG file device in the working directory
par(mar=c(4,5,2,2))
with(hpcDataFeb,plot(hpcDataFeb$DateTime,hpcDataFeb$SM1,type="n",xlab="",ylab="Energy sub metering"))
##empty plot is created. No points are marked.
with(hpcDataFeb,{
     points(hpcDataFeb$DateTime,hpcDataFeb$SM1, type = "s")
     points(hpcDataFeb$DateTime,hpcDataFeb$SM2, type = "s",col="orangered")
     points(hpcDataFeb$DateTime,hpcDataFeb$SM3, type = "s",col="blue")})
##points are plotted and the resulting plot is sent to the PNG device (no plot appears on the screen)
legend("topright", lty=1, col = c("black","orangered","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
##annotating the plot (still nothing appears on the screen)
dev.off()
##closing the PNG file device
