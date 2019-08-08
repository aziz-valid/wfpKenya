library(openxlsx)
library(readxl)

intervention <- read_xlsx("data-raw/data/sampleList2.xlsx", sheet = 1)

## Read choices sheet of xlsform
choices <- read_xlsx(path = "data-raw/data/household.xlsx", sheet = "choices")

counties <- choices[95:107, ]
wards <- choices[109:258, ]
villages <- choices[261:531, ]

temp1 <- merge(villages, wards, by.x = "ward", by.y = "name")

county <- vector(mode = "character", length = nrow(temp1))
county[temp1$county.x == 1 ] <- "Baringo"
county[temp1$county.x == 2 ] <- "Garissa"
county[temp1$county.x == 3 ] <- "Isiolo"
county[temp1$county.x == 4 ] <- "Kilifi"
county[temp1$county.x == 5 ] <- "Kitui"
county[temp1$county.x == 6 ] <- "Kwale"
county[temp1$county.x == 7 ] <- "Makueni"
county[temp1$county.x == 8 ] <- "Marsabit"
county[temp1$county.x == 9 ] <- "Samburu"
county[temp1$county.x == 10] <- "Taita Taveta"
county[temp1$county.x == 11] <- "Tana River"
county[temp1$county.x == 12] <- "Turkana"
county[temp1$county.x == 13] <- "Wajir"

sampleList <- data.frame(countyID = temp1$county.x,
                         county,
                         wardID = temp1$ward,
                         ward = temp1$label.y,
                         villageID = temp1$name,
                         village = temp1$label.x)

sampleList$county <- as.character(sampleList$county)
sampleList$ward <- as.character(sampleList$ward)
sampleList$village <- as.character(sampleList$village)

sampleList$studyGroup <- ifelse(sampleList$village %in% intervention$`Villages (Sub Location)`, 1, 2)
sampleList$psu <- paste(stringr::str_pad(string = sampleList$countyID, width = 2, side = "left", pad = "0"),
                        stringr::str_pad(string = sampleList$wardID, width = 3, side = "left", pad = "0"),
                        stringr::str_pad(string = sampleList$villageID, width = 3, side = "left", pad = "0"),
                        sep = "")

write.csv(sampleList, "data-raw/data/sampleList.csv", row.names = FALSE)


