################################################################################
#
#' Function to calculate credit dimension indicators of the Abbreviated
#' Women's Empowerment in Agriculture Index (A-WEAI).
#'
#' @param df Dataframe containing A-WEAI credit indicator variables.
#'
#' @return A vector recode of WEAI credit dimension of 1 (deficit) or
#'   0 (non-deficit)
#'
#' @examples
#'
#' calculate_credit(df = individual)
#'
#' @export
#'
#
################################################################################

calculate_credit <- function(df) {
  x <- vector(mode = "numeric", length = nrow(df))

  x[df[["weai_dimension3"]] == "0"] <- 1

  x[rowSums(apply(X = df[ , paste("weai_dimension3",
                                  letters[1:6],
                                  "a",
                                  sep = "")],
                  MARGIN = 2,
                  FUN = function(x) ifelse(x == 4, 1,
                                      ifelse(x == 97, NA, 0))),
            na.rm = TRUE) >= 1] <- 1

  x[rowSums(apply(X = df[ , paste("weai_dimension3",
                                  letters[1:6],
                                  "b",
                                  sep = "")],
                  MARGIN = 2,
                  FUN = stringr::str_detect, pattern = "1", negate = TRUE),
            na.rm = TRUE) == 6] <- 1

  x[rowSums(apply(X = df[ , paste("weai_dimension3",
                                  letters[1:6],
                                  "c",
                                  sep = "")],
                  MARGIN = 2,
                  FUN = stringr::str_detect, pattern = "1", negate = TRUE),
            na.rm = TRUE) == 6] <- 1

  return(x)
}
