##Assignment 1 Code -Plot 3 - Exploratory Data Analysis

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
png(filename = "plot3.png", width = 480, height = 480)
#create plot 
    #create structure to add data into, leaving x-axis scale and x label blank
    with(filtered_data, plot(DateTime, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering", xaxt = "n"))
    #add data piece by piece with color coding
    with(filtered_data, points(DateTime, Sub_metering_1, type = "l", col = "black"))
    with(filtered_data, points(DateTime, Sub_metering_2, type = "l", col = "red"))
    with(filtered_data, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
    #use Date Time for acurate placement of x-axis labels for days
    dt <- filtered_data$DateTime
    axis(1, at = c(min(dt), median(dt), max(dt)), labels = c("Thu", "Fri", "Sat"))
    #add legend to label threetypes of meter reading 
    legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#turn off graphing device
#turn off graphing device
dev.off()
