################################################################################
#
# Create SERS indicator dataset
#
################################################################################

coreVars <- c("vid", "KEY", "sex", "hh_member_age", "respondent", "studyGroup", "lhz")

sers <- data.frame(individual[ , coreVars], calculate_sers(df = individual))
names(sers) <- c("psu", "hhid", "sex", "age", "respondent", "studyGroup", "lhz",
                 paste("sers", 1:10, sep = ""), "score", "resilience")

usethis::use_data(sers, overwrite = TRUE)

