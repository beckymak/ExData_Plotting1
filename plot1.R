#Download data file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="p1.zip")
unzip("p1.zip",list=T)

##Read in dataset
header=read.table("household_power_consumption.txt",sep=";",nrows=1,header=T)
header

data=read.table("household_power_consumption.txt",sep=";",header=F,skip=66000,nrows=3800,col.names=names(header))
summary(data)

##Convert date & time
data$Time = paste(data$Date , data$Time)
data$Time = strptime(data$Time, format="%d/%m/%Y %H:%M:%S")
data$Date=as.Date(data$Date,format="%d/%m/%Y")

##Subset only 2007-02-01 & 2007-02-02
data = data[data$Date=="2007-02-01" | data$Date=="2007-02-02",]

##Impute missing value
data[which(data[,-c(1,2)]=="?")]=NA

##Plot
plot1=with(data, hist(Global_active_power,col="red", main="Global Active Power",xlab="Global Active Power (kilowatts)"))

##Save as PNG
dev.copy(png,"plot1.png")
dev.off()
