# Exploratory Data Analysis - Project 2, Q6
# The original data set has been unzipped and saved in the local directory

# Load ggplot2 library
library(ggplot2)

# Loads RDS data for PM2.5 Emissions Data and for Source Classification Code Table
NEI <- readRDS("./EDA/Project_2/summarySCC_PM25.rds")
SCC <- readRDS("./EDA/Project_2/Source_Classification_Code.rds")

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

# Take subset of data to include Baltimore City, MD and type == 'ON-ROAD'
# Take subset of data to include Los Angeles County, CA and type == 'ON-ROAD'
MD.onroad <- subset(NEI, fips=='24510' & type=='ON-ROAD')
CA.onroad <- subset(NEI, fips=='06037' & type=='ON-ROAD')

# Aggregate data
MD.df <- aggregate(MD.onroad[, 'Emissions'], by=list(MD.onroad$year), sum)
colnames(MD.df) <- c('year', 'Emissions')
MD.df$City <- paste(rep('MD', 4))

CA.df <- aggregate(CA.onroad[, 'Emissions'], by=list(CA.onroad$year), sum)
colnames(CA.df) <- c('year', 'Emissions')
CA.df$City <- paste(rep('CA', 4))

# Combine MD and CA data
df <- as.data.frame(rbind(CA.df, MD.df))

# Generate graph into filename plot6.png
png(filename = "./EDA/Project_2/plot6.png")

ggplot(data=df, aes(x=year, y=Emissions)) + geom_bar(aes(fill=year), stat="identity") + guides(fill=F) + 
        ggtitle('Total Emissions of Motor Vehicle Sources\nLos Angeles County, California vs. Baltimore City, Maryland') + 
        ylab(expression('PM'[2.5])) + xlab('Year') + theme(legend.position='none') + facet_grid(. ~ City) + 
        geom_text(aes(label=round(Emissions,0), size=1, hjust=0.5, vjust=-1))

dev.off()