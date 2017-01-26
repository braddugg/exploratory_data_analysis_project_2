library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

##Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
##variable, which of these four sources have seen decreases in emissions from 1999-2008 
##for Baltimore City? Which have seen increases in emissions from 1999-2008? 
##Use the ggplot2 plotting system to make a plot answer this question.

Maryland <- subset(NEI, fips == 24510)

Maryland$year <- factor(Maryland$year, levels=c('1999', '2002', '2005', '2008'))

png('plot3.png')

ggplot(data=Maryland, aes(x=year, y=log(Emissions))) + facet_grid(. ~ type) + guides(fill=F) +
  geom_boxplot(aes(fill=type)) + stat_boxplot(geom ='errorbar') +
  ylab(expression(paste('Log of Emissions'))) + xlab('Year') + 
  ggtitle('Emissions per Type in Baltimore City *** Maryland') +
  geom_jitter(alpha=0.10)

dev.off()
