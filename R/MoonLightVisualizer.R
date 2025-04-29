#' Visual Analysis of moon phase and light sensor data
#'
#' @details This function takes in a desired start date and will return a visualization for a week's worth of data
#'
#' @author Cameron Darling
#' @export
#' @import dplyr
#' @import ggplot2
#' @param start_date The desired start date of visual analysis
#' @param ... Additional arguments
#' @return returns a graph and displays it
#' @examples
#' moon_light_visual("")
moon_light_visual <- function(start_date, ...) {

  #creating new column to extract date from date and time
  date_data <- moon_light |> dplyr::mutate(date = substring(YYYY.MM.DDTHH.mm.ss.fff, 1, 10))

  average_light <- date_data |>
    dplyr::group_by(date) |>
    dplyr::summarize(mean_light = mean(Hz), .groups = "drop",
                     moon_phase = mean(Category))

  glimpse(average_light)
}

