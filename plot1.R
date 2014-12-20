# Exploratory Data Analysis - Project 2, Q1
# The original data set has been unzipped and saved in the local directory

# Loads RDS data
NEI <- readRDS("./EDA/Project_2/summarySCC_PM25.rds")

# Aggregates the PM2.5 emissions data by year
Emissions <- aggregate(NEI[, 'Emissions'], by = list(NEI$year), FUN=sum)

# Convert units to Kilotons and round
Emissions$PM <- round(Emissions[,2]/1000, 2)

# Generate graph into filename plot1.png
png(filename = "./EDA/Project_2/plot1.png")
barplot(Emissions$PM, names.arg = Emissions$Group.1, main = expression('Total Emission of PM'[2.5]), xlab = 'Year', ylab = expression(paste('PM', ''[2.5], ' in Kilotons')))
dev.off()