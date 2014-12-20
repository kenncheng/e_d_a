# Exploratory Data Analysis - Project 2, Q2
# The original data set has been unzipped and saved in the local directory

# Loads RDS data
NEI <- readRDS("./EDA/Project_2/summarySCC_PM25.rds")

# Take subset of data to include only Baltimore City, MD (fips == '24510')
MD <- subset(NEI, fips=='24510')

# Generate graph into filename plot2.png
png(filename = "./EDA/Project_2/plot2.png")

barplot(tapply(X=MD$Emissions, INDEX=MD$year, FUN=sum), 
        main='Total Emission in Baltimore City, MD', 
        xlab='Year', ylab=expression('PM'[2.5]))

dev.off()