# Calculate distance from each root to its tree trunk

For each root, computes the minimum distance between the root geometry
and the corresponding tree stem point.

## Usage

``` r
calc_dist_to_trunk(roots_merged, tree_points, tree_id_col = "TREE_ID")
```

## Arguments

- roots_merged:

  An sf object from
  [`merge_root_segments()`](https://j-miszczyszyn.github.io/GRootR/reference/merge_root_segments.md).

- tree_points:

  An sf point object with tree locations and a tree ID column.

- tree_id_col:

  Name of tree ID column. Default `"TREE_ID"`.

## Value

The input `roots_merged` with an added column `dist_to_trunk`.
