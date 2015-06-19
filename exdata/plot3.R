## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- NEI[NEI$fips == "24510", ]

totalsPerYear <- aggregate(NEI$Emissions, by=list(NEI$year, NEI$type), sum)
names(totalsPerYear) <- c("Year", "type", "total")
totalsPerYear$Year <- as.factor(totalsPerYear$Year)

library(ggplot2)

g <- ggplot(totalsPerYear, aes(x=Year, y=total))
g <- g + geom_bar(stat="identity")
g <- g + facet_wrap("type", scales = "free_y")
g

exportToPng <- function(fileName) {
  guiDev <- dev.cur()
  
  png(fileName, width = 480, height = 480)
  pngDev <- dev.cur()
  
  dev.set(guiDev)
  dev.copy(which = pngDev)
  dev.off(which = pngDev)
}

exportToPng("plot3.png")