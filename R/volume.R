#' @title 3D Root System Volume
#' @description Functions for estimating the 3D bounding volume of root systems
#'   based on depth range and 2D area.
#' @name volume
NULL

#' Calculate real vertical range per tree
#'
#' Computes the true vertical extent of the root system as the difference
#' between the shallowest and deepest points.
#'
#' @param df A data.frame with columns `TREE_ID`, `pZ`, `kZ`.
#' @param tree_id_col Name of tree ID column. Default `"TREE_ID"`.
#'
#' @return A data.frame with one row per tree and column `real_z`.
#' @export
calc_real_z <- function(df, tree_id_col = "TREE_ID") {
  dplyr::group_by(df, .data[[tree_id_col]]) |>
    dplyr::summarise(
      z_min  = min(c(.data$pZ, .data$kZ), na.rm = TRUE),
      z_max  = max(c(.data$pZ, .data$kZ), na.rm = TRUE),
      real_z = .data$z_max - .data$z_min,
      .groups = "drop"
    )
}

#' Calculate 3D bounding volume
#'
#' Estimates root system volume as the product of vertical range (real_z)
#' and 2D convex hull area (area_2d).
#'
#' @param depth_df A data.frame with columns `TREE_ID` and `real_z`,
#'   as returned by [calc_real_z()].
#' @param hull_df An sf or data.frame with columns `TREE_ID` and `area_2d`,
#'   as returned by [calc_hull_area()].
#' @param tree_id_col Name of tree ID column. Default `"TREE_ID"`.
#'
#' @return A data.frame with columns `TREE_ID`, `real_z`, `area_2d`, `range_3d`.
#' @export
calc_range_3d <- function(depth_df, hull_df, tree_id_col = "TREE_ID") {
  hull_data <- if (inherits(hull_df, "sf")) sf::st_drop_geometry(hull_df) else hull_df

  merged <- dplyr::left_join(
    depth_df[, c(tree_id_col, "real_z")],
    hull_data[, c(tree_id_col, "area_2d")],
    by = tree_id_col
  )

  merged$range_3d <- merged$real_z * merged$area_2d
  merged
}
