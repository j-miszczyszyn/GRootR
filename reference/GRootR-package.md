# GRootR: 3D Visualization and Statistical Analysis of Tree Roots from GPR

Tools for processing and analyzing tree root system data obtained from
Ground Penetrating Radar (GPR) with 3D scanning capabilities. The
package provides functions to:

- **Load** raw CSV data exported from GPR software (e.g., ImpulseRadar)

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

## Raw CSV format from GPR software

The input CSV is a direct export from GPR processing software. It
typically contains a CRS metadata header row, followed by column names
and data. The structure looks like:

    Spatial Reference System:,EPSG:2178,ETRS89 / Poland CS2000 zone 7,...
    N.,Type,Name,...,Node,`X[SRS units]`,`Y[SRS units]`,`Depth[m]`,...,Survey,...
    1,Pipe,Feature 0010,...,node1,7394244.316,5578579.578,0.202,...
    ,,,,,...,node2,7394245.057,5578579.786,0.202,...
    2,Pipe,Feature 0011,...,node1,7394244.185,5578580.438,0.202,...

Key characteristics:

- N.:

  Root identifier (integer). Only filled in the first node row of each
  root — continuation rows are empty.

- Node:

  Node label within root (e.g., "node1", "node2"). Used for ordering.

- `X[SRS units]`, `Y[SRS units]`:

  Coordinates in a projected CRS.

- `Depth[m]`:

  Depth below surface (positive = below ground).

- Survey:

  Composite string with date, number, plot ID, etc.

Column names are configurable in all functions — the defaults match the
standard GPR export format.

## Project

Developed as part of the NCN-funded project: "Application of
Ground-Penetrating Radar with 3D Scanner for Measuring Variability in
Scots Pine Root Systems" (Zastosowanie georadaru ze skanerem 3D do
pomiarow zmiennosci systemow korzeniowych sosny zwyczajnej)

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
