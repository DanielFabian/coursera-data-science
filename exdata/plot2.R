## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

NEI <- NEI[NEI$fips == "24510", ]

totalsPerYear <- aggregate(NEI$Emissions, by=list(NEI$year), sum)
names(totalsPerYear) <- c("Year", "total")
totalsPerYear$Year <- as.factor(totalsPerYear$Year)

barplot(totalsPerYear$total,
        names.arg = totalsPerYear$Year,
        ylab = "PM2.5 emission in tons",
        main = "Emissions per year for Baltimore City")

exportToPng <- function(fileName) {
  guiDev <- dev.cur()
  
  png(fileName, width = 480, height = 480)
  pngDev <- dev.cur()
  
  dev.set(guiDev)
  dev.copy(which = pngDev)
  dev.off(which = pngDev)
}

exportToPng("plot2.png")