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

# convert the Date and Time columns to one posixlt time column
data_short$DateTime <- paste(data_short$Date, data_short$Time)
data_short$DateTime <- strptime(data_short$DateTime, "%d/%m/%Y %H:%M:%S")

# create the graph and save as png
png("plot3.png", bg = "transparent")
with(data_short, plot(DateTime, Sub_metering_1, type = "l",
                      ylab = "Energy sub metering", xlab = ""))
with(data_short, points(DateTime, Sub_metering_2, type = "l", col = "red"))
with(data_short, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", col = c("black","red","blue"), lty = 1, legend =
             c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()