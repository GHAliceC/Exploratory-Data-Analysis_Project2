rm(list = ls())
setwd("./Documents/R_programming")

# Use any plotting system to show emissions from coal combustion-related
# sources changed from 1999-2008

NEI <- readRDS("./exdata_Fdata_FNEI_data/summarySCC_PM25.rds")
SCC <- readRDS("./exdata_Fdata_FNEI_data/Source_Classification_Code.rds")

# merge two datasets
NEI_SCC <- merge(NEI, SCC, by = 'SCC')

# get coal combustion-related data from combined dataset
Combustion_Coal <- grepl("Fuel Comb.*Coal", NEI_SCC$EI.Sector)
Combustion_Coal_data <- NEI_SCC[Combustion_Coal, ]
Combustion_Coal_TotalbyYear <- aggregate(Emissions ~ year, Combustion_Coal_data, sum)

library(ggplot2)

png("plot4.png", width = 600, height = 650)
ggplot(Combustion_Coal_TotalbyYear, aes(factor(year), Emissions/1000, fill = year, label = round(Emissions/1000,2))) +
  geom_bar(stat = "identity") +
  xlab("Years") +
  ylab("Total Emissions from Coal Combustion related sources") + 
  ggtitle("Emissions from Coal Combustion related sources from 1999-2008 in kilotons") +
  geom_label(aes(fill = year), colour = "white", fontface = "bold")
dev.off()

