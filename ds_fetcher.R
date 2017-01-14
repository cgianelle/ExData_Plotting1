DATA_SET <- "household_power_consumption.txt"
DS_URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
DS_ZIP <- "household_power_consumption.zip"

#Check to see if we already have the extracted data set in our environment
#if not, fetch the file from the URL and then extract it here
if (!file.exists(DATA_SET)) {
    download.file(DS_URL, destfile = DS_ZIP)    
    unzip(DS_ZIP)
}