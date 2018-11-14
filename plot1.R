rm(list = ls())

fileLocation <- "household_power_consumption.txt"

if(!file.exists(fileLocation)){
  dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url = dataUrl, destfile = './household.zip')
  unzip(zipfile = './household.zip')
}

table <- read.table(file = fileLocation, header = TRUE, sep = ";", na.strings = "?")
household_power_consumption <- table[table$Date == "1/2/2007" | table$Date == "2/2/2007",]

png(filename = "plot1.png", width = 480, height = 480)

hist(household_power_consumption$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)"
     )

dev.off()

