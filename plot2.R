#Plot 2
#Read in the "Individual household electric power consumption" Data Set for dates
#2007-02-01 and 2007-02-02.
#
#Create a scatter plot of the Global Active Power over the dates
#Save plot into file plot2.png

OUTPUT_FILE <- "plot2.png"

#use fread from data.table due to its speed
library(data.table)

#Source the fetcher code to check to see if we need to fetch the Data Set
source("ds_fetcher.R")

#Read in the data and subset it based on the required dates
#NOTE: Dates in the DS are in dd/mm/yyyy format
power <- fread("household_power_consumption.txt", na.strings = "?")
days <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")
gap <- days$Global_active_power

#Create the date/time X axis 
dates <- days$Date
times <- days$Time
dt <- paste(dates,times)
x <- strptime(dt, "%d/%m/%Y %H:%M:%S")

#delete old plot file if present
if (file.exists(OUTPUT_FILE)) file.remove(OUTPUT_FILE)

#Create Plot - using a background color of gray87 to attempt to match figure/unnamed-chunk-2.png
png(file="plot2.png", width = 480, height = 480, bg="gray87")
plot(x, gap, type = "l", xlab="", ylab = "Global Active Power (kilowatts)")
dev.off()

