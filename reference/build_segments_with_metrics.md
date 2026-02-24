# Full segment pipeline

Processes raw root data into segments with all geometric metrics.

## Usage

``` r
build_segments_with_metrics(df, crs = 2178, verbose = TRUE)
```

## Arguments

- df:

  A prepared data.frame from
  [`prepare_root_data()`](https://j-miszczyszyn.github.io/GRootR/reference/prepare_root_data.md).

- crs:

  EPSG code. Default `2178`.

- verbose:

  Print progress? Default `TRUE`.

## Value

An sf object with segments and all metric columns.
