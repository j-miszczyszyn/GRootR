# Calculate depth statistics per tree

Computes maximum depth, mean depth, and depth range for each tree.

## Usage

``` r
calc_depth_stats(df, tree_id_col = "TREE_ID")
```

## Arguments

- df:

  A data.frame with columns `TREE_ID`, `pZ`, `kZ`.

- tree_id_col:

  Name of tree ID column. Default `"TREE_ID"`.

## Value

A data.frame with one row per tree and columns: `depth_max`,
`depth_mean`, `depth_range`.
