# Read in original data
Sys.setlocale("LC_ALL", "English")
full_table <- read.csv("household_power_consumption.txt",header = TRUE,sep = ";",stringsAsFactors = FALSE,na.strings = "?")
full_table$Date <- as.Date(full_table$Date,"%d/%m/%Y")
sub_table <- full_table[full_table$Date >= as.Date("2007-02-01") & full_table$Date <= as.Date("2007-02-02"),]
good <- complete.cases(sub_table[,3:9])
sub_table_clean <- sub_table[good,]
sub_table_clean$DateTime <- paste(sub_table_clean$Date,sub_table_clean$Time)
sub_table_clean$DateTime <- strptime(sub_table_clean$DateTime,"%Y-%m-%d %H:%M:%S")
sub_table_clean$Global_active_power <- as.numeric(sub_table_clean$Global_active_power)
sub_table_clean$Global_reactive_power <- as.numeric(sub_table_clean$Global_reactive_power)
sub_table_clean$Voltage <- as.numeric(sub_table_clean$Voltage)
sub_table_clean$Global_intensity <- as.numeric(sub_table_clean$Global_intensity)
sub_table_clean$Sub_metering_1 <- as.numeric(sub_table_clean$Sub_metering_1)
sub_table_clean$Sub_metering_2 <- as.numeric(sub_table_clean$Sub_metering_2)
sub_table_clean$Sub_metering_3 <- as.numeric(sub_table_clean$Sub_metering_3)

# Plot 4
png("plot4.png")
par(mfrow = c(2,2))
plot(sub_table_clean$DateTime,sub_table_clean$Global_active_power,xlab = "", ylab = "Global Active Power (kilowatts)",type = "l")
plot(sub_table_clean$DateTime,sub_table_clean$Voltage,xlab = "datetime", ylab = "Voltage",type = "l")
plot(sub_table_clean$DateTime,sub_table_clean$Sub_metering_1,type = "l", ylab = "Energy sub metering", xlab = "")
lines(sub_table_clean$DateTime,sub_table_clean$Sub_metering_2,type = "l",col="red")
lines(sub_table_clean$DateTime,sub_table_clean$Sub_metering_3,type = "l",col="blue")
legend('topright',legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty = 1,bty = "n")
plot(sub_table_clean$DateTime,sub_table_clean$Global_reactive_power,xlab = "datetime", ylab = "Global_reactive_power",type = "l")
dev.off()