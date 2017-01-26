library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Across the United States, how have emissions from coal 
##combustion-related sources changed from 1999-2008?

SCC.coal = SCC[grepl("Coal", SCC$Short.Name, ignore.case=TRUE),]

coalmerge <- merge(x=NEI, y=SCC.coal, by='SCC')

mergeagg <- aggregate(coalmerge[, 'Emissions'], by=list(coalmerge$year), sum)

colnames(mergeagg) <- c('Year', 'Emissions')

png('plot4.png')


a <- ggplot(data=mergeagg, aes(x=Year, y=Emissions/1000)) + 
  geom_line(aes(group=1, col=Emissions)) + geom_point(aes(size=2, col=Emissions)) + 
  ggtitle(expression('Total Emissions of PM'[2.5])) + 
  ylab(expression(paste('PM', ''[2.5], ' in kilotons'))) + 
  geom_text(aes(label=round(Emissions/1000,digits=2), size=2, hjust=1.5, vjust=1.5)) + 
  theme(legend.position='none') + scale_colour_gradient(low='black', high='red')

print(a)
dev.off()
