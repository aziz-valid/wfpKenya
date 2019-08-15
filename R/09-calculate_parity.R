################################################################################
#
#' Function to calculate Gender Parity index per dimension indicators of the
#' Abbreviated Women's Empowerment in Agriculture Index (A-WEAI).
#'
#' @param df Dataframe containing recoded A-WEAI dimension indicators.
#'
#' @return A list of two dataframes for gender gap for full sample and for
#'   youth sample for each of the WEAI dimension indicators.
#'
#' @examples
#'
#' calculate_gpi(df = individual)
#'
#' @export
#
################################################################################

calculate_gpi <- function(df) {

  df <- data.frame(df[ , c("KEY", "sex", "hh_member_age", "respondent")],
                   production = calculate_production(df = df),
                   resources = calculate_resources(df = df),
                   credit = calculate_credit(df = df),
                   group = calculate_group(df = df))

  g1 <- subset(df, sex == 1 & respondent %in% 1:2)
  g2 <- subset(df, sex == 2 & respondent %in% 1:2)
  g3 <- subset(df, sex == 1 & hh_member_age %in% 18:35)
  g4 <- subset(df, sex == 2 & hh_member_age %in% 18:35)

  gMain <- merge(g1, g2, by = "KEY", all = TRUE)
  gYouth <- merge(g3, g4, by = "KEY", all = TRUE)

  pMainGap <- ifelse(rowSums(gMain[ , c("production.x",
                                        "production.y")]) == 1, 1, 0)
  pYouthGap <- ifelse(rowSums(gYouth[ , c("production.x",
                                          "production.y")]) == 1, 1, 0)

  rMainGap <- ifelse(rowSums(gMain[ , c("resources.x",
                                        "resources.y")]) == 1, 1, 0)
  rYouthGap <- ifelse(rowSums(gYouth[ , c("resources.x",
                                          "resources.y")]) == 1, 1, 0)

  cMainGap <- ifelse(rowSums(gMain[ , c("credit.x",
                                        "credit.y")]) == 1, 1, 0)
  cYouthGap <- ifelse(rowSums(gYouth[ , c("credit.x",
                                          "credit.y")]) == 1, 1, 0)

  gMainGap <- ifelse(rowSums(gMain[ , c("group.x",
                                        "group.y")]) == 1, 1, 0)
  gYouthGap <- ifelse(rowSums(gYouth[ , c("group.x",
                                          "group.y")]) == 1, 1, 0)

  mainGap <- data.frame(pMainGap, rMainGap, cMainGap, gMainGap)
  names(mainGap) <- c("production", "resources", "credit", "group")

  youthGap <- data.frame(pYouthGap, rYouthGap, cYouthGap, gYouthGap)
  names(youthGap) <- c("production", "resources", "credit", "group")

  gap <- list(mainGap, youthGap)
  names(gap) <- c("main", "youth")

  return(gap)
}
