################################################################################
#
#' Function to calculate Maternal Dietary Diversity for Women.
#'
#' @param df Dataframe containing Maternal Dietary Diversity for Women
#'   variables.
#' @param vars Variables names of MDDW-relevant information.
#'
#' @return A dataframe
#'
#' @examples
#'
#' calculate_mddw(df = individual)
#'
#' @export
#'
#'
#
################################################################################

calculate_mddw <- function(df, vars = c("mddw1", "mddw2", "mddw3",
                                        "mddw4", "mddw5", "mddw6")) {
  dd <- data.frame(matrix(data = NA, nrow = nrow(df), ncol = length(vars) * 19))

  dNames <- NULL

  for(i in vars) {
    dNames <- c(dNames, paste(i, paste("fg", 0:18, sep = ""), sep = "."))
  }

  names(dd) <- dNames

  for(i in vars) {
    x <- expandMultipleChoice(df = df,
                              x = i,
                              values = 0:18,
                              pattern = " ",
                              prefix = "mddw",
                              sep = ".")

    dd[ , names(x)] <- x
  }

  return(dd)
}
