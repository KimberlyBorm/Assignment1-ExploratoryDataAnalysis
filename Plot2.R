##Assignment 1 Code -Plot 2 - Exploratory Data Analysis

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

#Create plot 2 (Line Plot of Global Active Power across Time)
    #open png graphing device
    png(filename = "plot2.png", width = 480, height = 480)
    #create desired plot 
        #create line plot with labels,leaving x-axis scale and x label blank
        with(filtered_data, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)", xaxt = "n"))
        #use Date Time for accurate placement of x-axis scale for days
        dt <- filtered_data$DateTime
        axis(1, at = c(min(dt), median(dt), max(dt)), labels = c("Thu", "Fri", "Sat"))
    #turn off graphing device
    dev.off()