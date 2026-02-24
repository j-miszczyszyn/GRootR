# Count segment orientations per tree

Counts vertical and horizontal segments for each tree.

## Usage

``` r
count_orientations(df, tree_id_col = "TREE_ID")
```

## Arguments

- df:

  A data.frame with columns `TREE_ID` and `orientation`.

- tree_id_col:

  Name of tree ID column. Default `"TREE_ID"`.

## Value

A data.frame with columns `n_vertical` and `n_horizontal` per tree.
