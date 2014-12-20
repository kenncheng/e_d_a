# Exploratory Data Analysis - Project 2, Q5
# The original data set has been unzipped and saved in the local directory

# Load ggplot2 library
library(ggplot2)

# Loads RDS data
NEI <- readRDS("./EDA/Project_2/summarySCC_PM25.rds")
SCC <- readRDS("./EDA/Project_2/Source_Classification_Code.rds")

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

# Take subset of data to include Baltimore City, MD and type == 'ON-ROAD'
MD.onroad <- subset(NEI, fips=='24510' & type=='ON-ROAD')

# Aggregate data
MD.df <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum)
colnames(MD.df) <- c('year', 'Emissions')

# Generate graph into filename plot5.png
png(filename = "./EDA/Project_2/plot5.png")

ggplot(data=MD.df, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year), stat="identity") + guides(fill=F) + 
        ggtitle('Total Emissions of Motor Vehicle Sources in Baltimore City, Maryland') + 
        ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + 
        geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=2))

dev.off()