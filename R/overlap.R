#' @title Root System Overlap Analysis
#' @description Functions for computing spatial overlap between root systems
#'   of different trees, estimating competition for belowground space.
#' @name overlap
NULL

#' Generate unique tree pairs
#'
#' Creates all unique pairwise combinations of tree indices for overlap analysis.
#'
#' @param n Number of trees.
#'
#' @return A 2-row matrix where each column is a pair of indices.
#' @export
make_tree_pairs <- function(n) {
  if (n < 2) stop("Need at least 2 trees for pairwise comparison.")
  utils::combn(n, 2)
}

#' Calculate overlap between two geometries
#'
#' Computes the intersection area and overlap percentages between
#' two polygon geometries.
#'
#' @param geom_a An sf geometry (sfc) object.
#' @param geom_b An sf geometry (sfc) object.
#'
#' @return A list with `overlap_area`, `pct_a` (% of A covered), and
#'   `pct_b` (% of B covered), or NULL if no overlap.
#' @export
calc_pair_overlap <- function(geom_a, geom_b) {
  inter <- sf::st_intersection(geom_a, geom_b)

  if (length(inter) == 0 || sf::st_is_empty(inter)[1]) {
    return(NULL)
  }

  area_inter <- as.numeric(sf::st_area(inter))
  area_a <- as.numeric(sf::st_area(geom_a))
  area_b <- as.numeric(sf::st_area(geom_b))

  list(
    overlap_area = area_inter,
    pct_a = 100 * area_inter / area_a,
    pct_b = 100 * area_inter / area_b
  )
}

#' Calculate all pairwise root system overlaps
#'
#' Computes overlap statistics for all pairs of trees in a convex hull dataset.
#'
#' @param hulls An sf object with convex hull polygons. Must have a tree ID column.
#' @param tree_id_col Name of tree ID column. Default `"TREE_ID"`.
#' @param digits Number of decimal places to round. Default `2`.
#'
#' @return A data.frame with columns: `tree_1`, `tree_2`, `overlap_area`,
#'   `overlap_pct_tree1`, `overlap_pct_tree2`. Rows with zero overlap are excluded.
#' @export
calc_all_overlaps <- function(hulls, tree_id_col = "TREE_ID", digits = 2) {
  n <- nrow(hulls)
  if (n < 2) return(data.frame())

  pairs <- make_tree_pairs(n)
  results <- vector("list", ncol(pairs))

  for (k in seq_len(ncol(pairs))) {
    i <- pairs[1, k]
    j <- pairs[2, k]

    ov <- calc_pair_overlap(hulls$geometry[i], hulls$geometry[j])
    if (is.null(ov)) next

    results[[k]] <- data.frame(
      tree_1 = hulls[[tree_id_col]][i],
      tree_2 = hulls[[tree_id_col]][j],
      overlap_area        = round(ov$overlap_area, digits),
      overlap_pct_tree1   = round(ov$pct_a, digits),
      overlap_pct_tree2   = round(ov$pct_b, digits),
      stringsAsFactors = FALSE
    )
  }

  results <- Filter(Negate(is.null), results)
  if (length(results) == 0) return(data.frame())

  do.call(rbind, results)
}
