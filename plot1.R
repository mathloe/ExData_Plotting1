# check if the source .txt file exists, if not download it
if(!file.exists("household_power_consumption.txt")){
      download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
      "household_power_consumption.zip")
      unzip("household_power_consumption.zip")
}

# load the data and subset the desired dates
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE,
                   colClasses = c("character","character","numeric","numeric",
                                  "numeric","numeric","numeric","numeric",
                                  "numeric"), na.strings = "?")
data_short <- subset(data, Date == "2/2/2007" | Date == "1/2/2007")

# create the graph and save as png

png("plot1.png", bg = "transparent")
hist(data_short$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()
