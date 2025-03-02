##Assignment 1 Code - Exploratory Data Analysis

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
        data <- read_delim("household_power_consumption.txt", delim = ";", na = "?")
        #filter the data we need
        filtered_data <- data %>%
            filter(Date %in% c("1/2/2007", "2/2/2007"))
    #convert Date column to date object, as suggested in assignment 
        filtered_data <- filtered_data %>%
            mutate(DateTime = strptime(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))


#Create plot 1 (Histogram of Global Active Power in red)
    #open png graphing device
    png(filename = "plot1.png", width = 480, height = 480)
    #create plot 
    with(filtered_data, hist(Global_active_power, col = "red", breaks = 12, xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))
    #turn off graphing device
    dev.off()
        
        
        