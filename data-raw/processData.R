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

  responses <- vector(mode = "character", length = nrow(survey))

  for(i in 1:nrow(survey)) {

    if(stringr::str_detect(string = survey$type[i], pattern = "select_one ")) {
      choice.set <- stringr::str_remove_all(string = survey$type[i],
                                            pattern = "select_one ")

      responses[i] <- paste(choices$name[choices$`list name` == choice.set],
                            choices$label[choices$`list name` == choice.set],
                            sep = "=",
                            collapse = "; ")
    }

    if(stringr::str_detect(string = survey$type[i],
                           pattern = "select_multiple ")) {
      choice.set <- stringr::str_remove_all(string = survey$type[i],
                                            pattern = "select_multiple ")

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
usethis::use_data(codebook, overwrite = TRUE)

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
temp2 <- get_wfp_repeat(id = "household",
                        username = "validmeasures",
                        password = "6Y2-8yK-Nmk-Lbf",
                        start = "2019-07-01",
                        filename = "household",
                        repeat.name = "hh_repeat")

coreColumns <- names(temp)[c(1:19, 1185:1188, ncol(temp))]

################################################################################
#
## Create household data.frame
#
################################################################################

household <- data.frame(temp[ , coreColumns], temp[ , c(70:78, 175:805)])

## Remove non-essential and non-data columns
household <- subset(household, select = c(-identify_head, -consent1, -fcsInstructions,
                                          -hhef_instructions, -hhenf_s_instructions,
                                          -hhenf_l_instructions, -ccsi_instruction,
                                          -lcsi_instruction))

household <- household[!is.na(household$vid), ]

## Save household data into package
usethis::use_data(household, overwrite = TRUE)

################################################################################
#
## Merge household identifiers with
#
################################################################################

roster <- merge(temp[ , coreColumns], temp2,
                by.x = "KEY", by.y = "PARENT_KEY",
                all.y = TRUE)

## Remove unnecessary columns with no data
roster <- subset(roster, select = c(-identify_head, -consent1,
                                    -name, -hh_next_member))
usethis::use_data(roster, overwrite = TRUE)

################################################################################
#
# Individual data
#
################################################################################

## Household head
hhHead <- data.frame(temp[ , coreColumns], temp[ , c(56:69, 79:174, 806:819)])

## Remove unnecessary columns and columns with no data
hhHead <- subset(hhHead, select = c(-identify_head, -consent1,
                                    -sers_instruction,
                                    -weai_dimension1_instruction,
                                    -weai_dimension2_instruction,
                                    -weai_dimension3_instruction,
                                    -weai_dimension5_instruction,
                                    -mddw_instruction,
                                    -end_head_interview))

hhHead$respondent <- 1

hhHead$id <- paste(temp$SET.OF.survey.hh_repeat, "[",
                   temp$head_id, "]", sep = "")

names(hhHead) <- c(coreColumns[coreColumns != c("identify_head", "consent1")],
                   "presence", "missing", "missing_other",
                   paste("sers", 1:10, sep = ""),
                   stringr::str_remove(string = names(hhHead)[36:127],
                                       pattern = "_head"),
                   paste("mddw", 1:6, sep = ""),
                   paste("wg", 1:6, sep = ""), "respondent", "id")

## Spouse
hhOther <- data.frame(temp[ , coreColumns], temp[ , c(820:943)])

## Remove unnecessary columns and columns with no data
hhOther <- subset(hhOther, select = c(-identify_head, -consent1,
                                      -sers_instruction.1,
                                      -weai_dimension1_instruction.1,
                                      -weai_dimension2_instruction.1,
                                      -weai_dimension3_instruction.1,
                                      -weai_dimension5_instruction.1,
                                      -mddw_instruction.1,
                                      -end_other_interview))

hhOther$respondent <- 2

hhOther$id <- paste(temp$SET.OF.survey.hh_repeat, "[",
                    temp$spouse1_id, "]", sep = "")

names(hhOther) <- names(hhHead)

## Male youth
hhMaleYouth <- data.frame(temp[ , coreColumns], temp[ , c(944:1060)])

## Remove unnecessary columns and columns with no data
hhMaleYouth <- subset(hhMaleYouth, select = c(-identify_head, -consent1,
                                              -sers_instruction.2,
                                              -weai_dimension1_instruction.2,
                                              -weai_dimension2_instruction.2,
                                              -weai_dimension3_instruction.2,
                                              -weai_dimension5_instruction.2,
                                              -end_myouth_interview))

hhMaleMDDW <- data.frame(matrix(data = NA, nrow = nrow(hhMaleYouth), ncol = 6))
names(hhMaleMDDW) <- c("mddw1", "mddw2", "mddw3", "mddw4", "mddw5", "mddw6")

hhMaleYouth <- data.frame(hhMaleYouth[ , 1:127], hhMaleMDDW, hhMaleYouth[ , 128:133])

hhMaleYouth$respondent <- 3

hhMaleYouth$id <- paste(temp$SET.OF.survey.hh_repeat, "[",
                        temp$myouth_id, "]", sep = "")

names(hhMaleYouth) <- names(hhHead)

## Female youth
hhFemaleYouth <- data.frame(temp[ , coreColumns], temp[ , c(1061:1184)])

## Remove unnecessary columns and columns with no data
hhFemaleYouth <- subset(hhFemaleYouth, select = c(-identify_head, -consent1,
                                                  -sers_instruction.3,
                                                  -weai_dimension1_instruction.3,
                                                  -weai_dimension2_instruction.3,
                                                  -weai_dimension3_instruction.3,
                                                  -weai_dimension5_instruction.3,
                                                  -mddw_instruction.2,
                                                  -end_fyouth_interview))

hhFemaleYouth$respondent <- 4

hhFemaleYouth$id <- paste(temp$SET.OF.survey.hh_repeat, "[",
                          temp$fyouth_id, "]", sep = "")

names(hhFemaleYouth) <- names(hhHead)

individual <- data.frame(rbind(hhHead, hhOther, hhMaleYouth, hhFemaleYouth))

## Add roster information
individual <- merge(individual, temp2, by.x = "id", by.y = "KEY", all.x = TRUE)

## Remove rows with all NA observations
individual <- individual[individual$id != "[NA]", ]
individual <- subset(individual, select = -name)
individual <- subset(individual, presence == 1)
usethis::use_data(individual, overwrite = TRUE)

################################################################################
#
# Create codebook
#
################################################################################

## Household
codebookHousehold <- codebook[codebook$variable %in% names(household), ]

codebookHousehold$question[codebookHousehold$variable == "start"] <- "Start of data collection"
codebookHousehold$question[codebookHousehold$variable == "end"] <- "End of data collection"
codebookHousehold$question[codebookHousehold$variable == "today"] <- "Date data collection was initiated"

usethis::use_data(codebookHousehold, overwrite = TRUE)

## Roster
codebookRoster <- codebook[codebook$variable %in% names(roster), ]
usethis::use_data(codebookRoster, overwrite = TRUE)

## Individual
codebookIndividual <- codebook[codebook$variable %in% names(individual), ]
usethis::use_data(codebookIndividual, overwrite = TRUE)



################################################################################
#
# Data checks
#
################################################################################

id <- paste(stringr::str_pad(string = household$cid, width = 2, side = "left", pad = "0"),
            stringr::str_pad(string = household$wid, width = 3, side = "left", pad = "0"),
            stringr::str_pad(string = household$vid, width = 3, side = "left", pad = "0"),
            sep = "")

## Create CSV of check parameters




