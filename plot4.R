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

plot_global_active_power <- function(){
  plot(household_power_consumption$DateTime, 
       household_power_consumption$Global_active_power, 
       ylab = "Global Active Power",
       xlab = "",
       type = "l"
  )
}

plot_energy_sub_metering <- function(){
  plot(household_power_consumption$DateTime, 
       household_power_consumption$Sub_metering_1, 
       col = "black",
       ylab = "Energy sub metering",
       xlab = "",
       type = "l"
  )
  
  points( household_power_consumption$DateTime,
          household_power_consumption$Sub_metering_2, 
          type = "l",
          col = "red"
  )
  
  points( household_power_consumption$DateTime,
          household_power_consumption$Sub_metering_3, 
          type = "l",
          col = "blue"
  )
  
  legend("topright", 
         # pch = "-", 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         col = c("black", "red", "blue"),
         lwd = 0,
         bty = "n"
  )
}

plot_voltage <- function(){
  plot(household_power_consumption$DateTime, 
       household_power_consumption$Voltage, 
       ylab = "Voltage",
       xlab = "datetime",
       type = "l"
  )
}

plot_global_reactive_power <- function() {
  plot(household_power_consumption$DateTime, 
       household_power_consumption$Global_reactive_power, 
       ylab = "Global_reactive_power",
       xlab = "datetime",
       type = "l"
  )
}

do_plots <- function() {
  png(filename = "plot4.png", width = 480, height = 480, units = "px")
  
  par(mfrow = c(2,2))  
  
  plot_global_active_power()
  plot_voltage()
  plot_energy_sub_metering()
  plot_global_reactive_power()
  
  dev.off()
}

do_plots()

