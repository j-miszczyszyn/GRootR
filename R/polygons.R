#' @title 2D Root System Polygons
#' @description Functions for building convex hull polygons from root endpoint
#'   coordinates and computing their area and extent.
#' @name polygons
NULL

#' Build convex hull polygons per tree
#'
#' Creates a convex hull polygon from all root segment endpoints (kX, kY)
#' for each tree, representing the 2D spread of the root system.
#'
#' @param df A data.frame with columns `TREE_ID`, `kX`, `kY`.
#' @param tree_id_col Name of tree ID column. Default `"TREE_ID"`.
#' @param crs EPSG code for output geometry. Default `2178`.
#'
#' @return An sf object with one POLYGON per tree.
#' @export
build_convex_hulls <- function(df, tree_id_col = "TREE_ID", crs = 2178) {
  tree_ids <- unique(df[[tree_id_col]])
  hulls <- vector("list", length(tree_ids))

  for (i in seq_along(tree_ids)) {
    tid <- tree_ids[i]
    sub <- df[df[[tree_id_col]] == tid, ]

    pts <- unique(rbind(
      data.frame(x = sub$kX, y = sub$kY),
      data.frame(x = sub$pX, y = sub$pY)
    ))

    if (nrow(pts) < 3) {
      hulls[[i]] <- NULL
      next
    }

    mp <- sf::st_multipoint(as.matrix(pts))
    hull <- sf::st_convex_hull(mp)

    hulls[[i]] <- data.frame(tree_id_val = tid, stringsAsFactors = FALSE)
    hulls[[i]]$geometry <- sf::st_sfc(hull, crs = crs)
  }

  hulls <- Filter(Negate(is.null), hulls)
  result <- do.call(rbind, hulls)
  names(result)[1] <- tree_id_col
  sf::st_as_sf(result)
}

#' Calculate hull area and extent
#'
#' Computes the area of each convex hull polygon and the X/Y extent
#' (bounding box width and height).
#'
#' @param hulls An sf object with convex hull polygons, as returned by
#'   [build_convex_hulls()].
#'
#' @return The same sf object with added columns: `area_2d`, `extent_x`, `extent_y`.
#' @export
calc_hull_area <- function(hulls) {
  hulls$area_2d <- as.numeric(sf::st_area(hulls))

  bboxes <- lapply(sf::st_geometry(hulls), sf::st_bbox)
  hulls$extent_x <- vapply(bboxes, function(b) b["xmax"] - b["xmin"], numeric(1))
  hulls$extent_y <- vapply(bboxes, function(b) b["ymax"] - b["ymin"], numeric(1))

  hulls
}
