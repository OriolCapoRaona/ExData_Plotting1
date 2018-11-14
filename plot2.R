rm(list = ls())

fileLocation <- "household_power_consumption.txt"

if(!file.exists(fileLocation)){
  dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url = dataUrl, destfile = './household.zip')
  unzip(zipfile = './household.zip')
}

table <- read.table(file = fileLocation, header = TRUE, sep = ";", na.strings = "?")

household_power_consumption <- table[table$Date == "1/2/2007" | table$Date == "2/2/2007",]
household_power_consumption$DateTime <- paste(household_power_consumption$Date, household_power_consumption$Time, sep = " ")
household_power_consumption$DateTime <- strptime(household_power_consumption$DateTime, format = "%d/%m/%Y %H:%M:%S")

png(filename = "plot2.png", width = 480, height = 480)

plot(household_power_consumption$DateTime, 
     household_power_consumption$Global_active_power, 
     ylab = "Global Active Power (kilowatts)",
     xlab = "",
     type = "l"
)

dev.off()

