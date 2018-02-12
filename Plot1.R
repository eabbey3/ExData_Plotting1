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
png(filename="plot1.png", width=480, height=480)

## Plot histogram to png file
hist(as.numeric(as.character(dataFiltered$Global_active_power)), main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

## close PNG graphic device 
dev.off()
