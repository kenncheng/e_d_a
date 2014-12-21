# Exploratory Data Analysis - Project 2, Q3
# The original data set has been unzipped and saved in the local directory

# Load ggplot2 library
library(ggplot2)

# Loads RDS data for PM2.5 Emissions Data
NEI <- readRDS("./EDA/Project_2/summarySCC_PM25.rds")

# Take subset of data to include only Baltimore City, MD (fips == '24510')
MD <- subset(NEI, fips=='24510')

# Generate plot into filename plot3.png
png(filename = "./EDA/Project_2/plot3.png")

ggplot(MD, aes(year, Emissions, color = type)) +
        geom_line(stat = "summary", fun.y = "sum") +
        ylab(expression('Total PM'[2.5]*" Emissions")) + xlab('Year') +
        ggtitle("Total Emissions per Type in Baltimore City")

dev.off()