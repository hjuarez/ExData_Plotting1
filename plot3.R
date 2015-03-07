# Reading file
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
# initialize the device, begin the plotting work setting it's size
dev.new(width = 480, height = 480)
#, cex.main = 0.9, cex.lab = 0.65, cex.axis = 0.65
# Make the plot
plot(subdata$Datetime, subdata$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l", ylim = c(0,40))
par(new = T)
#Add the second series
plot(subdata$Datetime, subdata$Sub_metering_2, xlab = "", ylab = "", type = "l", col = "red", axes = F, ylim = c(0,40))
par(new = T)
#Add the third series
plot(subdata$Datetime, subdata$Sub_metering_3, xlab = "", ylab = "", type = "l", col = "blue", axes = F, ylim = c(0,40))
par(new = F)
#Add the legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c(1,2,4), cex = 1.15)
# Export to a png file at the working dir
dev.copy(png, file = "plot3.png")
#Close de device
dev.off()