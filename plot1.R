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
# Create a device and plot
png(file="plot1.png", width = 480, height = 480)
with(data, hist(Global_active_power, col="Red", breaks=11, xlab="Global Active Power(kilowatts)", main="Global Active Power"))
dev.off()