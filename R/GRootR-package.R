#' GRootR: 3D Visualization and Statistical Analysis of Tree Roots from GPR
#'
#' @description
#' Tools for processing and analyzing tree root system data obtained from
#' Ground Penetrating Radar (GPR) with 3D scanning capabilities.
#' The package provides functions to:
#'
#' - **Load** raw CSV point data and prepare coordinates
#' - **Build** spatial line segments between consecutive root nodes
#' - **Calculate** geometric metrics: 3D length, azimuth, inclination, slope
#' - **Join** root segments with tree stem locations
#' - **Aggregate** metrics at root and tree level (lengths, depth, orientations)
#' - **Build** 2D convex hull polygons representing root system spread
#' - **Estimate** 3D bounding volume of root systems
#' - **Analyze** inter-tree root overlap competition
#' - **Compute** root-to-trunk distances
#'
#' @section Expected CSV structure:
#' The input CSV should contain at minimum:
#' \describe{
#'   \item{ROOT_ID}{Integer or numeric root identifier (may have NAs for continuation rows)}
#'   \item{Node}{Node label within each root (e.g., "Node1", "Node2", or numeric)}
#'   \item{X column}{X coordinate in a projected CRS}
#'   \item{Y column}{Y coordinate in a projected CRS}
#'   \item{Z/Depth column}{Depth value (positive = below surface)}
#' }
#'
#' Column names are configurable in all functions.
#'
#' @section Project:
#' Developed as part of the NCN-funded project:
#' "Application of Ground-Penetrating Radar with 3D Scanner for Measuring
#' Variability in Scots Pine Root Systems"
#' (Zastosowanie georadaru ze skanerem 3D do pomiarów zmienności systemów
#' korzeniowych sosny zwyczajnej)
#'
#' @docType package
#' @name GRootR-package
"_PACKAGE"
