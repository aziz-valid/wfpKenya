## code to prepare `DATASET` dataset goes here

library(odkr)
library(openxlsx)
library(readxl)

################################################################################
#
# Prepare codebook
#
################################################################################

## Read survey sheet of xlsform
survey <- read_xlsx(path = "data-raw/data/household.xlsx", sheet = "survey")

## Select rows with type that contains data
survey <- survey[!survey$type %in% c("begin group", "begin repeat",
                                    "end group", "end repeat", "note"), ]

survey <- survey[!is.na(survey$type), ]

## Read choices sheet of xlsform
choices <- read_xlsx(path = "data-raw/data/household.xlsx", sheet = "choices")

## Remove blanks
choices <- choices[!is.na(choices$`list name`), ]

get_choices <- function(survey, choices) {

  #types <- survey$type[stringr::str_detect(string = survey$type, pattern = "select_")]
  responses <- vector(mode = "character", length = nrow(survey))

  for(i in 1:nrow(survey)) {

    if(stringr::str_detect(string = survey$type[i], pattern = "select_one ")) {
      choice.set <- stringr::str_remove_all(string = survey$type[i], pattern = "select_one ")

      responses[i] <- paste(choices$name[choices$`list name` == choice.set],
                            choices$label[choices$`list name` == choice.set],
                            sep = "=",
                            collapse = "; ")
    }

    if(stringr::str_detect(string = survey$type[i], pattern = "select_multiple ")) {
      choice.set <- stringr::str_remove_all(string = survey$type[i], pattern = "select_multiple ")

      responses[i] <- paste(choices$name[choices$`list name` == choice.set],
                            choices$label[choices$`list name` == choice.set],
                            sep = "=",
                            collapse = "; ")
    }
  }

  return(responses)
}

responses <- get_choices(survey = survey, choices = choices)

codebook <- data.frame(variable = as.character(survey$name),
                       question = as.character(survey$label),
                       choices = as.character(responses))


codebook <- tibble::as_tibble(codebook)
codebook$variable <- as.character(codebook$variable)
codebook$question <- as.character(codebook$question)
codebook$choices <- as.character(codebook$choices)


################################################################################
#
# Process various datasets from ODK
#
################################################################################

## Pull household data
temp <- get_wfp_data(id = "household",
                     username = "validmeasures",
                     password = "6Y2-8yK-Nmk-Lbf",
                     start = "2019-07-01",
                     filename = "household")

## Pull repeat data
roster <- get_wfp_repeat(id = "household",
                         username = "validmeasures",
                         password = "6Y2-8yK-Nmk-Lbf",
                         start = "2019-07-01",
                         filename = "household",
                         repeat.name = "hh_repeat")

coreColumns <- names(temp)[c(1:19, 1185:1188, ncol(temp))]

## Create household data.frame
household <- data.frame(temp[ , coreColumns], temp[ , c(70:78, 175:805)])

## Remove non-essential and non-data columns
household <- subset(household, select = c(-identify_head, -consent1, -fcsInstructions,
                                          -hhef_instructions, -hhenf_s_instructions,
                                          -hhenf_l_instructions, -ccsi_instruction,
                                          -lcsi_instruction))

## Save household data into package
usethis::use_data(household, overwrite = TRUE)

codebookHousehold <- codebook[codebook$variable %in% names(household), ]

codebookHousehold$question[codebookHousehold$variable == "start"] <- "Start of data collection"
codebookHousehold$question[codebookHousehold$variable == "end"] <- "End of data collection"
codebookHousehold$question[codebookHousehold$variable == "today"] <- "Date data collection was initiated"

usethis::use_data(codebookHousehold, overwrite = TRUE)



## Merge household identifiers with
roster <- merge(temp[ , coreColumns], roster, by.x = "KEY", by.y = "PARENT_KEY", all = TRUE)



hhHead        <- data.frame(temp[ , coreColumns], temp[ , c(56:69, 79:174, 806:819)])
hhOther       <- data.frame(temp[ , coreColumns], temp[ , c(820:943)])
hhMaleYouth   <- data.frame(temp[ , coreColumns], temp[ , c(944:1060)])
hhFemaleYouth <- data.frame(temp[ , coreColumns], temp[ , c(1061:1184)])




################################################################################
#
# Create codebook
#
################################################################################





codeHead <- survey[survey$name %in% names(hhHead), c("name", "label")]
codeOther <- survey[survey$name %in% names(hhOther), c("name", "label")]
codeMaleYouth <- survey[survey$name %in% names(hhMaleYouth), c("name", "label")]
codeFemaleYouth <- survey[survey$name %in% names(hhFemaleYouth), c("name", "label")]




