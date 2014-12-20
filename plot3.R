# Exploratory Data Analysis - Project 2, Q3
# The original data set has been unzipped and saved in the local directory

# Load ggplot2 library
library(ggplot2)

# Loads RDS data
NEI <- readRDS("./EDA/Project_2/summarySCC_PM25.rds")

# Take subset of data to include only Baltimore City, MD (fips == '24510')
MD <- subset(NEI, fips=='24510')
MD$year <- factor(MD$year, levels=c('1999', '2002', '2005', '2008'))

# Generate graph into filename plot3.png
png(filename = "./EDA/Project_2/plot3.png")

ggplot(data=MD, aes(x=year, y=log(Emissions))) + facet_grid(. ~ type) + guides(fill=F) +
        geom_boxplot(aes(fill=type)) + stat_boxplot(geom ='errorbar') +
        ylab(expression(paste('Log', ' of PM'[2.5], ' Emissions'))) + xlab('Year') + 
        ggtitle('Emissions per Type in Baltimore City, Maryland') +
        geom_jitter(alpha=0.10)

dev.off()