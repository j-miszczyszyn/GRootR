# Calculate total root length per tree

Sums segment lengths within each TREE_ID.

## Usage

``` r
calc_tree_length(df, tree_id_col = "TREE_ID")
```

## Arguments

- df:

  A data.frame with columns `TREE_ID` and `length_3d`.

- tree_id_col:

  Name of tree ID column. Default `"TREE_ID"`.

## Value

The same data.frame with added column `total_length_tree`.
