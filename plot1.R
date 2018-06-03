rm(list = ls())
setwd("./Documents/R_programming")

# Using the base plotting system, make a plot showing the total/PM2.5
# emission from all sources for each of the years 1999, 2002, 2005,and 2008.

NEI <- readRDS("./exdata_Fdata_FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_Fdata_FNEI_data/Source_Classification_Code.rds")
# Aggregate each year's total emission
TotalbyYear <- aggregate(Emissions ~ year, NEI, sum)

png("plot1.png")
plot <- barplot(height = TotalbyYear$Emissions/1000, names.arg = TotalbyYear$year,
        xlab = 'Years', ylab = 'Total PM2.5 Emission', col = TotalbyYear$year,
        main = 'Total PM2.5 Emission from All Sources by Kilotons', ylim = c(0,8000))
text(x = plot, TotalbyYear$Emissions/1000, labels = round(TotalbyYear$Emissions/1000, 2), pos = 3)
dev.off()
