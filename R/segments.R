#' @title Create Root Segments
#' @description Functions for converting root points into spatial line segments.
#' @name segments
NULL

#' Convert root points to sf object
#'
#' Converts a data.frame with X, Y, Z columns to an sf point object with
#' XYZ dimensions.
#'
#' @param df A data.frame with X, Y, Z columns.
#' @param crs EPSG code or CRS object. Default `2178`.
#'
#' @return An sf point object with XYZ geometry.
#' @export
points_to_sf <- function(df, crs = 2178) {
  if (!all(c("X", "Y", "Z") %in% names(df))) {
    stop("Columns X, Y, Z are required.")
  }
  sf::st_as_sf(df, coords = c("X", "Y", "Z"), dim = "XYZ", crs = crs)
}

#' Build line segments between consecutive root nodes
#'
#' For a set of ordered root points, creates a line segment (LINESTRING)
#' between each consecutive pair of nodes.
#'
#' @param sf_points An sf point object with XYZ geometry, sorted by node order.
#' @param crs EPSG code. Default `2178`.
#'
#' @return An sf object with LINESTRING geometry and columns
#'   `pX, pY, pZ` (start) and `kX, kY, kZ` (end).
#' @export
make_segments <- function(sf_points, crs = 2178) {
  coords <- sf::st_coordinates(sf_points$geometry)

  sf_points$pX <- coords[, 1]
  sf_points$pY <- coords[, 2]
  sf_points$pZ <- coords[, 3]
  sf_points$kX <- dplyr::lead(sf_points$pX, default = dplyr::last(sf_points$pX))
  sf_points$kY <- dplyr::lead(sf_points$pY, default = dplyr::last(sf_points$pY))
  sf_points$kZ <- dplyr::lead(sf_points$pZ, default = dplyr::last(sf_points$pZ))

  sf_points <- sf::st_drop_geometry(sf_points)

  # Remove zero-length segments
  sf_points <- sf_points[
    sf_points$pX != sf_points$kX |
    sf_points$pY != sf_points$kY |
    sf_points$pZ != sf_points$kZ, ]

  if (nrow(sf_points) == 0) return(NULL)

  # Build linestrings
  geom_list <- mapply(function(px, py, pz, kx, ky, kz) {
    sf::st_linestring(matrix(c(px, py, pz, kx, ky, kz), ncol = 3, byrow = TRUE))
  }, sf_points$pX, sf_points$pY, sf_points$pZ,
     sf_points$kX, sf_points$kY, sf_points$kZ,
     SIMPLIFY = FALSE)

  sf_points$geometry <- sf::st_sfc(geom_list, crs = crs)
  sf::st_as_sf(sf_points)
}

#' Process a single root into segments
#'
#' Filters data for one ROOT_ID, converts to sf, and builds segments.
#'
#' @param df A data.frame with X, Y, Z, ROOT_ID, Node columns.
#' @param root_id The ROOT_ID value to process.
#' @param node_col Name of the node column. Default `"Node"`.
#' @param crs EPSG code. Default `2178`.
#'
#' @return An sf object with segments, or NULL if root has < 2 points.
#' @export
process_single_root <- function(df, root_id, node_col = "Node", crs = 2178) {
  sub <- df[df$ROOT_ID == root_id, ]

  if (nrow(sub) < 2) return(NULL)

  # Extract numeric node order
  sub$node_num <- as.numeric(stringr::str_extract(as.character(sub[[node_col]]), "\\d+"))
  sub <- sub[order(sub$node_num), ]

  sf_pts <- points_to_sf(sub, crs = crs)
  make_segments(sf_pts, crs = crs)
}

#' Process all roots into segments
#'
#' Iterates over all unique ROOT_IDs, builds segments, and binds results.
#'
#' @param df A data.frame with X, Y, Z, ROOT_ID, Node columns.
#' @param node_col Name of the node column. Default `"Node"`.
#' @param crs EPSG code. Default `2178`.
#' @param verbose Print progress messages? Default `TRUE`.
#'
#' @return An sf object with all segments, or NULL if none succeeded.
#' @export
process_all_roots <- function(df, node_col = "Node", crs = 2178, verbose = TRUE) {
  ids <- unique(df$ROOT_ID)
  results <- vector("list", length(ids))
  errors <- character(0)

  for (i in seq_along(ids)) {
    rid <- ids[i]
    tryCatch({
      out <- process_single_root(df, rid, node_col = node_col, crs = crs)
      if (!is.null(out)) results[[i]] <- out
    }, error = function(e) {
      errors <<- c(errors, as.character(rid))
      if (verbose) message("Error at ROOT_ID: ", rid, " - ", e$message)
    })
  }

  results <- Filter(Negate(is.null), results)
  if (length(results) == 0) return(NULL)

  out <- do.call(rbind, results)

  if (verbose && length(errors) > 0) {
    message("Failed ROOT_IDs: ", paste(errors, collapse = ", "))
  }

  out
}
