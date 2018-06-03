rm(list = ls())
setwd("./Documents/R_programming")

# Use any plotting system to compare emissions from motor vehicle sources between
# Baltimore City and Los Angeles County from 1999-2008

NEI <- readRDS("./exdata_Fdata_FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_Fdata_FNEI_data/Source_Classification_Code.rds")

# aggregate Baltimore City and Los Angeles data separatly
Bal_Road_data <- NEI[(NEI$fips == "24510") & (NEI$type == "ON-ROAD"), ]
Bal_Road_TotalbyYear <- aggregate(Emissions ~ year, Bal_Road_data, sum)
LA_Road_data <- NEI[(NEI$fips == "06037") & (NEI$type == "ON-ROAD"), ]
LA_Road_TotalbyYear <- aggregate(Emissions ~ year, LA_Road_data, sum)

png("plot6.png", width = 600, height = 800)
par(mfrow = c(2,1))
barplot(height = Bal_Road_TotalbyYear$Emissions, names.arg = Bal_Road_TotalbyYear$year,
        xlab = 'Years', ylab = 'Total PM2.5 Emission(Baltimore City)', col = "red",
        main = 'Total PM2.5 Emission from motor vehicle sources by tons(Baltimore City)', ylim = c(0,500))
text(x = plot, Bal_Road_TotalbyYear$Emissions, labels = round(Bal_Road_TotalbyYear$Emissions, 2), pos = 3)

barplot(height = LA_Road_TotalbyYear$Emissions, names.arg = LA_Road_TotalbyYear$year,
        xlab = 'Years', ylab = 'Total PM2.5 Emission(Los Angeles)', col = "blue",
        main = 'Total PM2.5 Emission from motor vehicle by tons(Los Angeles)', ylim = c(0,5000))
text(x = plot, LA_Road_TotalbyYear$Emissions, labels = round(LA_Road_TotalbyYear$Emissions, 2), pos = 3)

dev.off()
