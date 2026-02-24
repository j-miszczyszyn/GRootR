#' @title Root and Tree Level Metrics
#' @description Functions for aggregating segment metrics to root and tree level:
#'   total lengths, depth statistics, and depth classification.
#' @name root_metrics
NULL

#' Calculate total length per root
#'
#' Sums segment lengths within each ROOT_ID.
#'
#' @param df A data.frame with columns `ROOT_ID` and `length_3d`.
#'
#' @return The same data.frame with added column `total_length_root`.
#' @export
calc_root_length <- function(df) {
  totals <- stats::aggregate(length_3d ~ ROOT_ID, data = df, FUN = sum, na.rm = TRUE)
  names(totals)[2] <- "total_length_root"
  dplyr::left_join(df, totals, by = "ROOT_ID")
}

#' Calculate total root length per tree
#'
#' Sums segment lengths within each TREE_ID.
#'
#' @param df A data.frame with columns `TREE_ID` and `length_3d`.
#' @param tree_id_col Name of tree ID column. Default `"TREE_ID"`.
#'
#' @return The same data.frame with added column `total_length_tree`.
#' @export
calc_tree_length <- function(df, tree_id_col = "TREE_ID") {
  totals <- stats::aggregate(
    stats::as.formula(paste("length_3d ~", tree_id_col)),
    data = df, FUN = sum, na.rm = TRUE
  )
  names(totals)[2] <- "total_length_tree"
  dplyr::left_join(df, totals, by = tree_id_col)
}

#' Assign depth class
#'
#' Classifies each segment into depth bins based on the start point Z coordinate.
#'
#' @param df A data.frame with column `pZ`.
#' @param bin_m Bin width in meters. Default `0.2` (20 cm).
#'
#' @return The same data.frame with added column `depth_class` (in cm).
#' @export
assign_depth_class <- function(df, bin_m = 0.2) {
  bin_cm <- bin_m * 100
  df$depth_class <- floor(abs(df$pZ) / bin_m) * bin_cm
  df
}

#' Calculate depth statistics per tree
#'
#' Computes maximum depth, mean depth, and depth range for each tree.
#'
#' @param df A data.frame with columns `TREE_ID`, `pZ`, `kZ`.
#' @param tree_id_col Name of tree ID column. Default `"TREE_ID"`.
#'
#' @return A data.frame with one row per tree and columns:
#'   `depth_max`, `depth_mean`, `depth_range`.
#' @export
calc_depth_stats <- function(df, tree_id_col = "TREE_ID") {
  dplyr::group_by(df, .data[[tree_id_col]]) |>
    dplyr::summarise(
      depth_max   = min(c(.data$pZ, .data$kZ), na.rm = TRUE),
      depth_mean  = mean(c(.data$pZ, .data$kZ), na.rm = TRUE),
      depth_range = max(c(.data$pZ, .data$kZ), na.rm = TRUE) -
                    min(c(.data$pZ, .data$kZ), na.rm = TRUE),
      .groups = "drop"
    )
}

#' Count segment orientations per tree
#'
#' Counts vertical and horizontal segments for each tree.
#'
#' @param df A data.frame with columns `TREE_ID` and `orientation`.
#' @param tree_id_col Name of tree ID column. Default `"TREE_ID"`.
#'
#' @return A data.frame with columns `n_vertical` and `n_horizontal` per tree.
#' @export
count_orientations <- function(df, tree_id_col = "TREE_ID") {
  dplyr::group_by(df, .data[[tree_id_col]]) |>
    dplyr::summarise(
      n_vertical   = sum(.data$orientation == "vertical", na.rm = TRUE),
      n_horizontal = sum(.data$orientation == "horizontal", na.rm = TRUE),
      .groups = "drop"
    )
}
