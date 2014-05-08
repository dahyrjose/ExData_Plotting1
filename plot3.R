## This script generates plot 3

# Unzip and read data into hpc data frame
## Set language to english and set to use locale
Sys.setenv(LANGUAGE="en")
Sys.setlocale(category = "LC_ALL", locale = "C")
## Gathering data using zipped dataset provided in 
## the assignment
unzip("exdata-data-household_power_consumption.zip")

# Get only required dates and load into hpc data frame
indices <- grep("^1.2.2007|^2.2.2007"
				, readLines("household_power_consumption.txt"))
hpc <- droplevels(read.table("household_power_consumption.txt"
							 , sep = ";", header = T)[indices, ])
rm(indices)


# Cast Global_active_power variable as numeric
hpc$Global_active_power <- 
	as.numeric(as.character(hpc$Global_active_power))
hpc$datetime <- as.POSIXct(
	strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S"))
hpc$sm1 <- as.numeric(as.character(hpc$Sub_metering_1))
hpc$sm2 <- as.numeric(as.character(hpc$Sub_metering_2))
hpc$sm3 <- as.numeric(as.character(hpc$Sub_metering_3))

# Actually construct Plot 1 and save it to PNG file 
# with resolution = 480 x 480 px
png("plot3.png", width = 480, heigh = 480, units = "px")

plot(hpc$sm1 ~ hpc$datetime 
	 , ylab = "Energy sub metering", xlab = "" 
	 , type = "l")
lines(hpc$sm2 ~ hpc$datetime, col = "red")
lines(hpc$sm3 ~ hpc$datetime, col = "blue")
legend("topright", col = c("black", "red", "blue"), lwd = 1 
	   , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
