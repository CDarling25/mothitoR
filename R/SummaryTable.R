#' Summary Table of average light sensor data
#'
#' @details This function takes in a time interval and will return a summary table for light data each day in the interval
#'
#' @author Molly Daniel
#' @import dplyr
#' @import knitr
#' @import sqldf
#' @export
#' @param start
#' @param end
#' @param ... Additional arguments
#' @return returns a summary table and displays it
#' @examples
#' avg_light("2025-03-01", "2025-03-10")
avg_light <- function(
    # if no argument is passed in, use all dates as the default
    start = min(moon_light$Date),
    end = max(moon_light$Date)) {

  query <- paste0(
    "SELECT Date, avg(Frequency) AS meanFreq, avg(MSAS) AS meanMSAS ",
    "FROM moon_light ",
    "WHERE Date >= '", start, "' AND Date <= '", end, "' ",
    "GROUP BY Date"
  )

  summarized <- sqldf::sqldf(query)
  knitr::kable(summarized, "simple")
}

#' Summary Table of moon metric and light sensor data
#'
#' @details This function returns general data about how light varies depending on moon metrics
#'
#' @author Molly Daniel
#' @import dplyr
#' @import knitr
#' @param metric Category, Area, Phase - passed in without quotes
#' @export
#' @return returns a summary table and displays it
#' @examples
#' light_by_moon_phase()
light_by_moon <- function(metric = Category){
  # find summary statistics
  summarized <- moon_light |>
    dplyr::group_by({{metric}}) |>
    dplyr::summarise(minFreq = min(Frequency),
                     maxFreq = max(Frequency),
                     avgFreq = mean(Frequency),
                     minMSAS = min(MSAS),
                     maxMSAS = max(MSAS),
                     avgMSAS = mean(MSAS))

  # make the table
  knitr::kable(summarized, "simple")
}

