#' GRootR: 3D Visualization and Statistical Analysis of Tree Roots from GPR
#'
#' @description
#' Tools for processing and analyzing tree root system data obtained from
#' Ground Penetrating Radar (GPR) with 3D scanning capabilities.
#' The package provides functions to:
#'
#' - **Load** raw CSV data exported from GPR software (e.g., ImpulseRadar)
#' - **Build** spatial line segments between consecutive root nodes
#' - **Calculate** geometric metrics: 3D length, azimuth, inclination, slope
#' - **Join** root segments with tree stem locations
#' - **Aggregate** metrics at root and tree level (lengths, depth, orientations)
#' - **Build** 2D convex hull polygons representing root system spread
#' - **Estimate** 3D bounding volume of root systems
#' - **Analyze** inter-tree root overlap competition
#' - **Compute** root-to-trunk distances
#'
#' @section Raw CSV format from GPR software:
#' The input CSV is a direct export from GPR processing software. It typically
#' contains a CRS metadata header row, followed by column names and data.
#' The structure looks like:
#' \preformatted{
#' Spatial Reference System:,EPSG:2178,ETRS89 / Poland CS2000 zone 7,...
#' N.,Type,Name,...,Node,`X[SRS units]`,`Y[SRS units]`,`Depth[m]`,...,Survey,...
#' 1,Pipe,Feature 0010,...,node1,7394244.316,5578579.578,0.202,...
#' ,,,,,...,node2,7394245.057,5578579.786,0.202,...
#' 2,Pipe,Feature 0011,...,node1,7394244.185,5578580.438,0.202,...
#' }
#'
#' Key characteristics:
#' \describe{
#'   \item{N.}{Root identifier (integer). Only filled in the first node row of each root — continuation rows are empty.}
#'   \item{Node}{Node label within root (e.g., "node1", "node2"). Used for ordering.}
#'   \item{`X[SRS units]`, `Y[SRS units]`}{Coordinates in a projected CRS.}
#'   \item{`Depth[m]`}{Depth below surface (positive = below ground).}
#'   \item{Survey}{Composite string with date, number, plot ID, etc.}
#' }
#'
#' Column names are configurable in all functions — the defaults match the
#' standard GPR export format.
#'
#' @section Project:
#' Developed as part of the NCN-funded project:
#' "Application of Ground-Penetrating Radar with 3D Scanner for Measuring
#' Variability in Scots Pine Root Systems"
#' (Zastosowanie georadaru ze skanerem 3D do pomiarow zmiennosci systemow
#' korzeniowych sosny zwyczajnej)
#'
#' @docType package
#' @name GRootR-package
#'
#' @importFrom sf st_as_sf st_join st_crs st_transform st_coordinates
#'   st_drop_geometry st_sfc st_linestring st_multipoint st_convex_hull
#'   st_area st_bbox st_intersection st_is_empty st_distance st_union
#'   st_is_within_distance st_point st_geometry
#' @importFrom dplyr left_join lead last group_by summarise case_when
#'   ungroup filter mutate
#' @importFrom zoo na.locf
#' @importFrom stringr str_extract
#' @importFrom rlang .data
#' @importFrom stats aggregate as.formula
#' @importFrom utils combn read.csv
"_PACKAGE"
