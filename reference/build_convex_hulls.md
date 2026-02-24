# Build convex hull polygons per tree

Creates a convex hull polygon from all root segment endpoints (kX, kY)
for each tree, representing the 2D spread of the root system.

## Usage

``` r
build_convex_hulls(df, tree_id_col = "TREE_ID", crs = 2178)
```

## Arguments

- df:

  A data.frame with columns `TREE_ID`, `kX`, `kY`.

- tree_id_col:

  Name of tree ID column. Default `"TREE_ID"`.

- crs:

  EPSG code for output geometry. Default `2178`.

## Value

An sf object with one POLYGON per tree.
