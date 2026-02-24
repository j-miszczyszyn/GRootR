# GRootR: 3D Visualization and Statistical Analysis of Tree Roots from GPR

Tools for processing and analyzing tree root system data obtained from
Ground Penetrating Radar (GPR) with 3D scanning capabilities. The
package provides functions to:

- **Load** raw CSV point data and prepare coordinates

- **Build** spatial line segments between consecutive root nodes

- **Calculate** geometric metrics: 3D length, azimuth, inclination,
  slope

- **Join** root segments with tree stem locations

- **Aggregate** metrics at root and tree level (lengths, depth,
  orientations)

- **Build** 2D convex hull polygons representing root system spread

- **Estimate** 3D bounding volume of root systems

- **Analyze** inter-tree root overlap competition

- **Compute** root-to-trunk distances

## Expected CSV structure

The input CSV should contain at minimum:

- ROOT_ID:

  Integer or numeric root identifier (may have NAs for continuation
  rows)

- Node:

  Node label within each root (e.g., "Node1", "Node2", or numeric)

- X column:

  X coordinate in a projected CRS

- Y column:

  Y coordinate in a projected CRS

- Z/Depth column:

  Depth value (positive = below surface)

Column names are configurable in all functions.

## Project

Developed as part of the NCN-funded project: "Application of
Ground-Penetrating Radar with 3D Scanner for Measuring Variability in
Scots Pine Root Systems" (Zastosowanie georadaru ze skanerem 3D do
pomiarów zmienności systemów korzeniowych sosny zwyczajnej)

## See also

Useful links:

- <https://github.com/j-miszczyszyn/GRootR>

- Report bugs at <https://github.com/j-miszczyszyn/GRootR/issues>

## Author

**Maintainer**: Jakub Miszczyszyn <jakub.miszczyszyn@urk.edu.pl>
([ORCID](https://orcid.org/0009-0002-8592-946X)) (University of
Agriculture in Krakow, Faculty of Forestry, Department of Forest
Management)

Authors:

- Luiza Tyminska-Czabanska <luiza.tyminska@urk.edu.pl>
  ([ORCID](https://orcid.org/0000-0002-4921-7070)) (University of
  Agriculture in Krakow, Faculty of Forestry, Department of Forest
  Management)
