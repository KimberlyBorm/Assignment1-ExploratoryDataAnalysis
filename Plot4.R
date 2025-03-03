##Assignment 1 Code -Plot 4 - Exploratory Data Analysis

#Load data, parse, and reformat
# Define  URL for the dataset and the destination file name for portaility
data_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "household_power_consumption.zip"
#Download file if it doesn't exist
if(!file.exists(destfile)){
    download.file(data_url, destfile, mode = "wb")
    message("Data downloaded succesfully!")
} else{
    message("Data file already exists.")
}
#unzip file if not already unzipped
if(!file.exists("household_power_consumption.txt")){
    unzip(destfile, exdir = ".")
    message("File unzipped succesfully.")
} else{
    message("file already unzipped")
}
#read in only the data specified(Feb 1 and 2) in the assignment from this large data file
#load needed packages
library(readr)
library(dplyr)
#Read files
data <- read_delim("household_power_consumption.txt", delim = ";", na = "?", show_col_types = FALSE)
#filter the data we need
filtered_data <- data %>%
    filter(Date %in% c("1/2/2007", "2/2/2007"))
#convert Date column to date object, as suggested in assignment 
filtered_data <- filtered_data %>%
    mutate(DateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

#Create plot 3 (Line Plot of Energy Sub Metering across Time)
    #open png graphing device
    png(filename = "plot4.png", width = 480, height = 480)
    #create structure for the plot to be placed (fill by columns)
    par(mfcol = c(2,2))
    #first plot (plot 2 with (kilowattts) removed from y label)
        #create line plot with labels, but leave x-axis blank 
        with(filtered_data, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power", xaxt = "n"))
        #use Date Time for acurate placement of x-axis labels for days
            #create object dt to use in all four plots 
            dt <- filtered_data$DateTime
            #use dt min, medium, and max to place labels on x-axis
            axis(1, at = c(min(dt), median(dt), max(dt)), labels = c("Thu", "Fri", "Sat"))
    #second plot (plot 3)
        #create structure to add data into, with y label
        with(filtered_data, plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering", xaxt = "n"))
        #add data piece by piece with color coding
        with(filtered_data, points(DateTime, Sub_metering_1, type = "l", col = "black"))
        with(filtered_data, points(DateTime, Sub_metering_2, type = "l", col = "red"))
        with(filtered_data, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
        #use Date Time for acurate placement of x-axis labels for days
        axis(1, at = c(min(dt), median(dt), max(dt)), labels = c("Thu", "Fri", "Sat"))
        #add legend to label three types of meter reading 
        legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    #third plot (line plot of voltage over time)
        #create line plot with x and y labels, but leave x-axis blank 
        with(filtered_data, plot(DateTime, Voltage, type = "l", ylab = "Voltage", xaxt = "n"))
        #use Date Time for acurate placement of x-axis labels for days
        axis(1, at = c(min(dt), median(dt), max(dt)), labels = c("Thu", "Fri", "Sat")) 
    #forth plot(line plot of Global_reactive_power across time)
        #create line plot with x and y labels, but leave x-axis blank 
        with(filtered_data, plot(DateTime, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xaxt = "n"))
        #use Date Time for acurate placement of x-axis labels for days
        axis(1, at = c(min(dt), median(dt), max(dt)), labels = c("Thu", "Fri", "Sat")) 
    #turn off graphing device
    dev.off()
