################################################################################
#
#' Function to calculate any of the domains of the Washington Group on
#' Disability indicators.
#'
#' @param df Dataframe containing Washington Group on Disability domain-specific
#'   variables.
#' @param domain Variable name of domain-specific Washington Group on Disability
#'   indicator.
#'
#' @return A dataframe of domain-specific Washington Group on Disability
#'   indicators.
#'
#' @examples
#'
#' calculate_domain(df = individual, domain = "wg1")
#'
#' @export
#'
#
################################################################################

calculate_domain <- function(df, domain) {
  d0 <- ifelse(df[[domain]] == 1, 1, 0)
  d1 <- ifelse(df[[domain]] %in% 2:4, 1, 0)
  d2 <- ifelse(df[[domain]] %in% 3:4, 1, 0)
  d3 <- ifelse(df[[domain]] == 4, 1, 0)
  wg <- data.frame(d0, d1, d2, d3)
  names(wg) <- paste(domain, names(wg), sep = ".")
  return(wg)
}


################################################################################
#
#' Function to calculate all domains and overall Washington Group on Disability
#'
#' @param df Dataframe containing Washington Group on Disability domain-specific
#'   variables.
#'
#' @return A dataframe of recoded domain-specific and overall Washington Group
#'   on Disability values.
#'
#' @examples
#'
#' calculate_wg(df = individual)
#'
#' @export
#'
#
################################################################################

calculate_wg <- function(df) {
  p <- data.frame(matrix(data = NA, nrow = nrow(df), ncol = 24))

  pNames <- NULL

  for(i in paste("wg", 1:6, sep = "")) {
    pNames <- c(pNames, paste(i, ".d", 0:3, sep = ""))
  }

  names(p) <- pNames

  for(i in paste("wg", 1:6, sep = "")) {
    x <- calculate_domain(df = df, domain = i)
    p[ , names(x)] <- x
  }

  p0 <- ifelse(rowSums(p[ , c("wg1.d0", "wg2.d0", "wg3.d0",
                              "wg4.d0", "wg5.d0", "wg6.d0")]) == 6, 1, 0)

  p1 <- ifelse(rowSums(p[ , c("wg1.d1", "wg2.d1", "wg3.d1",
                              "wg4.d1", "wg5.d1", "wg6.d1")]) >= 1, 1, 0)

  p2 <- ifelse(rowSums(p[ , c("wg1.d2", "wg2.d2", "wg3.d2",
                              "wg4.d2", "wg5.d2", "wg6.d2")]) >= 1, 1, 0)

  p3 <- ifelse(rowSums(p[ , c("wg1.d3", "wg2.d3", "wg3.d3",
                              "wg4.d3", "wg5.d3", "wg6.d3")]) >= 1, 1, 0)

  pm <- ifelse(rowSums(p[ , c("wg1.d1", "wg2.d1", "wg3.d1",
                              "wg4.d1", "wg5.d1", "wg6.d1")]) >= 2, 1, 0)

  wg <- data.frame(p, p0, p1, p2, p3, pm)

  return(wg)
}
