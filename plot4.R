# Reading file
#setwd(file.path(getwd(),"Exp_Data_Analisys"))
op <- par(mfrow = c(2, 2), pty = "s")
#dev.new(width = 480, height = 480)
#source('~/R/Exp_Data_Analisys/plot2.R')
#setwd(file.path(getwd(),"Exp_Data_Analisys"))
campos <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
file <- "./data/household_power_consumption.txt"
nasstr <- c("?")
data <- read.table(file, header = FALSE, sep = ";", dec = ".", skip = 1, col.names =campos, na.strings = nasstr)
# Adjusting date and converting Date and time fields to Datetime
data$DateC <- as.Date(data$Date, format = "%d/%m/%Y")
data$Datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
#Subset data to dates between 2007-02-01 and 2007-02-02
subdata <- data[(data$DateC >= as.Date("2007-02-01") & data$DateC <= as.Date("2007-02-02") ),]
# remove data from the enviroment
rm(data)
# Load library
library(datasets)
# Set options to avoid the warning message "Warning message: In (function ()  : Only one RStudio graphics device is permitted"
options(device = "windows")
# initialize the device, begin plotting
plot(subdata$Datetime, subdata$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l", cex.lab = 0.75)

#source('~/R/Exp_Data_Analisys/plot5.R')
plot(subdata$Datetime, subdata$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")

#source('~/R/Exp_Data_Analisys/plot3.R')
plot(subdata$Datetime, subdata$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l", ylim = c(0,40))
par(new = T)
#Add the second series
plot(subdata$Datetime, subdata$Sub_metering_2, xlab = "", ylab = "", type = "l", col = "red", axes = F, ylim = c(0,40))
par(new = T)
#Add the third series
plot(subdata$Datetime, subdata$Sub_metering_3, xlab = "", ylab = "", type = "l", col = "blue", axes = F, ylim = c(0,40))
par(new = F)
#Add the legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c(1,2,4), cex = 0.9)

#source('~/R/Exp_Data_Analisys/plot6.R')
plot(subdata$Datetime, subdata$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")

dev.copy(png, file = "plot4.png")
#Close de device
dev.off()
#Reset default parameters
par(op)