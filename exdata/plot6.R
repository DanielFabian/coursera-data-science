## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

vehic <- SCC[grep('vehic', SCC$EI.Sector, ignore.case = T), ]

NEI <- NEI[NEI$SCC %in% vehic$SCC, ]
NEI <- NEI[NEI$fips %in% c("24510", "06037"), ]

totalsPerYear <- aggregate(NEI$Emissions, by=list(NEI$year, NEI$fips), sum)
names(totalsPerYear) <- c("Year", "fips", "total")
totalsPerYear$Year <- as.factor(totalsPerYear$Year)
totalsPerYear$fips <- as.factor(totalsPerYear$fips)
levels(totalsPerYear$fips) <- c("Los Angeles County", "Baltimore City")

library(ggplot2)

g <- ggplot(totalsPerYear, aes(x=Year, y=total/1000))
g <- g + geom_bar(stat="identity")
g <- g + ylab("PM2.5 emission in 1000 tons")
g <- g + ggtitle("Vehicle emissions - Baltimore City")
g

exportToPng <- function(fileName) {
  guiDev <- dev.cur()
  
  png(fileName, width = 480, height = 480)
  pngDev <- dev.cur()
  
  dev.set(guiDev)
  dev.copy(which = pngDev)
  dev.off(which = pngDev)
}

exportToPng("plot5.png")