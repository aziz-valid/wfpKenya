## code to prepare `DATASET` dataset goes here

library(odkr)
library(openxlsx)
library(readxl)

################################################################################
#
# Pull household data from ODK
#
################################################################################

temp <- get_wfp_data(id = "household",
                     username = "validmeasures",
                     password = "6Y2-8yK-Nmk-Lbf",
                     start = "2019-07-01",
                     filename = "household")

coreColumns <- names(temp)[c(1:19, 1185:1188, ncol(temp))]

household     <- data.frame(temp[ , coreColumns], temp[ , c(70:78, 175:805)])

## Remove non-essential and non-data columns
household <- subset(household, select = c(-identify_head, -consent1, -fcsInstructions,
                                          -hhef_instructions, -hhenf_s_instructions,
                                          -hhenf_l_instructions, -ccsi_instruction,
                                          -lcsi_instruction))

usethis::use_data(household, overwrite = TRUE)

hhHead        <- data.frame(temp[ , coreColumns], temp[ , c(56:69, 79:174, 806:819)])
hhOther       <- data.frame(temp[ , coreColumns], temp[ , c(820:943)])
hhMaleYouth   <- data.frame(temp[ , coreColumns], temp[ , c(944:1060)])
hhFemaleYouth <- data.frame(temp[ , coreColumns], temp[ , c(1061:1184)])

roster <- read.xlsx(x = "data-raw/data/household_data.xlsx", sheet = 2)



################################################################################
#
# Create codebook
#
################################################################################

survey <- read_xlsx(path = "data-raw/data/household.xlsx", sheet = "survey")
choices <- read_xlsx(path = "data-raw/data/household.xlsx", sheet = "choices")

codebookHousehold <- survey[survey$name %in% names(household), c("name", "label")]
codebookHousehold$label[codeHousehold$name == "start"] <- "Start of data collection"
codebookHousehold$label[codeHousehold$name == "end"] <- "End of data collection"
codebookHousehold$label[codeHousehold$name == "today"] <- "Date data collection was initiated"

usethis::use_data(codebookHousehold, overwrite = TRUE)

codeHead <- survey[survey$name %in% names(hhHead), c("name", "label")]
codeOther <- survey[survey$name %in% names(hhOther), c("name", "label")]
codeMaleYouth <- survey[survey$name %in% names(hhMaleYouth), c("name", "label")]
codeFemaleYouth <- survey[survey$name %in% names(hhFemaleYouth), c("name", "label")]




