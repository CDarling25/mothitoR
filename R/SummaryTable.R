#' Summary Table of moon phase and light sensor data
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
#' moon_light_summary("")
moon_light_summary <- function(start, end, ...) {

  #creating new column to extract date from date and time
  date_data <- moon_light |> dplyr::mutate(date = as.Date(substring(YYYY.MM.DDTHH.mm.ss.fff, 1, 10)))

  summarized <- date_data |> filter(date >= as.Date(start) & date <= as.Date(end)) |>
    dplyr::group_by(date) |>
    dplyr::summarize(meanHz = mean(Hz),
                     meanMag = mean(mag.arcsec.2))

  knitr::kable(summarized, "simple")
}
