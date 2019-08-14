################################################################################
#
#' Function to calculate production dimension indicators of the Abbreviated
#' Women's Empowerment in Agriculture Index (A-WEAI).
#'
#' @param df Dataframe containing A-WEAI production indicator variables.
#'
#' @return A vector recode of WEAI production dimension of 1 (deficit) or
#'   0 (non-deficit)
#'
#' @examples
#'
#' calculate_production(df = individual)
#'
#' @export
#'
#
################################################################################

calculate_production <- function(df) {
  x <- ifelse(stringr::str_detect(string = df[["weai_dimension1aa"]],
                                  pattern = "1",
                                  negate = TRUE), 1,
         ifelse(df[["weai_dimension1aa"]] == "", NA, 0))

  y <- ifelse(df[["weai_dimension1ab"]] == 98, NA,
         ifelse(df[["weai_dimension1ab"]] == 1, 1, 0))

  z <- ifelse(df[["weai_dimension1ac"]] %in% 1:2, 1, 0)

  xyz <- data.frame(x, y, z)

  p <- ifelse(rowSums(xyz, na.rm = TRUE) > 0, 1, 0)

  return(p)
}
