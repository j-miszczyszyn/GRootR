#' @title Load and Prepare Root Data
#' @description Functions for loading raw GPR root CSV data exported from
#'   software like ImpulseRadar, REFLEXW, or GPR-SLICE and preparing
#'   it for spatial analysis.
#' @name load
NULL

#' Load GPR root CSV file
#'
#' Reads a CSV file exported from GPR processing software. The file typically
#' has a metadata header row (e.g., Spatial Reference System info) followed
#' by column names and data. The root identifier column (`N.` by default)
#' is only filled in the first row of each root — subsequent rows are empty.
#' This function fills those gaps using last observation carried forward.
#'
#' @section Raw CSV structure:
#' A typical GPR export CSV looks like:
#' \preformatted{
#' Spatial Reference System:,EPSG:2178,ETRS89 / Poland CS2000 zone 7,...
#' N.,Type,Name,...,Node,X[SRS units],Y[SRS units],Depth[m],Altitude[m],Survey,...
#' 1,Pipe,Feature 0010,...,node1,7394244.316,5578579.578,0.202,-0.202,...
#' ,,,,,...,node2,7394245.057,5578579.786,0.202,-0.202,...
#' ,,,,,...,node3,7394245.455,5578580.134,0.202,-0.202,...
#' 2,Pipe,Feature 0011,...,node1,7394244.185,5578580.438,0.202,-0.202,...
#' }
#'
#' The first row contains CRS metadata (skipped via `skip`). The `N.` column
#' identifies each root but is only populated in the first node row ---
#' continuation rows are empty/NA.
#'
#' Note: GPR exports often have a trailing comma on data rows, which is
#' handled automatically.
#'
#' @param path Path to CSV file.
#' @param sep Column separator. Default `","`.
#' @param skip Number of header rows to skip before column names.
#'   Default `1` (skips the CRS metadata row).
#' @param root_id_col Name of the root identifier column. Default `"N."`.
#' @param root_id_name New name for the root ID column. Default `"ROOT_ID"`.
#'
#' @return A data.frame with a filled `ROOT_ID` column (integer).
#' @export
load_root_csv <- function(path, sep = ",", skip = 1,
                          root_id_col = "N.",
                          root_id_name = "ROOT_ID") {

  # Read raw lines, strip trailing commas and carriage returns
  lines <- readLines(path, warn = FALSE)
  lines <- sub("\\r$", "", lines)     # strip CR (Windows line endings)
  lines <- sub(",+$", "", lines)      # strip trailing comma(s)

  # Skip header rows
  if (skip > 0 && length(lines) > skip) {
    lines <- lines[(skip + 1):length(lines)]
  }

  df <- utils::read.csv(text = paste(lines, collapse = "\n"),
                        stringsAsFactors = FALSE,
                        check.names = FALSE)

  if (!root_id_col %in% names(df)) {
    stop(paste0("Column '", root_id_col, "' not found in CSV. ",
                "Available columns: ", paste(names(df), collapse = ", ")))
  }

  # Rename to ROOT_ID
  names(df)[names(df) == root_id_col] <- root_id_name

  # Convert to integer (suppress warning from empty string coercion)
  df[[root_id_name]] <- suppressWarnings(as.integer(df[[root_id_name]]))

  # Fill forward
  df[[root_id_name]] <- zoo::na.locf(df[[root_id_name]],
                                     na.rm = FALSE, fromLast = FALSE)

  df
}

#' Split survey column
#'
#' Splits a composite survey/filename column into parts by a separator
#' and extracts the plot identifier. The default format from GPR software
#' is e.g. `"Survey_2024.10.29_001_A_converted"` where the plot ID
#' is the 4th part (here: `"A"`).
#'
#' @param df A data.frame.
#' @param survey_col Name of the column to split. Default `"Survey"`.
#' @param sep Separator string. Default `"_"`.
#' @param plot_position Which part (after split) contains the plot ID.
#'   Default `4`.
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
#' by default so that below-surface values become negative Z coordinates.
#'
#' The default column names match the GPR export format:
#' `X[SRS units]`, `Y[SRS units]`, `Depth[m]`.
#'
#' @param df A data.frame.
#' @param x_col Name of the X coordinate column. Default `"X[SRS units]"`.
#' @param y_col Name of the Y coordinate column. Default `"Y[SRS units]"`.
#' @param z_col Name of the depth column. Default `"Depth[m]"`.
#' @param negate_z Negate depth values? Default `TRUE` (depth becomes negative).
#' @param drop_original Drop original columns after conversion? Default `TRUE`.
#'
#' @return A data.frame with numeric `X`, `Y`, `Z` columns.
#' @export
convert_coordinates <- function(df, x_col = "X[SRS units]",
                                y_col = "Y[SRS units]",
                                z_col = "Depth[m]",
                                negate_z = TRUE,
                                drop_original = TRUE) {
  for (col in c(x_col, y_col, z_col)) {
    if (!col %in% names(df)) {
      stop(paste0("Column '", col, "' not found. ",
                  "Available columns: ", paste(names(df), collapse = ", ")))
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
