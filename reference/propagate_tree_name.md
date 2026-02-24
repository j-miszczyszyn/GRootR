# Propagate tree name to all segments of the same root

After spatial join, only segments near the tree base get the tree ID.
This function propagates the tree ID to ALL segments sharing the same
ROOT_ID.

## Usage

``` r
propagate_tree_name(joined, tree_id_col = "TREE_ID")
```

## Arguments

- joined:

  An sf object from
  [`join_nearest_tree()`](https://j-miszczyszyn.github.io/GRootR/reference/join_nearest_tree.md),
  containing `ROOT_ID` and a tree ID column (possibly with NAs).

- tree_id_col:

  Name of the tree identifier column. Default `"TREE_ID"`.

## Value

An sf object where all segments of a root share the same tree ID. Roots
with no matched tree are removed.
