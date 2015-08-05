# Read the first column (Date)
myCols <- c("character", rep("NULL", 8))
preData <- read.table('household_power_consumption.txt', header = T, sep = ';', colClasses = myCols)

# Extract data from specified dates
myRows <- which(preData$Date == '1/2/2007' | preData$Date == '2/2/2007')
dataset <- read.table('household_power_consumption.txt', header = F, sep = ';', skip = myRows[1], nrows = length(myRows))
header <- read.table('household_power_consumption.txt', header = F, sep = ';', nrows = 1)
colnames(dataset) <- unlist(header)

# Memory cleaning
rm(preData)

# Format the date variable
dataset$DateTime <- strptime(paste(as.character(dataset$Date), as.character(dataset$Time)), 
                             "%d/%m/%Y %H:%M:%S")

## Plot3
png(filename = "plot3.png", width = 480, height = 480)
plot(dataset$DateTime, dataset$Sub_metering_1, type = "l", col = "black",
     ylab = "Energy Sub Metering")
lines(dataset$DateTime, dataset$Sub_metering_2, col = "red")
lines(dataset$DateTime, dataset$Sub_metering_3, col = "blue")
legend("topright", lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"))
dev.off()
