# Exploratory Data Analysis - Course Project 2
# plot 2

# load data
setwd("~/Desktop/R_class/exp_data/exdata-data-NEI_data/")
if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("Source_Classification_Code.rds")
}

# subset out data for baltimore, and aggregate Emissions by year
baltimore <- subset(NEI, fips == "24510")
baltimoreTotal <- with(baltimore, tapply(Emissions, year, sum))

# open graphics device
setwd("~/Desktop/R_class/exp_data/")
png(filename = "plot2.png")
# create plot
barplot(baltimoreTotal, xlab = "years", ylab= expression('Total PM'[2.5]*' emission (tons)'), main = expression("Total emissions of PM"[2.5]*" by year for Baltimore"))
dev.off()
