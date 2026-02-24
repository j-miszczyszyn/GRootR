# Tree-level summary pipeline

Given segments joined with tree IDs, computes per-tree summaries:
lengths, depth stats, orientation counts, convex hulls, areas, and 3D
volume.

## Usage

``` r
summarise_tree_roots(df, tree_id_col = "TREE_ID", crs = 2178)
```

## Arguments

- df:

  A data.frame of segments with `TREE_ID`, `pX`, `pY`, `pZ`, `kX`, `kY`,
  `kZ`, `length_3d`, `orientation`.

- tree_id_col:

  Name of tree ID column. Default `"TREE_ID"`.

- crs:

  EPSG code. Default `2178`.

## Value

A list with components:

- depth:

  Depth statistics per tree.

- orientations:

  Orientation counts per tree.

- hulls:

  Convex hull sf with area and extent.

- volume:

  3D volume estimates per tree.
