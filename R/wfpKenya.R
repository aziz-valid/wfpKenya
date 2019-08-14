################################################################################
#
#' The World Food Programme Kenya Country Strategic Plan Outcome Monitoring
#' aims to assess WFP's progress towards its goals. This package facilitates
#' the processing, management and analysis of data collected for the outcome
#' monitoring.
#'
#' @docType package
#' @name wfpKenya
#'
#' @importFrom utils read.csv
#' @importFrom odkr get_briefcase pull_remote export_data renameODK
#' @importFrom stringr str_split str_detect
#'
#'
#
################################################################################
NULL

## quiets concerns of R CMD check re: the psus and THRESHOLD that appear in bbw
if(getRversion() >= "2.15.1")  utils::globalVariables(c("sex",
                                                        "respondent",
                                                        "hh_member_age"))
