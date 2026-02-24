#' @title Root-to-Trunk Distance
#' @description Functions for merging root segments and computing
#'   the distance from each root to its parent tree trunk.
#' @name distance
NULL

#' Merge root segments into single geometries
#'
#' Unions all line segments belonging to the same ROOT_ID into one geometry.
#'
#' @param root_sf An sf object with root segments and columns `ROOT_ID`, `TREE_ID`.
#' @param tree_id_col Name of tree ID column. Default `"TREE_ID"`.
#'
#' @return An sf object with one row per ROOT_ID, with unioned geometry.
#' @export
merge_root_segments <- function(root_sf, tree_id_col = "TREE_ID") {
  dplyr::group_by(root_sf, .data$ROOT_ID, .data[[tree_id_col]]) |>
    dplyr::summarise(geometry = sf::st_union(.data$geometry), .groups = "drop")
}

#' Calculate distance from each root to its tree trunk
#'
#' For each root, computes the minimum distance between the root geometry
#' and the corresponding tree stem point.
#'
#' @param roots_merged An sf object from [merge_root_segments()].
#' @param tree_points An sf point object with tree locations and a tree ID column.
#' @param tree_id_col Name of tree ID column. Default `"TREE_ID"`.
#'
#' @return The input `roots_merged` with an added column `dist_to_trunk`.
#' @export
calc_dist_to_trunk <- function(roots_merged, tree_points,
                               tree_id_col = "TREE_ID") {
  # Ensure same CRS
  if (sf::st_crs(roots_merged) != sf::st_crs(tree_points)) {
    tree_points <- sf::st_transform(tree_points, sf::st_crs(roots_merged))
  }

  roots_merged$dist_to_trunk <- NA_real_

  for (i in seq_len(nrow(roots_merged))) {
    tid <- roots_merged[[tree_id_col]][i]
    tree_row <- tree_points[tree_points[[tree_id_col]] == tid, ]

    if (nrow(tree_row) == 0) next

    roots_merged$dist_to_trunk[i] <- as.numeric(
      sf::st_distance(roots_merged$geometry[i], tree_row$geometry[1])
    )
  }

  roots_merged
}
