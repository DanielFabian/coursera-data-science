## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vehic <- SCC[grep('vehic', SCC$EI.Sector, ignore.case = T), ]

NEI <- NEI[NEI$SCC %in% vehic$SCC, ]
NEI <- NEI[NEI$fips == "24510", ]

totalsPerYear <- aggregate(NEI$Emissions, by=list(NEI$year), sum)
names(totalsPerYear) <- c("Year", "total")
totalsPerYear$Year <- as.factor(totalsPerYear$Year)

library(ggplot2)

g <- ggplot(totalsPerYear, aes(x=Year, y=total))
g <- g + geom_bar(stat="identity")
g <- g + ylab("PM2.5 emission in tons")
g <- g + ggtitle("Vehicle emissions - Baltimore City")
print(g)

ggsave("plot5.png", width = 4.8, height = 4.8, dpi = 100)