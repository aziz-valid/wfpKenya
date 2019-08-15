################################################################################
#
#' Codebook for full raw dataset from WFP Kenya CSP outcome monitoring
#' survey
#'
#' @format A data.frame with 1161 rows and 3 columns.
#'
#' \describe{
#' \item{\code{variable}}{Variable name}
#' \item{\code{question}}{Question/variable description}
#' \item{\code{choices}}{Choice of responses}
#' }
#'
#
################################################################################
"codebook"

################################################################################
#
#' Raw household dataset from WFP Kenya CSP outcome monitoring survey
#'
#' @format A data.frame with 658 columns and 3036 rows of per household
#'   observations.
#'
#' @source WFP Kenya CSP outcome monitoring survey data collection from
#'   15-29 August 2019
#'
#'
#
################################################################################
"household"

################################################################################
#
#' Codebook for raw household dataset from WFP Kenya CSP outcome monitoring
#' survey
#'
#' @format A data.frame with 649 rows and 3 columns.
#'
#' \describe{
#' \item{\code{variable}}{Variable name}
#' \item{\code{question}}{Question/variable description}
#' \item{\code{choices}}{Choice of responses}
#' }
#'
#
################################################################################
"codebookHousehold"


################################################################################
#
#' Raw roster dataset from WFP Kenya CSP outcome monitoring survey
#'
#' @format A data.frame with 16518 rows and 39 columns
#'
#' @source WFP Kenya CSP outcome monitoring survey data collection from
#'   15-29 August 2019
#'
#
################################################################################
"roster"


################################################################################
#
#' Codebook for raw roster dataset from WFP Kenya CSP outcome monitoring
#' survey
#'
#' @format A data.frame with 28 rows and 3 columns
#' \describe{
#' \item{\code{variable}}{Variable name}
#' \item{\code{question}}{Question/variable description}
#' \item{\code{choices}}{Choice of responses}
#' }
#'
#
################################################################################
"codebookRoster"


################################################################################
#
#' Raw individual dataset from WFP Kenya CSP outcome monitoring survey
#'
#' @format A data.frame with 4920 rows and 159 columns
#'
#' @source WFP Kenya CSP outcome monitoring survey data collection from
#'   15-29 August 2019
#'
#
################################################################################
"individual"


################################################################################
#
#' Codebook for raw individual dataset from WFP Kenya CSP outcome monitoring
#' survey
#'
#' @format A data.frame with 97 rows and 3 columns
#'
#' \describe{
#' \item{\code{variable}}{Variable name}
#' \item{\code{question}}{Question/variable description}
#' \item{\code{choices}}{Choice of responses}
#' }
#'
#
################################################################################
"codebookIndividual"


################################################################################
#
#' Primary sampling unit population dataset
#'
#' @format A data.frame with 203 rows and 2 columns.
#'
#' \describe{
#' \item{\code{psu}}{Primary sampling unit; Village identifier}
#' \item{\code{pop}}{Village population size}
#' }
#'
#' @source WFP Kenya CSP outcome monitoring survey data collection from
#'   15-29 August 2019
#'
#
################################################################################
"psuData"


################################################################################
#
#' Raw community dataset from WFP Kenya CSP outcome monitoring survey
#'
#' @format A data.frame with 203 rows and 25 columns
#'
#' @source WFP Kenya CSP outcome monitoring survey data collection from
#'   15-29 August 2019
#'
#
################################################################################
"community"


################################################################################
#
#' Codebook for raw community dataset from WFP Kenya CSP outcome monitoring
#' survey
#'
#' @format A data.frame with 13 rows and 3 columns
#'
#' \describe{
#' \item{\code{variable}}{Variable name}
#' \item{\code{question}}{Question/variable description}
#' \item{\code{choices}}{Choice of responses}
#' }
#'
#
################################################################################
"codebookCommunity"

################################################################################
#
#' Self-evaluated Resilience Score (SERS) indicator dataset
#'
#' @format A data.frame with 4920 rows and 19 columns
#'
#' \describe{
#' \item{\code{psu}}{Primary sampling unit or village identifier}
#' \item{\code{hhid}}{Household identifier}
#' \item{\code{sex}}{Sex of respondent; 1 = Male; 2 = Female}
#' \item{\code{age}}{Age of respondent in years}
#' \item{\code{respondent}}{Respondent type; 1 = head; 2 = spouse of head;
#'   3 = male youth household member; 4 = female youth household member}
#' \item{\code{studyGroup}}{Study group; 1 = intervention; 2 = control}
#' \item{\code{lhz}}{Livelihood zone}
#' \item{\code{sers1}}{SERS dimension 1}
#' \item{\code{sers2}}{SERS dimension 2}
#' \item{\code{sers3}}{SERS dimension 3}
#' \item{\code{sers4}}{SERS dimension 4}
#' \item{\code{sers5}}{SERS dimension 5}
#' \item{\code{sers6}}{SERS dimension 6}
#' \item{\code{sers7}}{SERS dimension 7}
#' \item{\code{sers8}}{SERS dimension 8}
#' \item{\code{sers9}}{SERS dimension 9}
#' \item{\code{sers10}}{SERS dimension 10}
#' \item{\code{score}}{SERS total score}
#' \item{\code{resilience}}{Is household resilient (score is 1)?
#'   1 = yes; 2 = no}
#' }
#'
#' @source WFP Kenya CSP outcome monitoring survey data collection from
#'   15-29 August 2019
#'
#
################################################################################
"sers"


################################################################################
#
#' Washington Group Disability indicators dataset
#'
#' @format A data.frame with 4920 rows and 36 columns
#'
#' \describe{
#' \item{\code{psu}}{Primary sampling unit or village identifier}
#' \item{\code{hhid}}{Household identifier}
#' \item{\code{sex}}{Sex of respondent; 1 = Male; 2 = Female}
#' \item{\code{age}}{Age of respondent in years}
#' \item{\code{respondent}}{Respondent type; 1 = head; 2 = spouse of head;
#'   3 = male youth household member; 4 = female youth household member}
#' \item{\code{studyGroup}}{Study group; 1 = intervention; 2 = control}
#' \item{\code{lhz}}{Livelihood zone}
#' \item{\code{wg1.d0}}{No visual disability}
#' \item{\code{wg1.d1}}{Has any visual disability}
#' \item{\code{wg1.d2}}{Has moderate or severe visual disability}
#' \item{\code{wg1.d3}}{Has severe visual disability}
#' \item{\code{wg2.d0}}{No hearing disability}
#' \item{\code{wg2.d1}}{Has any hearing disability}
#' \item{\code{wg2.d2}}{Has moderate or severe hearing disability}
#' \item{\code{wg2.d3}}{Has severe hearing disability}
#' \item{\code{wg3.d0}}{Has walking disability}
#' \item{\code{wg3.d1}}{Has any walking disability}
#' \item{\code{wg3.d2}}{Has moderate or severe walking disability}
#' \item{\code{wg3.d3}}{Has severe walking disability}
#' \item{\code{wg4.d0}}{Has cognitive disability}
#' \item{\code{wg4.d1}}{Has any cognitive disability}
#' \item{\code{wg4.d2}}{Has moderate or severe cognitive disability}
#' \item{\code{wg4.d3}}{Has severe cognitive disability}
#' \item{\code{wg5.d0}}{Has self-care disability}
#' \item{\code{wg5.d1}}{Has any self-care disability}
#' \item{\code{wg5.d2}}{Has moderate or severe self-care disability}
#' \item{\code{wg5.d3}}{Has severe self-care disability}
#' \item{\code{wg6.d0}}{Has language disability}
#' \item{\code{wg6.d1}}{Has any language disability}
#' \item{\code{wg6.d2}}{Has moderate or severe language disability}
#' \item{\code{wg6.d3}}{Has severe language disability}
#' \item{\code{p0}}{No disability in any domain}
#' \item{\code{p1}}{At least one dimension with disability}
#' \item{\code{p2}}{At least one dimension with moderate to severe disability}
#' \item{\code{p3}}{At least one dimension with severe disability}
#' \item{\code{pm}}{If more than one dimension has disability}
#' }
#'
#' @source WFP Kenya CSP outcome monitoring survey data collection from
#'   15-29 August 2019
#'
#
################################################################################
"wg"
