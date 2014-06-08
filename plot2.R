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
Sys.setlocale("LC_TIME","US")
plot2=with(data, plot(Time,Global_active_power,type="l" ,xlab="",ylab="Global Active Power (kilowatts)"))

##Save as PNG
dev.copy(png,"plot2.png")
dev.off()
