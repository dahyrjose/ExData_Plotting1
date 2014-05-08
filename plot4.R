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
hpc$datetime <- as.POSIXct(
	strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S"))
hpc$Global_active_power <- 
	as.numeric(as.character(hpc$Global_active_power))
hpc$Global_reactive_power <- 
	as.numeric(as.character(hpc$Global_reactive_power))
hpc$Voltage <- as.numeric(as.character(hpc$Voltage))
hpc$sm1 <- as.numeric(as.character(hpc$Sub_metering_1))
hpc$sm2 <- as.numeric(as.character(hpc$Sub_metering_2))
hpc$sm3 <- as.numeric(as.character(hpc$Sub_metering_3))

# Actually construct Plot 1 and save it to PNG file 
# with resolution = 480 x 480 px
png("plot4.png", width = 480, heigh = 480, units = "px")

# Arranging 4 panel charts
par(mfrow = c(2, 2))

# Panel (1, 1)
plot(hpc$Global_active_power ~ hpc$datetime 
	 , ylab = "Global Active Power", xlab = "" 
	 , type = "l")

# Panel (1, 2)
plot(hpc$Voltage ~ hpc$datetime 
	 , ylab = "Voltage", xlab = "datetime" 
	 , type = "l")

# Panel (2, 1)
plot(hpc$sm1 ~ hpc$datetime 
	 , ylab = "Energy sub metering", xlab = "" 
	 , type = "l")
lines(hpc$sm2 ~ hpc$datetime, col = "red")
lines(hpc$sm3 ~ hpc$datetime, col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = 1 
	   , bty = "n" 
	   , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Panel (2, 2)
plot(hpc$Global_reactive_power ~ hpc$datetime 
	 , ylab = "Global_reactive_power", xlab = "datetime" 
	 , type = "l")


dev.off()
