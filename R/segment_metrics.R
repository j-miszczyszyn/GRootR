#' @title Segment Geometric Metrics
#' @description Functions for calculating geometric properties of root segments:
#'   length, azimuth, inclination angle, and slope classification.
#' @name segment_metrics
NULL

#' Calculate segment 3D length
#'
#' Euclidean distance between start (pX,pY,pZ) and end (kX,kY,kZ) of each segment.
#'
#' @param segments An sf object with columns `pX, pY, pZ, kX, kY, kZ`.
#'
#' @return The same sf object with added column `length_3d`.
#' @export
calc_segment_length <- function(segments) {
  segments$length_3d <- sqrt(
    (segments$kX - segments$pX)^2 +
    (segments$kY - segments$pY)^2 +
    (segments$kZ - segments$pZ)^2
  )
  segments
}

#' Calculate segment azimuth
#'
#' Azimuth (bearing) from start to end point, measured clockwise from north
#' in degrees (0-360).
#'
#' @param segments An sf object with columns `pX, pY, kX, kY`.
#'
#' @return The same sf object with added column `azimuth`.
#' @export
calc_segment_azimuth <- function(segments) {
  segments$azimuth <- (atan2(segments$kX - segments$pX,
                             segments$kY - segments$pY) * 180 / pi) %% 360
  segments
}

#' Calculate segment inclination angle
#'
#' Angle of the segment relative to the horizontal plane, in degrees.
#' 0 = horizontal, 90 = vertical (downward).
#'
#' @param segments An sf object with columns `pX, pY, pZ, kX, kY, kZ`.
#'
#' @return The same sf object with added columns `deltaX, deltaY, deltaZ`,
#'   and `inclination_angle`.
#' @export
calc_inclination <- function(segments) {
  segments$deltaX <- segments$kX - segments$pX
  segments$deltaY <- segments$kY - segments$pY
  segments$deltaZ <- segments$kZ - segments$pZ

  horiz_dist <- sqrt(segments$deltaX^2 + segments$deltaY^2)
  segments$inclination_angle <- atan(segments$deltaZ / horiz_dist) * 180 / pi

  segments
}

#' Classify segment slope
#'
#' Assigns orientation (`"vertical"` / `"horizontal"`) and a slope category
#' based on inclination angle thresholds.
#'
#' @param segments An sf object with column `inclination_angle`.
#' @param breaks Numeric vector of 4 thresholds (ascending). Default `c(15, 30, 45, 75)`.
#' @param labels Character vector of 5 category labels (from flattest to steepest).
#'   Default English labels.
#'
#' @return The same sf object with added columns `orientation` and `slope_category`.
#' @export
classify_slope <- function(segments,
                           breaks = c(15, 30, 45, 75),
                           labels = c("horizontal", "slight", "moderate",
                                      "steep", "vertical")) {
  if (length(breaks) != 4 || length(labels) != 5) {
    stop("'breaks' must have 4 values, 'labels' must have 5 values.")
  }

  angle <- abs(segments$inclination_angle)
  segments$orientation <- ifelse(angle > breaks[3], "vertical", "horizontal")

  segments$slope_category <- dplyr::case_when(
    angle >= breaks[4] ~ labels[5],
    angle >= breaks[3] ~ labels[4],
    angle >= breaks[2] ~ labels[3],
    angle >= breaks[1] ~ labels[2],
    TRUE               ~ labels[1]
  )

  segments
}

#' Calculate all segment metrics at once
#'
#' Convenience wrapper that runs length, azimuth, inclination, and slope
#' classification in sequence.
#'
#' @param segments An sf object with columns `pX, pY, pZ, kX, kY, kZ`.
#' @param ... Additional arguments passed to [classify_slope()].
#'
#' @return The same sf object with all metric columns added.
#' @export
calc_all_segment_metrics <- function(segments, ...) {
  segments <- calc_segment_length(segments)
  segments <- calc_segment_azimuth(segments)
  segments <- calc_inclination(segments)
  segments <- classify_slope(segments, ...)
  segments
}
