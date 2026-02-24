# Calculate real vertical range per tree

Computes the true vertical extent of the root system as the difference
between the shallowest and deepest points.

## Usage

``` r
calc_real_z(df, tree_id_col = "TREE_ID")
```

## Arguments

- df:

  A data.frame with columns `TREE_ID`, `pZ`, `kZ`.

- tree_id_col:

  Name of tree ID column. Default `"TREE_ID"`.

## Value

A data.frame with one row per tree and column `real_z`.
