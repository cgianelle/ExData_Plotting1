#Plot 4
#Read in the "Individual household electric power consumption" Data Set for dates
#2007-02-01 and 2007-02-02.
#
#Create a series of plots in a 2x2 fashion, where the plots are in the following 
#order:
#
# [Global Active Power] [Voltage]
# [Energy Sub Metering] [Global Reactive Power]
#
#Save plot into file plot4.png

OUTPUT_FILE <- "plot4.png"

#use fread from data.table due to its speed
library(data.table)

#Source the fetcher code to check to see if we need to fetch the Data Set
source("ds_fetcher.R")

#Read in the data and subset it based on the required dates
#NOTE: Dates in the DS are in dd/mm/yyyy format
power <- fread("household_power_consumption.txt", na.strings = "?")
days <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")
gap <- days$Global_active_power
gra = days$Global_reactive_power

#Get submetering data
sm1 <- days$Sub_metering_1
sm2 <- days$Sub_metering_2
sm3 <- days$Sub_metering_3

#Get Voltage data
voltage <- days$Voltage

#Create the date/time X axis 
dates <- days$Date
times <- days$Time
dt <- paste(dates,times)
x <- strptime(dt, "%d/%m/%Y %H:%M:%S")

#delete old plot file if present
if (file.exists(OUTPUT_FILE)) file.remove(OUTPUT_FILE)

#Create Plot - using a background color of gray87 to attempt to match figure/unnamed-chunk-5.png
png(file=OUTPUT_FILE, width = 480, height = 480, bg="gray87")
par(mfrow = c(2, 2))
# Plot 1 Top Left -- Global Active Power
plot(x, gap, type = "l", xlab="", ylab = "Global Active Power")

# Plot 2 Top Right -- Voltage
plot(x, voltage, type = "l", xlab="datetime", ylab = "Voltage")

# Plot 3 Bottom Left -- Submetering Data 1,2,3
plot(x, sm1, type="l", ylab = "Energy sub metering", xlab = "")
points(x, sm2, type = "l", col="red")
points(x, sm3, type = "l", col="blue")
legend("topright", 
    lty=c(1,1), 
    col=c("black","red", "blue"), 
    legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Plot 4 Bottom Right -- Global Reactive Power
plot(x,gra, type="l", xlab="datetime", ylab = "Global_reactive_power")

dev.off()
