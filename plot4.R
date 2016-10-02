# Exploratory Data Analysis - Course Project 2
# plot 4
library(ggplot2)
library(dplyr)

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

# search in combined NEI/SCC data for instances pertaining to coal
coalInstances <- grepl("coal", NEISCC$Short.Name, ignore.case = "TRUE")
NEISCCCoal <- NEISCC[coalInstances,]

# aggregate coal emissions by year
NEISCCCoalTotal <- with(NEISCCCoal, aggregate(Emissions ~ year,FUN=sum))

# open graphics device
setwd("~/Desktop/R_class/exp_data/")
png(filename = "plot4.png")

# create plot
g <- ggplot(data = NEISCCCoalTotal, aes(x = year, y = Emissions))
library(scales)
g+geom_bar(stat = "identity")+ggtitle("Total emissions from coal-combustion")+
    labs(ylab(expression('Total PM'[2.5]*' emission (tons)')))+
    scale_x_continuous( breaks = c(1999, 2002, 2005, 2008))+
    scale_y_continuous(labels = comma)

dev.off()
