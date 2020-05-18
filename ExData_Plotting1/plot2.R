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
plot(T, dat$Global_active_power, type="n",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
lines(T, dat$Global_active_power, type = "l")

#Copy to png file
dev.copy(png, file = "plot2.png")
dev.off()
