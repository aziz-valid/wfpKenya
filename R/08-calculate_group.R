################################################################################
#
#' Function to calculate group dimension indicators of the Abbreviated
#' Women's Empowerment in Agriculture Index (A-WEAI).
#'
#' @param df Dataframe containing A-WEAI group indicator variables.
#'
#' @return A vector recode of WEAI group dimension of 1 (deficit) or
#'   0 (non-deficit)
#'
#' @examples
#'
#' calculate_group(df = individual)
#'
#' @export
#
################################################################################

calculate_group <- function(df) {
  x <- vector(mode = "numeric", length = nrow(df))

  x[stringr::str_detect(string = df[ , "weai_dimension5"],
                        pattern = "0")] <- 1

  x[rowSums(df[ , c(paste("weai_dimension5", letters[1:9], sep = ""),
                    "weai_dimension5j1b",
                    "weai_dimension5j2b")] - 1,
            na.rm = TRUE) > 0] <- 1

  return(x)
}
