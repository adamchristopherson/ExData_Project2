# Exploratory Data Analysis - Course Project 2
# plot 5
library(ggplot2)

# load data 
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

# subset out data for Baltimore, and motor ("ON-ROAD")
baltimoreCombined <- subset(NEISCC, fips == "24510")
baltimoreMotor <- subset(baltimoreCombined, type == "ON-ROAD")

# aggregate by year
baltimoreMotorTotal <- with(baltimoreMotor, aggregate(Emissions ~ year,FUN=sum))

# open graphics device
setwd("~/Desktop/R_class/exp_data/")
png(filename = "plot5.png")

# create plot
g <- ggplot(data = baltimoreMotorTotal, aes(x = year, y = Emissions))
library(scales)
g+geom_bar(stat = "identity")+ggtitle("Total motor related emissions in Baltimore")+
    labs(ylab(expression('Total PM'[2.5]*' emission (tons)')))+
    scale_x_continuous( breaks = c(1999, 2002, 2005, 2008))+
    scale_y_continuous(labels = comma)

dev.off()
