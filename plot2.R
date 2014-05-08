## This script generates plot 2

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

# Actually construct Plot 1 and save it to PNG file 
# with resolution = 480 x 480 px
png("plot2.png", width = 480, heigh = 480, units = "px")

plot(hpc$Global_active_power ~ hpc$datetime 
	 , ylab = "Global Active Power (kilowatts)", xlab = "" 
	 , type = "l")

dev.off()
