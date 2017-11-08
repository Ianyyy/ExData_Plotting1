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

plot(data$Global_active_power ~ data$dateTime, type = "l", ylab = "Global Active Power(killowatts)", xlab = "")
