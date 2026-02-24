# Calculate 3D bounding volume

Estimates root system volume as the product of vertical range (real_z)
and 2D convex hull area (area_2d).

## Usage

``` r
calc_range_3d(depth_df, hull_df, tree_id_col = "TREE_ID")
```

## Arguments

- depth_df:

  A data.frame with columns `TREE_ID` and `real_z`, as returned by
  [`calc_real_z()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_real_z.md).

- hull_df:

  An sf or data.frame with columns `TREE_ID` and `area_2d`, as returned
  by
  [`calc_hull_area()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_hull_area.md).

- tree_id_col:

  Name of tree ID column. Default `"TREE_ID"`.

## Value

A data.frame with columns `TREE_ID`, `real_z`, `area_2d`, `range_3d`.
