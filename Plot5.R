library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

NEI$year <- factor(NEI$year, levels=c('1999', '2002', '2005', '2008'))

subsetNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD", ]

aggregatedTotalByYear <- aggregate(Emissions ~ year, subsetNEI, sum)
colnames(MD.df) <- c('year', 'Emissions')

png('plot5.png')

g <- ggplot(aggregatedTotalByYear, aes(factor(year), Emissions))

g <- g + geom_bar(stat="identity") + xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = "24510") from 1999 to 2008')

print(g)
dev.off()

