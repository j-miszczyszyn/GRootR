# Process all roots into segments

Iterates over all unique ROOT_IDs, builds segments, and binds results.

## Usage

``` r
process_all_roots(df, node_col = "Node", crs = 2178, verbose = TRUE)
```

## Arguments

- df:

  A data.frame with X, Y, Z, ROOT_ID, Node columns.

- node_col:

  Name of the node column. Default `"Node"`.

- crs:

  EPSG code. Default `2178`.

- verbose:

  Print progress messages? Default `TRUE`.

## Value

An sf object with all segments, or NULL if none succeeded.
