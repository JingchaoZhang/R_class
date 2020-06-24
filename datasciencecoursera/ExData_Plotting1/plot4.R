#Download and unzip the file
Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(Url, destfile = "EPC.zip", method = "curl")
unzip("EPC.zip")

library(data.table)
#Read in the data from the dates 2007-02-01 and 2007-02-02
dat <- fread("household_power_consumption.txt", skip = 66637, nrows = 2880)
#Add headers to the dateset
colname <- fread("household_power_consumption.txt", nrows = 1, header = FALSE)
names(dat) <- as.character(colname) 
#Convert the Date and Time
DT <- paste(dat$Date, dat$Time)
T <- strptime(DT, "%d/%m/%Y %H:%M:%S")

#Setup width, height and plot
dev.new(width = 480, height = 480, unit = "px")
par(mfrow = c(2,2))
#1
plot(T, dat$Global_active_power, type="n",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
lines(T, dat$Global_active_power, type = "l")
#2
plot(T, dat$Voltage, type="n",
     xlab = "datetime",
     ylab = "Voltage")
lines(T, dat$Voltage, type = "l")
#3
plot(T, dat$Sub_metering_1, type="n",
     xlab = "",
     ylab = "Energy sub melting")
lines(T, dat$Sub_metering_1, type = "l", col = "black")
lines(T, dat$Sub_metering_2, type = "l", col = "red")
lines(T, dat$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#4
plot(T, dat$Global_reactive_power, type="n",
     xlab = "datetime",
     ylab = "Global_reactive_power")
lines(T, dat$Global_reactive_power, type = "l")
#Copy to png file
dev.copy(png, file = "plot4.png")
dev.off()
