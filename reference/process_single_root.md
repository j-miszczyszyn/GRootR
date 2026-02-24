# Process a single root into segments

Filters data for one ROOT_ID, converts to sf, and builds segments.

## Usage

``` r
process_single_root(df, root_id, node_col = "Node", crs = 2178)
```

## Arguments

- df:

  A data.frame with X, Y, Z, ROOT_ID, Node columns.

- root_id:

  The ROOT_ID value to process.

- node_col:

  Name of the node column. Default `"Node"`.

- crs:

  EPSG code. Default `2178`.

## Value

An sf object with segments, or NULL if root has \< 2 points.
