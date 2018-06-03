rm(list = ls())
setwd("./Documents/R_programming")

# Use the base plotting system to make a plot showing the total emissions 
# from PM2.5 decreased from 1999-2008 in the Baltimore City, Maryland

NEI <- readRDS("./exdata_Fdata_FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_Fdata_FNEI_data/Source_Classification_Code.rds")
# Aggregate Baltimore emissions data by years
Bal_data <- NEI[NEI$fips == "24510", ]
Bal_TotalbyYear <- aggregate(Emissions ~ year, Bal_data, sum)

png("plot2.png")
plot <- barplot(height = Bal_TotalbyYear$Emissions/1000, names.arg = Bal_TotalbyYear$year,
                xlab = 'Years', ylab = 'Baltimore City, Maryland Total PM2.5 Emission', col = Bal_TotalbyYear$year,
                main = 'Total PM2.5 Emission in Baltimore City by Kilotons', ylim = c(0,5))
text(x = plot, Bal_TotalbyYear$Emissions/1000, labels = round(Bal_TotalbyYear$Emissions/1000, 2), pos = 3)
dev.off()

