# Calculate all pairwise root system overlaps

Computes overlap statistics for all pairs of trees in a convex hull
dataset.

## Usage

``` r
calc_all_overlaps(hulls, tree_id_col = "TREE_ID", digits = 2)
```

## Arguments

- hulls:

  An sf object with convex hull polygons. Must have a tree ID column.

- tree_id_col:

  Name of tree ID column. Default `"TREE_ID"`.

- digits:

  Number of decimal places to round. Default `2`.

## Value

A data.frame with columns: `tree_1`, `tree_2`, `overlap_area`,
`overlap_pct_tree1`, `overlap_pct_tree2`. Rows with zero overlap are
excluded.
