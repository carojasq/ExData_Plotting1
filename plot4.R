library(data.table)
setwd("/tmp")
# Download, unzip and load the file with the data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "/tmp/EPC_file.zip", method="curl")
unzip("EPC_file.zip")
data <- fread("household_power_consumption.txt")
# Select the date interval to get more efficiency on the next operations
data <- subset(data, Date %in% c('1/2/2007', '2/2/2007'))
# Convert classes and adds a new column
data <- data[, DateTime:=as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S") ]
data <- data[, Date:=as.Date(Date, format="%d/%m/%Y") ]
data <- data[, Global_active_power:=as.numeric(Global_active_power)]
data <- data[, Sub_metering_1:=as.numeric(Sub_metering_1)]
data <- data[, Sub_metering_2:=as.numeric(Sub_metering_2)]
data <- data[, Sub_metering_3:=as.numeric(Sub_metering_3)]
data <- data[, Voltage:=as.numeric(Voltage)]
data <- data[, Global_reactive_power:=as.numeric(Global_reactive_power)]

# Create a device and plot
png(file="plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
# First plot
with(data, plot(DateTime, Global_active_power, type="n", xlab="", ylab="Global Active Power(kilowatts)" ))
with(data, lines(DateTime, Global_active_power))
# Second plot
with(data, plot(DateTime, Voltage, type="n", xlab="datetime", ylab="Voltage" ))
with(data, lines(DateTime, Voltage))
# Third plot
with(data, plot(DateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering" ))
with(data, lines(DateTime, Sub_metering_1))
with(data, lines(DateTime, Sub_metering_2, col="Red"))
with(data, lines(DateTime, Sub_metering_3, col="Blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1), lwd=c(2.5,2.5,2.5))
#Last plot
with(data, plot(DateTime, Global_reactive_power, type="n", xlab="datetime" ))
with(data, lines(DateTime, Global_reactive_power))
dev.off()