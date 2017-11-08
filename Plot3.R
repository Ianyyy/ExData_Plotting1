data = read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?")

data$Date = as.Date(data$Date, "%d/%m/%Y")
head(data$Date)

data = subset(data, Date >= "2007-2-1" & Date <= "2007-2-2")
data = data[complete.cases(data),]
dateTime = paste(data$Date, data$Time)
dateTime = setNames(dateTime, "DateTime")
data = data[ ,!(names(data) %in% c("Date", "Time"))]
data = cbind(dateTime, data)

data$dateTime = as.POSIXct(dateTime)

with(data, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))