## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

totalsPerYear <- aggregate(NEI$Emissions, by=list(NEI$year), sum)
names(totalsPerYear) <- c("Year", "total")
totalsPerYear$Year <- as.factor(totalsPerYear$Year)

barplot(totalsPerYear$total / 1000,
        names.arg = totalsPerYear$Year,
        ylab = "PM2.5 emission in 1000 tons",
        ylim=c(0, 8000),
        main = "Total emissions per year")

exportToPng <- function(fileName) {
  guiDev <- dev.cur()
  
  png(fileName)
  pngDev <- dev.cur()
  
  dev.set(guiDev)
  dev.copy(which = pngDev)
  dev.off(which = pngDev)
}

exportToPng("plot1.png")