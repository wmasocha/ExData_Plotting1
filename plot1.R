
## Script should do the following:
## Subset and use data from the dates 2007-02-01 and 2007-02-02.
##Construct a histogram  of Global_active_power and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.

#Data downloaded and saved in working directory and named "household_power_consumption.txt"

# Read and subset data
gap <- read.table("./household_power_consumption.txt", header=TRUE, sep=";")
gap$Date <- as.Date(gap$Date, format="%d/%m/%Y")
fgap <- gap[(gap$Date=="2007-02-01") | (gap$Date=="2007-02-02"),]
fgap$Global_active_power <- as.numeric(as.character(fgap$Global_active_power))
plot1 <- function() {
        hist(fgap$Global_active_power, main = "Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
        dev.copy(png, file="plot1.png", width=480, height=480)
        dev.off()
        cat("Plot1.png has been saved in", getwd())
}
plot1()
