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

  data <- moon_light |> filter(Date >= start_date & Date <= end_date)

  average_light <- data |>
    dplyr::group_by(Date) |>
    dplyr::summarize(mean_light = mean(Frequency), .groups = "drop")

  plot <- average_light |>
    ggplot(aes(x = Date, y = mean_light)) +
    geom_bar(stat = "identity") +
    labs(x = "Date", y = "Average Hz detected each day")

  plot
}

