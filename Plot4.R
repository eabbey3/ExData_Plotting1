## Load power consunption data if it exist
if(file.exists("household_power_consumption.txt")){
   data <- read.table("household_power_consumption.txt", header=T, sep=";")
}else {
  stop("Power Consumption data file do not exist")
}

## add a field "DateTime" out of from "Date" and "Time" field
data$DateTime<-paste(data$Date, data$Time)


## Change DateTime format to yyyy-mm-dd hh:mm:ss 
data$DateTime<-strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")

## Filter data from the dates 2007-02-01 and 2007-02-02
dataFiltered<-data[which(data$DateTime==strptime("2007-02-01", "%Y-%m-%d")):which(data$DateTime==strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S")),]

## Open a PNG graphic device 
png(filename="plot4.png", width=480, height=480)

## Plot to png file
par(mfrow=c(2,2))

plot(dataFiltered$DateTime, 
     as.numeric(as.character(dataFiltered$Global_active_power)),
     type="l",
     xlab="",
     ylab="Global Active Power")

plot(dataFiltered$DateTime, 
     as.numeric(as.character(dataFiltered$Voltage)),
     type="l",
     xlab="datetime",
     ylab="Voltage")

plot(dataFiltered$DateTime,
     type="l",
     as.numeric(as.character(dataFiltered$Sub_metering_1)), 
     ylab="Energy sub metering", 
     xlab="")

lines(dataFiltered$DateTime, 
      as.numeric(as.character(dataFiltered$Sub_metering_2)),
      type="l", 
      col="red")

lines(dataFiltered$DateTime, 
      dataFiltered$Sub_metering_3,
      type="l", 
      col="blue")

## Add a legend
legend('topright', 
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),
       col=c("black","red","blue"))


plot(dataFiltered$DateTime,
     as.numeric(as.character(dataFiltered$Global_reactive_power)),
     type="l",
     xlab="datetime", 
     ylab="Global_reactive_power")

## close PNG graphic device 
dev.off()
