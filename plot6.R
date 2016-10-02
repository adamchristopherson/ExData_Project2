# Exploratory Data Analysis - Course Project 2
# plot 6

# load data
library(ggplot2)
setwd("~/Desktop/R_class/exp_data/exdata-data-NEI_data/")
if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("Source_Classification_Code.rds")
}
if(!exists("NEISCC")){
    NEISCC <- merge(NEI, SCC, by = "SCC")
}

# subset for motor related emissions in LA and Baltimore 

baltimoreCombined <- subset(NEISCC, fips == "24510")
LACombined <- subset(NEISCC, fips == "06037")
baltimoreMotor <- subset(baltimoreCombined, type == "ON-ROAD")
LAMotor <- subset(LACombined, type == "ON-ROAD")

# aggregate Emissions by year, and add city identifier before combining 
# into one data frame
baltimoreMotorTotal <- with(baltimoreMotor, aggregate(Emissions ~ year,FUN=sum))
baltimoreMotorTotal$city <- rep("Baltimore", 4)
LAMotorTotal <- with(LAMotor, aggregate(Emissions ~ year, FUN = sum))
LAMotorTotal$city <- rep("LA", 4)
combinedMotorTotal <- rbind(baltimoreMotorTotal, LAMotorTotal)

# png graphics device
setwd("~/Desktop/R_class/exp_data/")
png(filename = "plot6.png")

# create plot 
g <- ggplot(data = combinedMotorTotal, aes(x=year, y=Emissions, fill=city))
library(scales)
# add geom - stack puts bar charts on top of one another, filled by city
g+geom_bar(position="stack", stat = "identity")+
    ggtitle("Comparing motor related emissions in Baltimore and Los Angeles")+
    labs(ylab(expression('Total PM'[2.5]*' emission (tons)')))+
    scale_x_continuous( breaks = c(1999, 2002, 2005, 2008))+
    scale_y_continuous(labels = comma)
dev.off()
