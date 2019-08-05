################################################################################
#
#' Function to pull outcome monitoring data from the ODK server.
#'
#' @param id Form ID of the different forms designed for the outcome monitoring
#'   study
#' @param username ONA server username credentials.
#' @param password ONA server password credentials.
#' @param start Include data from submission dates after (inclusive) this
#'   start date in export to CSV. Date format <yyyy/MM/dd> and default is
#'   current system date
#' @param end Include data from submission dates before (exclusive) this date
#'   in export to CSV. Date format is <yyyy/MM/dd> and default value current
#'   system date
#' @param filename Filename to use for data without the CSV file extension.
#'
#' @return A data.frame corresponding to dataset corresponding to the form ID
#'   specified.
#'
#' @examples
#' \dontrun{
#'   ## Get survey data
#'   get_wfp_data(id = "household",
#'                username = "validmeasures",
#'                password = askpass(),
#'                start = "2019-07-01",
#'                end = Sys.Date(),
#'                filename = "household")
#' }
#'
#' @export
#'
#
################################################################################

get_wfp_data <- function(id, username, password,
                         start = Sys.Date(), end = Sys.Date(),
                         filename) {
  ## Create temporary directory
  temp <- tempdir()
  ## Get latest briefcase and put in temporary directory
  odkr::get_briefcase(destination = tempdir())
  ## Pull ODK forms definitions and submissions from server
  odkr::pull_remote(target = temp,
                    id = id,
                    from = "https://ona.io/wfp_kenya",
                    to = temp,
                    username = username,
                    password = password)
  ## Export dataset
  odkr::export_data(target = temp,
                    id = id,
                    from = temp,
                    to = temp,
                    start = start,
                    end = end,
                    filename = paste(filename, ".csv", sep = ""),
                    overwrite = TRUE)
  ## Read specified dataset
  surveyData <- read.csv(paste(temp, "/", filename, ".csv", sep = ""),
                         stringsAsFactors = FALSE)
  ## Return data.frame
  return(surveyData)
}

################################################################################
#
#' Function to pull outcome monitoring data from the ODK server.
#'
#' @param id Form ID of the different forms designed for the outcome monitoring
#'   study
#' @param username ONA server username credentials.
#' @param password ONA server password credentials.
#' @param start Include data from submission dates after (inclusive) this
#'   start date in export to CSV. Date format <yyyy/MM/dd> and default is
#'   current system date
#' @param end Include data from submission dates before (exclusive) this date
#'   in export to CSV. Date format is <yyyy/MM/dd> and default value current
#'   system date
#' @param filename Filename to use for data without the CSV file extension.
#' @param repeat.name Character value for name of repeat group data to get.
#'
#' @return A data.frame corresponding to the repeat dataset corresponding to
#'   the form ID specified.
#'
#' @examples
#' \dontrun{
#'   ## Get survey data
#'   get_wfp_data(id = "household",
#'                username = "validmeasures",
#'                password = askpass(),
#'                start = "2019-07-01",
#'                end = Sys.Date(),
#'                filename = "household")
#' }
#'
#' @export
#'
#
################################################################################

get_wfp_repeat <- function(id, username, password,
                           start = Sys.Date(), end = Sys.Date(),
                           filename, repeat.name) {
  ## Create temporary directory
  temp <- tempdir()
  ## Get latest briefcase and put in temporary directory
  odkr::get_briefcase(destination = tempdir())
  ## Pull ODK forms definitions and submissions from server
  odkr::pull_remote(target = temp,
                    id = id,
                    from = "https://ona.io/wfp_kenya",
                    to = temp,
                    username = username,
                    password = password)
  ## Export dataset
  odkr::export_data(target = temp,
                    id = id,
                    from = temp,
                    to = temp,
                    start = start,
                    end = end,
                    filename = paste(filename, ".csv", sep = ""),
                    overwrite = TRUE)
  ## Read specified dataset
  surveyData <- read.csv(paste(temp, "/", filename, "-", repeat.name, ".csv", sep = ""),
                         stringsAsFactors = FALSE)
  ## Return data.frame
  return(surveyData)
}

