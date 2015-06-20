## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coalComb <- SCC[grep('coal', SCC$EI.Sector, ignore.case = T), ]
coalComb <- coalComb[grep('comb', coalComb$EI.Sector, ignore.case = T), ]

NEI <- NEI[NEI$SCC %in% coalComb$SCC, ]

totalsPerYear <- aggregate(NEI$Emissions, by=list(NEI$year), sum)
names(totalsPerYear) <- c("Year", "total")
totalsPerYear$Year <- as.factor(totalsPerYear$Year)

library(ggplot2)

g <- ggplot(totalsPerYear, aes(x=Year, y=total/1000))
g <- g + geom_bar(stat="identity")
g <- g + ylab("PM2.5 emission in 1000 tons")
g <- g + ggtitle("Total emission - Coal combustion related sources")
print(g)

ggsave("plot4.png", width = 4.8, height = 4.8, dpi = 100)