## Core variables
coreVars <- c("vid", "KEY", "sex", "hh_member_age", "respondent", "studyGroup", "lhz")

################################################################################
#
# Create SERS indicator dataset
#
################################################################################

sers <- data.frame(individual[ , coreVars], calculate_sers(df = individual))
names(sers) <- c("psu", "hhid", "sex", "age", "respondent", "studyGroup", "lhz",
                 paste("sers", 1:10, sep = ""), "score", "resilience")

usethis::use_data(sers, overwrite = TRUE)


################################################################################
#
# Calculate disability indicators dataset
#
################################################################################

wg <- data.frame(individual[ , coreVars], calculate_wg(df = individual))
names(wg) <- c("psu", "hhid", "sex", "age", "respondent", "studyGroup", "lhz",
               names(wg)[8:ncol(wg)])

usethis::use_data(wg, overwrite = TRUE)


################################################################################
#
# Calculate MDDW indicators dataset
#
################################################################################

mddw <- data.frame(individual[individual$sex == 2, coreVars],
                   calculate_mddw(df = individual[individual$sex == 2, ]))
names(mddw) <- c("psu", "hhid", "sex", "age", "respondent", "studyGroup", "lhz",
                 paste("fg", 1:10, sep = ""), "fg", "mddw")
usethis::use_data(mddw, overwrite = TRUE)


################################################################################
#
# Create indicator dataset for 4 dimensions of WEAI (production, resources,
# credit, group)
#
################################################################################

weai <- data.frame(individual[ , coreVars],
                   calculate_production(df = individual),
                   calculate_resources(df = individual),
                   calculate_credit(df = individual),
                   calculate_group(df = individual))

names(weai) <- c("psu", "hhid", "sex", "age", "respondent", "studyGroup",
                 "lhz", "production", "resources", "credit", "group")

usethis::use_data(weai, overwrite = TRUE)


################################################################################
#
# Create indicator dataset for gender parity of WEAI dimensions
#
################################################################################

temp <- calculate_gpi(individual)

gpiHead <- temp[[1]]
gpiHead <- gpiHead[!is.na(gpiHead$psu), ]
usethis::use_data(gpiHead, overwrite = TRUE)


gpiYouth <- temp[[2]]
gpiYouth <- gpiYouth[!is.na(gpiYouth$psu), ]
usethis::use_data(gpiYouth, overwrite = TRUE)
