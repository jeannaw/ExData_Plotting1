
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
# cat("data set dimension ", dim(df.hdp), "\n")

## Get required subset
df <- subset(df.hdp, Date =="1/2/2007"|Date =="2/2/2007")
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)
# cat("sub data set dimension ", dim(df), "\n")

with(df, hist(df$Global_active_power, col = "red", 
              main="Global Active Power", 
              xlab="Global Active Power (kilowatt)", 
              ylab="Frequency")
     )

dev.copy(png, file = "plot1.png", height=480, width=480 ) ## Copy my plot to a PNG file
dev.off()  ## close the PNG device 

