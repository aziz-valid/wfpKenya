################################################################################
#
#' Function to calculate resources dimension indicators of the Abbreviated
#' Women's Empowerment in Agriculture Index (A-WEAI).
#'
#' @param df Dataframe containing A-WEAI resources indicator variables.
#'
#' @return A vector recode of WEAI resources dimension of 1 (deficit) or
#'   0 (non-deficit)
#'
#' @examples
#'
#' calculate_resources(df = individual)
#'
#' @export
#'
#
################################################################################

calculate_resources <- function(df) {

  x <- vector(mode = "numeric", length = nrow(df))

  x[rowSums(df[ , paste("weai_dimension2",
                        letters[1:14],
                        sep = "")] - 1,
            na.rm = TRUE) > 0] <- 1

  x[rowSums(df[ , paste("weai_dimension2",
                        letters[1:14],
                        "_1",
                        sep = "")] - 1,
            na.rm = TRUE) > 0] <- 1

  x[rowSums(df[ , paste("weai_dimension2",
                        letters[1:14],
                        sep = "")],
            na.rm = TRUE) == 1 &
      rowSums(df[ , c("weai_dimension2d",
                      "weai_dimension2f",
                      "weai_dimension2k")]) == 1] <- 1

  return(x)
}
