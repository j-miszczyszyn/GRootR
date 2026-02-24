#' @title Join Roots with Tree Locations
#' @description Functions for spatially joining root segments with tree stem
#'   positions and propagating tree identity to all segments of the same root.
#' @name trees
NULL

#' Join root segments to nearest tree
#'
#' Performs a spatial join between root segments and tree point locations,
#' matching within a given distance threshold.
#'
#' @param roots An sf object with root segments.
#' @param trees An sf point object with tree locations. Must contain a
#'   column identifying each tree.
#' @param tree_id_col Name of the tree identifier column in `trees`.
#'   Default `"TREE_ID"`.
#' @param max_dist Maximum distance (in CRS units) for the join. Default `1.5`.
#'
#' @return An sf object with the tree identifier joined to matching segments.
#' @export
join_nearest_tree <- function(roots, trees, tree_id_col = "TREE_ID",
                              max_dist = 1.5) {
  if (!tree_id_col %in% names(trees)) {
    stop(paste0("Column '", tree_id_col, "' not found in trees data."))
  }

  # Ensure same CRS
  if (sf::st_crs(roots) != sf::st_crs(trees)) {
    trees <- sf::st_transform(trees, sf::st_crs(roots))
  }

  # Keep only ID + geometry from trees
  trees_slim <- trees[, c(tree_id_col, "geometry")]

  sf::st_join(roots, trees_slim, join = sf::st_is_within_distance, dist = max_dist)
}

#' Propagate tree name to all segments of the same root
#'
#' After spatial join, only segments near the tree base get the tree ID.
#' This function propagates the tree ID to ALL segments sharing the same ROOT_ID.
#'
#' @param joined An sf object from [join_nearest_tree()], containing
#'   `ROOT_ID` and a tree ID column (possibly with NAs).
#' @param tree_id_col Name of the tree identifier column. Default `"TREE_ID"`.
#'
#' @return An sf object where all segments of a root share the same tree ID.
#'   Roots with no matched tree are removed.
#' @export
propagate_tree_name <- function(joined, tree_id_col = "TREE_ID") {
  if (!tree_id_col %in% names(joined)) {
    stop(paste0("Column '", tree_id_col, "' not found."))
  }

  # Build lookup: ROOT_ID -> TREE_ID (non-NA, non-empty)
  lookup <- sf::st_drop_geometry(joined)[, c("ROOT_ID", tree_id_col)]
  lookup <- lookup[!is.na(lookup[[tree_id_col]]) & lookup[[tree_id_col]] != "", ]
  lookup <- unique(lookup)

  # Remove tree_id column, then rejoin — sf left_join preserves geometry
  joined[[tree_id_col]] <- NULL
  joined <- dplyr::left_join(joined, lookup, by = "ROOT_ID")

  # Keep only roots that matched a tree
  joined <- joined[!is.na(joined[[tree_id_col]]), ]

  joined
}
