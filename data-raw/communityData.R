## code to prepare `DATASET` dataset goes here

library(odkr)
library(openxlsx)
library(readxl)


################################################################################
#
# Pull and process community form
#
################################################################################

## Pull community data
temp <- get_wfp_data(id = "community",
                     username = "validmeasures",
                     password = "6Y2-8yK-Nmk-Lbf",
                     start = "2019-07-01",
                     filename = "community")

## Create psu population data.frame

psu <- paste(stringr::str_pad(string = temp$cid, width = 2,
                              side = "left", pad = 0),
             stringr::str_pad(string = temp$wid, width = 3,
                              side = "left", pad = 0),
             stringr::str_pad(string = temp$vid, width = 3,
                              side = "left", pad = 0),
             sep = "")

psuData <- data.frame(psu, pop = temp$dm1)
usethis::use_data(psuData, overwrite = TRUE)

## Create community data.frame

community <- subset(temp,
                    select = c(-uuid, -consent1,
                               -other_village, -replacement,
                               -replacement_name, -instanceID,
                               -KEY))

## Update vid for those with 999
community[78, "vid"]  <- 118
community[77, "vid"]  <- 125
community[60, "vid"]  <- 24
community[79, "vid"]  <- 103
community[106, "vid"] <- 153
community[61, "vid"]  <- 23
community[community$wid == 117, "vid"] <- 227
community[community$cid == 6 & community$wid == 104, "vid"] <- 135

## Update vid for those with duplicates

table(community$vid)[table(community$vid) > 1]

## Check vid == 22
#community[community$cid == 8 & community$wid == 9 & community$vid == 22, "wid"] <- 103
#community[community$cid == 8 & community$wid == 9 & community$vid == 22, "wid"] <- 103

## Check vid == 34
community[community$vid == 34, "vid"] <- 228

## Check vid == 38
community[community$vid == 38, ]

## check vid == 132
community[community$cid == 12 & community$wid == 69 & community$vid == 132, "vid"] <- 133

## check vid == 135
community[community$cid == 6 & community$wid == 104 & community$vid == 135, "wid"] <- 135
community[community$cid == 6 & community$wid == 135 & community$vid == 135, "vid"] <- 234

## check vid == 186
community[community$vid == 186, ]
community[community$cid == 2 & community$wid == 141 & community$vid == 186, "vid"] <- 238

## check vid == 187
community[community$cid == 1 & community$wid == 130 & community$vid == 187, "vid"] <- 232

## check vid == 189
community[community$cid == 4 & community$wid == 14 & community$vid == 189, "vid"] <- 184

## check vid = 191
community[community$cid == 8 & community$wid == 136 & community$vid == 191, "vid"] <- 235
community[community$cid == 8 & community$wid == 103 & community$vid == 191, "cid"] <- 13
community[community$cid == 13 & community$wid == 103 & community$vid == 191, "wid"] <- 26

## check vid == 228
community[community$vid == 228, ]

## check vid == 242
community[community$cid == 13 & community$wid == 142 & community$vid == 242, "wid"] <- 5
community[community$cid == 1 & community$wid == 30 & community$vid == 242, "vid"] <- 113
community[community$cid == 1 & community$wid == 91 & community$vid == 242, "vid"] <- 259
community[community$cid == 8 & community$wid == 139 & community$vid == 242, "vid"] <- 236

## Check vid == 177
community[community$vid == 177, c("cid", "wid", "vid")]
##
community[community$cid == 1 & community$wid == 20 & community$vid == 177, "vid"] <- 187
##
community[31, "wid"] <- 28
community[31, "vid"] <- 192
##
community[community$cid == 8 & community$wid == 139 & community$vid == 177, "vid"] <- 262
#community[community$cid == 8 & community$wid == 139 & community$vid == 242, "vid"] <- 262
##
community[community$cid == 5 & community$wid == 100 & community$vid == 177, "vid"] <- 44
##
community[community$cid == 3 & community$wid == 8 & community$vid == 177, "vid"] <- 180
##
community[community$cid == 10 & community$wid == 9 & community$vid == 22, "cid"] <- 8
community[community$cid == 10 & community$wid == 9 & community$vid == 22, "wid"] <- 103
##
community[community$cid == 10 & community$wid == 9 & community$vid == 177, "vid"] <- 145
##
community[community$cid == 3 & community$wid == 140 & community$vid == 177, "vid"] <- 237
community[community$cid == 13 & community$wid == 131 & community$vid == 237, "vid"] <- 233
##
community[45, "vid"] <- 208
community[44, "vid"] <- 9
##
community[community$cid == 5 & community$wid == 87 & community$vid == 177, "vid"] <- 54
## community[community$cid == 5 & community$wid == 87 & community$vid == 177, "vid"] <- 257
##
community[community$cid == 5 & community$wid == 48 & community$vid == 177, "vid"] <- 204
##
community[community$cid == 5 & community$wid == 19 & community$vid == 177, "vid"] <- 186
##
community[community$cid == 5 & community$wid == 113 & community$vid == 177, "vid"] <- 167
##
community[community$cid == 12 & community$wid == 71 & community$vid == 177, "vid"] <- 212
community[community$cid == 12 & community$wid == 71 & community$vid == 199, "vid"] <- 254
##
community[community$cid == 5 & community$wid == 55 & community$vid == 177, "vid"] <- 205
##
community[community$cid == 5 & community$wid == 41 & community$vid == 177, "vid"] <- 200
##
community[community$cid == 13 & community$wid == 23 & community$vid == 177, "vid"] <- 189
##
community[community$cid == 4 & community$wid == 125 & community$vid == 177, "vid"] <- 231
##
community[community$cid == 12 & community$wid == 40 & community$vid == 177, "vid"] <- 199
##
community[community$cid == 12 & community$wid == 38 & community$vid == 177, "vid"] <- 197
##
community[community$cid == 5 & community$wid == 84 & community$vid == 177, "vid"] <- 82
##
community[community$cid == 5 & community$wid == 42 & community$vid == 177, "vid"] <- 122
##
community[community$cid == 3 & community$wid == 115 & community$vid == 177, "vid"] <- 98
## community[community$cid == 3 & community$wid == 115 & community$vid == 177, "vid"] <- 225
community[community$cid == 4 & community$wid == 83 & community$vid == 177, "vid"] <- 218
##2
community[community$cid == 1 & community$wid == 89 & community$vid == 177, "vid"] <- 219
community[community$cid == 1 & community$wid == 89 & community$vid == 253, "vid"] <- 258
##
community[community$cid == 7 & community$wid == 82 & community$vid == 177, "vid"] <- 217
##
community[community$cid == 7 & community$wid == 102 & community$vid == 177, "vid"] <- 223
##
community[community$cid == 8 & community$wid == 103 & community$vid == 191, "vid"] <- 141
community[community$cid == 8 & community$wid == 103 & community$vid == 177, "vid"] <- 214
community[community$cid == 8 & community$wid == 103 & community$vid == 195, "vid"] <- 22
##
community[community$cid == 13 & community$wid == 26 & community$vid == 177, "vid"] <- 191
##
community[community$cid == 9 & community$wid == 116 & community$vid == 177, "vid"] <- 226
##
community[community$cid == 9 & community$wid == 2 & community$vid == 177, "vid"] <- 95
##
community[community$cid == 9 & community$wid == 1 & community$vid == 177, "vid"] <- 89
##
community[community$cid == 7 & community$wid == 146 & community$vid == 177, "vid"] <- 241
##
community[community$cid == 7 & community$wid == 46 & community$vid == 177, "vid"] <- 202
##
community[community$cid == 1 & community$wid == 34 & community$vid == 177, "vid"] <- 195
##
community[community$cid == 1 & community$wid == 91 & community$vid == 177, "vid"] <- 220
community[community$cid == 1 & community$wid == 91 & community$vid == 242, "vid"] <- 259
##
community[community$cid == 7 & community$ wid == 36 & community$vid == 177, "vid"] <- 196
##
community[community$cid == 7 & community$wid == 137 & community$vid == 177, "vid"] <- 59
##
community[168, "vid"] <- 221
community[169, "vid"] <- 260
##
community[community$cid == 9 & community$wid == 143 & community$vid == 177, "vid"] <- 240
##
community[community$cid == 2 & community$wid == 74 & community$vid == 177, "vid"] <- 100
##
community[community$cid == 1 & community$wid == 33 & community$vid == 177, "vid"] <- 194
##
community[community$cid == 1 & community$wid == 43 & community$vid == 177, "vid"] <- 201
##
community[197, "vid"] <- 185
community[198, "vid"] <- 246

community <- data.frame(psu, community)
usethis::use_data(community, overwrite = TRUE)

## Read xlsform

survey <- read_xlsx(path = "data-raw/data/community.xlsx", sheet = "survey")
survey <- survey[!survey$type %in% c("begin group", "begin repeat",
                                     "end group", "end repeat", "note"), ]
survey <- survey[!is.na(survey$type), ]

choices <- read_xlsx(path = "data-raw/data/community.xlsx", sheet = "choices")
choices <- choices[!is.na(choices$`list name`), ]

responses <- get_choices(survey = survey, choices = choices)
codebook <- data.frame(variable = as.character(survey$name),
                       question = as.character(survey$label),
                       choices = as.character(responses))
codebook$variable <- as.character(codebook$variable)
codebook$question <- as.character(codebook$question)
codebook$choices <- as.character(codebook$choices)

codebookCommunity <- codebook
codebookCommunity <- codebook[codebook$variable %in% names(community), ]
usethis::use_data(codebookCommunity, overwrite = TRUE)
