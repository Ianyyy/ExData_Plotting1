data = read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?")

data$Date = as.Date(data$Date, "%d/%m/%Y")
head(data$Date)

data = subset(data, Date >= "2007-2-1" & Date <= "2007-2-2")
data = data[complete.cases(data),]
dateTime = paste(data$Date, data$Time)
dateTime = setNames(dateTime, "DateTime")
data = data[ ,!(names(data) %in% c("Date", "Time"))]
data = cbind(dateTime, data)
head(data)

data$dateTime = as.POSIXct(dateTime)


hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power(killowatts)", ylab = "Frequency", col = "red")

plot(data$Global_active_power ~ data$dateTime, type = "l", ylab = "Global Active Power(killowatts)", xlab = "")

with(data, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
