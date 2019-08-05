## code to prepare `DATASET` dataset goes here

library(odkr)

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
hhHead        <- data.frame(temp[ , coreColumns], temp[ , c(56:69, 806:819)])
hhOther       <- data.frame(temp[ , coreColumns], temp[ , c(820:943)])
hhMaleYouth   <- data.frame(temp[ , coreColumns], temp[ , c(944:1060)])
hhFemaleYouth <- data.frame(temp[ , coreColumns], temp[ , c(1061:1184)])
