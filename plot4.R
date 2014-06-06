#-----------------------------------------------------------------------------#
#                   Coursera - exdata 003 - Course Project 1                  #
#                       code by: github.com/sornakatta                        #
#-----------------------------------------------------------------------------#
#               This header is common to all 4 files for 4 plots              #
#-----------------------------------------------------------------------------#

# This script downloads the electric consumption data and creates a folder called 'Project1'
# It then creates the fourth plot of the assignment and writes it into plot4.png

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

# Creating and writing plot4.png into the 'Project1' folder

#First changing the default setting to accomodate 4 plots
par(mfcol = c(2, 2))

# Plot 4-1 (Same as plot 2)
with(SubData, plot(DateTime, Global_active_power,plot.new(),lines(Global_active_power, DateTime), type = "l", xlab = "", ylab = "Global Active Power"))

# Plot 4-2 (Same as plot 3)
with(SubData, plot(DateTime, Sub_metering_1,lines(Sub_metering_1, DateTime), type = "l",xlab = "",ylab = "Energy Sub Metering"))
#plot(SubData$DateTime, SubData$Sub_metering_1,plot.new(),lines(SubData$Sub_metering_1, SubData$DateTime), type = "l",xlab = "",ylab = "Energy Sub Metering")
lines(SubData$DateTime, SubData$Sub_metering_2, col = "red")
lines(SubData$DateTime, SubData$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black", "red","blue"),lty = c(1,1,1),bty = "n")

#Plot 4-3
with(SubData, plot(DateTime, Voltage,lines(Voltage, DateTime), type = "l", xlab = "datetime", ylab = "Voltage"))

#Plot 4-4 and writing to plot4.png
with(SubData, plot(DateTime,Global_reactive_power,lines(Global_reactive_power, DateTime), type = "l", xlab = "datetime"))
dev.copy(png, file = "plot4.png")
dev.off()
