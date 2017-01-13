#Plot 1
#Read in the "Individual household electric power consumption" Data Set for dates
#2007-02-01 and 2007-02-02.
#
#Create a histogram plot of the Global Active Power
#Save plot into file plot1.png

OUTPUT_FILE <- "plot1.png"

#use fread from data.table due to its speed
library(data.table)

#Source the fetcher code to check to see if we need to fetch the Data Set
source("ds_fetcher.R")

#Read in the data and subset it based on the required dates
#NOTE: Dates in the DS are in dd/mm/yyyy format
power <- fread("household_power_consumption.txt", na.strings = "?")
days <- subset(power, Date == "1/2/2007" | Date == "2/2/2007")
gap <- days$Global_active_power

#delete old plot file if present
if (file.exists(OUTPUT_FILE)) file.remove(OUTPUT_FILE)

png(file=OUTPUT_FILE, width = 480, height = 480, bg="gray87")
hist(gap, col="red", bg="gray", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()