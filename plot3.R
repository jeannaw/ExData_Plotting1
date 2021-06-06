library(lubridate)

zipfile <- "exdata_data_household_power_consumption.zip"
# if not, download from the link provided
if (!file.exists(zipfile)){
    file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(file_url, zipfile, method="curl")
}  

# unzip file, if not already unzipped
if (!file.exists("household_power_consumption.txt")) { 
    print("unzipping file")
    unzip(zipfile) 
}else{
    print("File already exists")
}

## Reading data
df.hdp <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings="?")


## Get required subset
df <- subset(df.hdp, Date =="1/2/2007" | Date =="2/2/2007")
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)

# Sys.setlocale(category = "LC_ALL",locale = "English_United States.1252")
df$nDate <- dmy(df$Date) + hms(df$Time)
df$day<- wday(df$nDate,label=TRUE)
# print(str(df))

png(file = "plot3.png", height=480, width=480)

## Creates a plot frame with the desired x and y
plot(df$nDate, df$Sub_metering_1, type='l', col="black", xlab = "", ylab='Energy Sub Metering', xaxt='n')
axis.POSIXct(side=1, x=df$nDate, format="%a", labels = TRUE)
lines(df$nDate, df$Sub_metering_2, col="red")
lines(df$nDate, df$Sub_metering_3, col="blue")
legend ("topright", lty=1, cex=0.8, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# dev.copy(png, file = "plot3.png", height=480, width=480) ## Copy my plot to a PNG file
dev.off()  ## close the PNG device

