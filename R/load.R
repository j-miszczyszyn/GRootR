#' @title Load and Prepare Root Data
#' @description Functions for loading raw GPR root CSV data and preparing
#'   it for spatial analysis.
#' @name load
NULL

#' Load root CSV file
#'
#' Reads a CSV file with root point data and fills missing ROOT_ID values
#' using last observation carried forward.
#'
#' @param path Path to CSV file.
#' @param sep Column separator. Default `";"` (csv2 format).
#' @param root_id_col Name of the root identifier column. Default `"ROOT_ID"`.
#'
#' @return A data.frame with filled ROOT_ID.
#' @export
load_root_csv <- function(path, sep = ";", root_id_col = "ROOT_ID") {
  if (sep == ";") {
    df <- utils::read.csv2(path, stringsAsFactors = FALSE)
  } else {
    df <- utils::read.csv(path, sep = sep, stringsAsFactors = FALSE)
  }

  if (!root_id_col %in% names(df)) {
    stop(paste0("Column '", root_id_col, "' not found in CSV."))
  }

  df[[root_id_col]] <- as.integer(df[[root_id_col]])
  df[[root_id_col]] <- zoo::na.locf(df[[root_id_col]], na.rm = FALSE, fromLast = FALSE)

  df
}

#' Split survey column
#'
#' Splits a composite survey/filename column into parts by a separator
#' and extracts the plot identifier.
#'
#' @param df A data.frame.
#' @param survey_col Name of the column to split. Default `"Survey"`.
#' @param sep Separator string. Default `"_"`.
#' @param plot_position Which part (after split) contains the plot ID. Default `4`.
#' @param plot_name Name for the new plot column. Default `"PLOT_ID"`.
#' @param drop_original Drop the original survey column? Default `TRUE`.
#'
#' @return A data.frame with a new plot column.
#' @export
split_survey_column <- function(df, survey_col = "Survey", sep = "_",
                                plot_position = 4, plot_name = "PLOT_ID",
                                drop_original = TRUE) {
  if (!survey_col %in% names(df)) {
    stop(paste0("Column '", survey_col, "' not found."))
  }

  parts <- strsplit(df[[survey_col]], sep, fixed = TRUE)
  df[[plot_name]] <- vapply(parts, function(x) {
    if (length(x) >= plot_position) x[plot_position] else NA_character_
  }, character(1))

  if (drop_original) {
    df[[survey_col]] <- NULL
  }

  df
}

#' Convert coordinate columns to numeric
#'
#' Converts X, Y, Z (depth) columns to numeric values. Depth is negated
#' so that below-surface values are negative.
#'
#' @param df A data.frame.
#' @param x_col Name of the X coordinate column.
#' @param y_col Name of the Y coordinate column.
#' @param z_col Name of the depth column.
#' @param negate_z Negate depth values? Default `TRUE` (depth becomes negative).
#' @param drop_original Drop original columns after conversion? Default `TRUE`.
#'
#' @return A data.frame with numeric `X`, `Y`, `Z` columns.
#' @export
convert_coordinates <- function(df, x_col = "X.SRS.units.",
                                y_col = "Y.SRS.units.",
                                z_col = "Depth.m.",
                                negate_z = TRUE,
                                drop_original = TRUE) {
  for (col in c(x_col, y_col, z_col)) {
    if (!col %in% names(df)) {
      stop(paste0("Column '", col, "' not found."))
    }
  }

  df$X <- as.numeric(df[[x_col]])
  df$Y <- as.numeric(df[[y_col]])
  df$Z <- as.numeric(df[[z_col]])

  if (negate_z) df$Z <- -df$Z

  if (drop_original) {
    df[[x_col]] <- NULL
    df[[y_col]] <- NULL
    df[[z_col]] <- NULL
  }

  df
}
