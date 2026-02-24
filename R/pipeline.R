#' @title Processing Pipelines
#' @description High-level wrapper functions that chain individual steps
#'   into common workflows.
#' @name pipeline
NULL

#' Load and prepare root data from CSV
#'
#' Convenience wrapper that loads a GPR export CSV, fills ROOT_IDs,
#' optionally splits the survey column, and converts coordinates.
#'
#' @param path Path to CSV file.
#' @param sep CSV separator. Default `","`.
#' @param skip Number of header rows to skip. Default `1` (CRS metadata row).
#' @param root_id_col Name of the root identifier column in raw CSV.
#'   Default `"N."`.
#' @param x_col,y_col,z_col Names of coordinate columns.
#' @param negate_z Negate Z values? Default `TRUE`.
#' @param survey_col Name of survey column to split, or `NULL` to skip.
#' @param plot_position Position of plot ID in split survey. Default `4`.
#'
#' @return A cleaned data.frame ready for segment processing.
#' @export
prepare_root_data <- function(path, sep = ",", skip = 1,
                              root_id_col = "N.",
                              x_col = "X[SRS units]",
                              y_col = "Y[SRS units]",
                              z_col = "Depth[m]",
                              negate_z = TRUE,
                              survey_col = "Survey",
                              plot_position = 4) {
  df <- load_root_csv(path, sep = sep, skip = skip,
                      root_id_col = root_id_col)

  if (!is.null(survey_col) && survey_col %in% names(df)) {
    df <- split_survey_column(df, survey_col = survey_col,
                              plot_position = plot_position)
  }

  df <- convert_coordinates(df, x_col = x_col, y_col = y_col,
                            z_col = z_col, negate_z = negate_z)
  df
}

#' Full segment pipeline
#'
#' Processes raw root data into segments with all geometric metrics.
#'
#' @param df A prepared data.frame from [prepare_root_data()].
#' @param crs EPSG code. Default `2178`.
#' @param verbose Print progress? Default `TRUE`.
#'
#' @return An sf object with segments and all metric columns.
#' @export
build_segments_with_metrics <- function(df, crs = 2178, verbose = TRUE) {
  segments <- process_all_roots(df, crs = crs, verbose = verbose)
  if (is.null(segments)) stop("No segments could be created.")
  calc_all_segment_metrics(segments)
}

#' Tree-level summary pipeline
#'
#' Given segments joined with tree IDs, computes per-tree summaries:
#' lengths, depth stats, orientation counts, convex hulls, areas, and 3D volume.
#'
#' @param df A data.frame of segments with `TREE_ID`, `pX`, `pY`, `pZ`,
#'   `kX`, `kY`, `kZ`, `length_3d`, `orientation`.
#' @param tree_id_col Name of tree ID column. Default `"TREE_ID"`.
#' @param crs EPSG code. Default `2178`.
#'
#' @return A list with components:
#'   \describe{
#'     \item{depth}{Depth statistics per tree.}
#'     \item{orientations}{Orientation counts per tree.}
#'     \item{hulls}{Convex hull sf with area and extent.}
#'     \item{volume}{3D volume estimates per tree.}
#'   }
#' @export
summarise_tree_roots <- function(df, tree_id_col = "TREE_ID", crs = 2178) {
  depth <- calc_depth_stats(df, tree_id_col = tree_id_col)
  orient <- count_orientations(df, tree_id_col = tree_id_col)

  hulls <- build_convex_hulls(df, tree_id_col = tree_id_col, crs = crs)
  hulls <- calc_hull_area(hulls)

  real_z <- calc_real_z(df, tree_id_col = tree_id_col)
  vol <- calc_range_3d(real_z, hulls, tree_id_col = tree_id_col)

  list(
    depth = depth,
    orientations = orient,
    hulls = hulls,
    volume = vol
  )
}
