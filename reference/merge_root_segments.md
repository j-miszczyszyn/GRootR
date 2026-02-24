# Merge root segments into single geometries

Unions all line segments belonging to the same ROOT_ID into one
geometry.

## Usage

``` r
merge_root_segments(root_sf, tree_id_col = "TREE_ID")
```

## Arguments

- root_sf:

  An sf object with root segments and columns `ROOT_ID`, `TREE_ID`.

- tree_id_col:

  Name of tree ID column. Default `"TREE_ID"`.

## Value

An sf object with one row per ROOT_ID, with unioned geometry.
