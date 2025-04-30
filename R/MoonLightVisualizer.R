#' Visual Analysis of moon phase and light sensor data
#'
#' @details This function visualizes the average Hz
#'
#' @author Cameron Darling
#' @export
#' @import dplyr
#' @import ggplot2
#' @param start_date The desired start date of visual analysis
#' @param end_date The desired end date of visual analysis
#' @param ... Additional arguments
#' @return returns a graph and displays it
#' @examples
#' moon_light_visual("2025-03-10")
moon_light_visual <- function(start_date, end_date, ...) {

  #creating new column to extract date from date and time
  date_data <- moon_light |> dplyr::mutate(date = substring(YYYY.MM.DDTHH.mm.ss.fff, 1, 10))

  date_data <- date_data |> filter(date >= start_date & date <= end_date)

  average_light <- date_data |>
    dplyr::group_by(date) |>
    dplyr::summarize(mean_light = mean(Hz), .groups = "drop",
                     moon_phase = mean(Category))

  plot <- average_light |>
    ggplot(aes(x = date, y = mean_light)) +
    geom_bar(stat = "identity") +
    labs(x = "Date", y = "Average Hz detected each day")

  plot
}

