# Build line segments between consecutive root nodes

For a set of ordered root points, creates a line segment (LINESTRING)
between each consecutive pair of nodes.

## Usage

``` r
make_segments(sf_points, crs = 2178)
```

## Arguments

- sf_points:

  An sf point object with XYZ geometry, sorted by node order.

- crs:

  EPSG code. Default `2178`.

## Value

An sf object with LINESTRING geometry and columns `pX, pY, pZ` (start)
and `kX, kY, kZ` (end).
