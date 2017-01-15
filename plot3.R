#Plot 3
#Read in the "Individual household electric power consumption" Data Set for dates
#2007-02-01 and 2007-02-02.
#
#Create a plot of the Sub Metering (1-3) over the dates
#Save plot into file plot3.png

OUTPUT_FILE <- "plot3.png"

#use fread from data.table due to its speed
library(data.table)

#Source the fetcher code to check to see if we need to fetch the Data Set
source("ds_fetcher.R")

#Read in the data and subset it based on the required dates
#NOTE: Dates in the DS are in dd/mm/yyyy format
power <- fread("household_power_consumption.txt", na.strings = "?")
days <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")
gap <- days$Global_active_power

#Get submetering data
sm1 <- days$Sub_metering_1
sm2 <- days$Sub_metering_2
sm3 <- days$Sub_metering_3

#Create the date/time X axis 
dates <- days$Date
times <- days$Time
dt <- paste(dates,times)
x <- strptime(dt, "%d/%m/%Y %H:%M:%S")

#delete old plot file if present
if (file.exists(OUTPUT_FILE)) file.remove(OUTPUT_FILE)

#Create Plot - using a background color of gray87 to attempt to match figure/unnamed-chunk-4.png
png(file=OUTPUT_FILE, width = 480, height = 480, bg="gray87")
plot(x, sm1, type="l", ylab = "Energy sub metering", xlab = "")
points(x, sm2, type = "l", col="red")
points(x, sm3, type = "l", col="blue")
legend("topright", 
       lty=1, 
       col=c("black","red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
