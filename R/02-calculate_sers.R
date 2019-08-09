################################################################################
#
#' Function to calculate Self-evaluated Resiliency Score (SERS)
#'
#' @param df Data.frame containing SERS-related variables
#' @param keep.na Logical. Apply recoding to NA responses? If TRUE (default),
#'   NA responses will be recoded based on \code{response}. If FALSE, score
#'   will be NA.
#' @param response What response to recode NA values. \code{1} for best
#'   possible response; \code{5} for worst possible response; \code{3} for
#'   neutral respnose. Default is \code{3}. Ignored when \code{keep.na} FALSE.
#' @param add Logical. Should the calculated SERS values be added to \code{df}?
#'   If TRUE, SERS scores will be concatenated to \code{df} using \code{cbind}.
#'   Default is FALSE.
#'
#' @return If \code{add} is TRUE, a data.frame made out of a column binding of
#'   \code{df} and the calculated per dimension and overall SERS. If \code{add}
#'   is FALSE, a SERS data.frame containing per dimension and overall SERS.
#'
#' @examples
#'
#' calculate_sers(df = individual)
#'
#' @export
#'
#
################################################################################

calculate_sers <- function(df, keep.na = TRUE, response = 3, add = FALSE) {

  temp <- apply(X = df[ , paste("sers", 1:10, sep = "")],
                MARGIN = 2,
                FUN = function(x) ifelse(x %in% c(88, 99), NA, x))

  if(keep.na) {
    ## Recode refused to answer or don't know
    temp <- apply(X = df[ , paste("sers", 1:10, sep = "")],
                  MARGIN = 2,
                  FUN = function(x) ifelse(x %in% c(88, 99), response, x))
  }

  sers <- apply(X = temp, MARGIN = 2, FUN = function(x) x * 0.2)
  score <- rowSums(sers)
  sers <- data.frame(sers, score)

  if(add) data.frame(df, sers) else
    return(sers)
}
