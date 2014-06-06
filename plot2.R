#-----------------------------------------------------------------------------#
#                   Coursera - exdata 003 - Course Project 1                  #
#                       code by: github.com/sornakatta                        #
#-----------------------------------------------------------------------------#
#               This header is common to all 4 files for 4 plots              #
#-----------------------------------------------------------------------------#

# This script downloads the electric consumption data and creates a folder called 'Project1'
# It then creates the second plot of the assignment and writes it into plot2.png

# Create a directory for this assignment
localDir <- 'Project1'
if (!file.exists(localDir)) {
        dir.create(localDir)
}

# Download the electric consumption data
url <- 'http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip'
file <- paste(localDir,basename(url),sep='/')
if (!file.exists(file)) {
        download.file(url, file,method="curl")
        unzip(file,exdir=localDir)
}
# Show the unzipped files 
list.files(localDir)

# Set path to Project1 directory
wd<-paste0(getwd(),"/Project1")
setwd(wd)

# Read in data file from folder
AllData <- read.table("household_power_consumption.txt", header = T,stringsAsFactors = F,sep = ';',na.strings = "?")

# Creating a new column of combined date-time information
AllData$DateTime <- paste(AllData$Date, AllData$Time) 
AllData$DateTime <- strptime(AllData$DateTime, format = "%d/%m/%Y %H:%M:%S")

# Subsetting the data 
SubData <- subset(AllData, Date == "1/2/2007" | Date == "2/2/2007")

# Creating and writing plot2.png into the 'Project1' folder
png(file = "plot2.png")
with(SubData, plot(DateTime, Global_active_power,plot.new(),lines(Global_active_power, DateTime), type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()
