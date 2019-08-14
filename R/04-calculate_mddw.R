################################################################################
#
#' Function to recode 18 food items into 10 food groups specific to MDDW.
#'
#' @param df Dataframe containing Maternal Dietary Diversity for Women
#'   variables.
#' @param vars Variable names of MDDW-relevant information.
#'
#' @return A dataframe with number of rows equal to number of rows of \code{df}
#'   and columns for each of the 10 food groups relevent to MDDW recoded into 1
#'   (consumed) or 0 (not consumed), for total number of food groups consumed,
#'   and whether a minimum of 5 food groups have been consumed.
#'
#' @examples
#'
#' calculate_mddw(df = individual)
#'
#' @export
#'
#
################################################################################

calculate_mddw <- function(df, vars = c("mddw1", "mddw2", "mddw3",
                                        "mddw4", "mddw5", "mddw6")) {

  food <- data.frame(matrix(data = NA, nrow = nrow(df), ncol = 18))

  for(i in 1:18) {
    temp <- vector(mode = "numeric", length = nrow(df))
    for(j in vars) {
      x <- ifelse(stringr::str_detect(string = df[[j]],
                                      pattern = as.character(i)), 1, 0)
      x[is.na(x)] <- 0
      temp <- temp + x
    }
    food[ , i] <- ifelse(temp > 0, 1, 0)
  }

  names(food) <- paste("food", 1:18, sep = "")
  ## Grains and tubers
  fg1 <- ifelse(rowSums(food[ , c("food1", "food2")]) > 0, 1, 0)
  ##
  fg2 <- ifelse(food[ , "food5"] > 0, 1, 0)
  ##
  fg3 <- ifelse(food[ , "food6"] > 0, 1, 0)
  ##
  fg4 <- ifelse(food[ , "food7"] > 0, 1, 0)
  ##
  fg5 <- ifelse(rowSums(food[ , c("food9", "food10")]) > 0, 1, 0)
  ##
  fg6 <- ifelse(food[ , "food11"] > 0, 1, 0)
  ##
  fg7 <- ifelse(food[ , "food12"] > 0, 1, 0)
  ##
  fg8 <- ifelse(rowSums(food[ , c("food3", "food4", "food13")]) > 0, 1, 0)
  ##
  fg9 <- ifelse(food[ , "food14"] > 0, 1, 0)
  ##
  fg10 <- ifelse(food[ , "food15"] > 0, 1, 0)
  ##
  fg <- fg1 + fg2 + fg3 + fg4 + fg5 + fg6 + fg7 + fg8 + fg9 + fg10
  ##
  mddw <- ifelse(fg >= 5, 1, 0)
  ##
  mddw <- data.frame(fg1, fg2, fg3, fg4, fg5,
                     fg6, fg7, fg8, fg9, fg10,
                     fg, mddw)
  ##
  return(mddw)
}
