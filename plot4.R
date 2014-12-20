# Exploratory Data Analysis - Project 2, Q4
# The original data set has been unzipped and saved in the local directory

# Load ggplot2 library
library(ggplot2)

# Loads RDS data
NEI <- readRDS("./EDA/Project_2/summarySCC_PM25.rds")
SCC <- readRDS("./EDA/Project_2/Source_Classification_Code.rds")

# Take subset of data to include coal combustion related sources
SCC_coal <- SCC[grepl("coal", SCC$Short.Name, ignore.case=TRUE),]

# Merge data sets
merge <- merge(x = NEI, y= SCC_coal, by = "SCC")
merge.sum <- aggregate(merge[, 'Emissions'], by=list(merge$year), sum)
colnames(merge.sum) <- c('Year', 'Emissions')

# Generate graph into filename plot4.png
png(filename = "./EDA/Project_2/plot4.png")

ggplot(data=merge.sum, aes(x=Year, y=Emissions/1000)) + 
        geom_line(aes(group=1, col=Emissions)) + geom_point(aes(size=2, col=Emissions)) + 
        ggtitle(expression('Total Emissions of PM'[2.5])) + 
        ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) + 
        geom_text(aes(label=round(Emissions/1000,digits=2), size=2, hjust=1.5, vjust=1.5)) + 
        theme(legend.position='none') + scale_colour_gradient(low='red', high='blue')

dev.off()