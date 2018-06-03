rm(list = ls())
setwd("./Documents/R_programming")

# Use ggplot2 plotting system to indicate the changes of four types of sources 
# in emissions from 1999-2008 in the Baltimore City, Maryland

NEI <- readRDS("./exdata_Fdata_FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_Fdata_FNEI_data/Source_Classification_Code.rds")

library(ggplot2)

# subset Baltimore City's data and agregate it by years and types
Bal_data <- NEI[NEI$fips == "24510", ]
Bal_TotalbyYearType <- aggregate(Emissions ~ year + type, Bal_data, sum)

png("plot3.png", width = 800, height = 600)
g <- ggplot(Bal_TotalbyYearType, aes(factor(year), Emissions, fill = type,label = round(Emissions,2))) +
    xlab("Years") + ylab("Baltimore City, Maryland Total PM2.5 Emission") + 
    geom_bar(stat = "identity") + facet_grid(. ~ type) +
    ggtitle('Baltimore City, Maryland Total PM2.5 Emission by sources types in tons') + 
    geom_label(color = "white", fontface = 'bold') 

print(g)
dev.off()

