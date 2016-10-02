# Exploratory Data Analysis - Course Project 2
# plot 1

# load data
setwd("~/Desktop/R_class/exp_data/exdata-data-NEI_data/")
if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("Source_Classification_Code.rds")
}

# aggregate data by total
byTotal <- with(NEI, tapply(Emissions, year, sum))

# open graphics device
setwd("~/Desktop/R_class/exp_data/")
png(filename = "plot1.png")

#create plot
barplot(byTotal, xlab = "years", ylab= expression('Total PM'[2.5]*' emission (tons)'),
        main = expression("Total emissions of PM"[2.5]*" by year"))
dev.off()
