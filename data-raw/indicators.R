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

