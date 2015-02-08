
## Script should do the following:
## Subset and use data from the dates 2007-02-01 and 2007-02-02.
##Construct a figure with 4 plots in it and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.

#Data downloaded and saved in working directory and named "household_power_consumption.txt"

# Read and subset data
gap <- read.table("./household_power_consumption.txt", header=TRUE, sep=";")
gap$Date <- as.Date(gap$Date, format="%d/%m/%Y")
fgap <- gap[(gap$Date=="2007-02-01") | (gap$Date=="2007-02-02"),]
fgap$Global_active_power <- as.numeric(as.character(fgap$Global_active_power))
fgap$Global_reactive_power <- as.numeric(as.character(fgap$Global_reactive_power))
fgap$Voltage <- as.numeric(as.character(fgap$Voltage))
fgap <- transform(fgap, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
fgap$Sub_metering_1 <- as.numeric(as.character(fgap$Sub_metering_1))
fgap$Sub_metering_2 <- as.numeric(as.character(fgap$Sub_metering_2))
fgap$Sub_metering_3 <- as.numeric(as.character(fgap$Sub_metering_3))
plot4 <- function() {
        par(mfrow=c(2,2))
        
        ## First plot
        plot(fgap$timestamp,fgap$Global_active_power, type="l", xlab="", ylab="Global Active Power")
        ##Second plot
        plot(fgap$timestamp,fgap$Voltage, type="l", xlab="datetime", ylab="Voltage")
        
        ##Third plot
        plot(fgap$timestamp,fgap$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(fgap$timestamp,fgap$Sub_metering_2,col="red")
        lines(fgap$timestamp,fgap$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
        
        #Fourth plot
        plot(fgap$timestamp,fgap$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
        
        #OUTPUT
        dev.copy(png, file="plot4.png", width=480, height=480)
        dev.off()
        cat("plot4.png has been saved in", getwd())
}
plot4()