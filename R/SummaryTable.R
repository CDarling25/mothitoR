#' Summary Table of average light sensor data
#'
#' @details This function takes in a time interval and will return a summary table for light data each day in the interval
#'
#' @author Molly Daniel
#' @import dplyr
#' @import knitr
#' @export
#' @param start
#' @param end
#' @param ... Additional arguments
#' @return returns a summary table and displays it
#' @examples
#' avg_light("2025-03-01", "2025-03-10")
avg_light <- function(
    # if no argument is passed in, use all dates as the default
    start = min(as.Date(substring(moon_light$UTC.Date...Time, 1, 10))),
    end = max(as.Date(substring(moon_light$UTC.Date...Time, 1, 10))), ...) {

  #creating new column to extract date from date and time
  date_data <- moon_light |> dplyr::mutate(date = as.Date(substring(UTC.Date...Time, 1, 10)))

  # filter the dates and make summary table
  summarized <- date_data |> filter(date >= as.Date(start) & date <= as.Date(end)) |>
    dplyr::group_by(date) |>
    dplyr::summarize(meanFreq = mean(Frequency),
                     meanMSAS = mean(MSAS))

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

