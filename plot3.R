# Exploratory Data Analysis - Course Project 2
# plot 3
library(ggplot2)

# load data
setwd("~/Desktop/R_class/exp_data/exdata-data-NEI_data/")
if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("Source_Classification_Code.rds")
}

# subset out baltimore data and aggregate by year & type
baltimore <- subset(NEI, fips == "24510")
baltimoreTotal <- with(baltimore, aggregate(Emissions ~ year+type,FUN=sum))

# open graphics device
setwd("~/Desktop/R_class/exp_data/")
png(filename = "plot3.png")

# create plot, faceted by type
g <- ggplot(baltimoreTotal, aes(x=year, y=Emissions))
gbasics <- g + geom_line() + geom_point() + facet_grid(.~type)
gtotal <- gbasics +theme(axis.text.x = element_text(angle = 90, hjust = 1))+
    labs(ylab(expression('Total PM'[2.5]*' emission (tons)')))+
    ggtitle("Emission trends by type for Baltimore")
gtotal

dev.off()
