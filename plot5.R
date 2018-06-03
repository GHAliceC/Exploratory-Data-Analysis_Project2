rm(list = ls())
setwd("./Documents/R_programming")

# Use any plotting system to show the change of motor vehicle sources in emissions
# from 1999-2008 in Baltimore City

NEI <- readRDS("./exdata_Fdata_FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_Fdata_FNEI_data/Source_Classification_Code.rds")

# subset Baltimore City and motor vehicle type data
Bal_Road_data <- NEI[(NEI$fips == "24510") & (NEI$type == "ON-ROAD"), ]
Bal_Road_TotalbyYear <- aggregate(Emissions ~ year, Bal_Road_data, sum)

png("plot5.png")
plot <- barplot(height = Bal_Road_TotalbyYear$Emissions, names.arg = Bal_Road_TotalbyYear$year,
                xlab = 'Years', ylab = 'Total PM2.5 Emission',
                main = 'Total PM2.5 Emission from motor vehicle by tons', ylim = c(0,500))
text(x = plot, Bal_Road_TotalbyYear$Emissions, labels = round(Bal_Road_TotalbyYear$Emissions,2), pos = 3)
dev.off()
