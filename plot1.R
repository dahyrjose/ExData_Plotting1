## This script generates plot 1

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
hpc$Global_active_power <- as.numeric(as.character(hpc$Global_active_power))

# Actually construct Plot 1 and save it to PNG file 
# with resolution = 480 x 480 px
png("plot1.png", width = 480, heigh = 480, units = "px")
hist(hpc$Global_active_power, col = "red", breaks = 12 
	 , xlab = "Global Active Power (kilowatts)" 
	 , main = "Global Active Power")
dev.off()