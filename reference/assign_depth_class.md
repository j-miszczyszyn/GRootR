# Assign depth class

Classifies each segment into depth bins based on the start point Z
coordinate.

## Usage

``` r
assign_depth_class(df, bin_m = 0.2)
```

## Arguments

- df:

  A data.frame with column `pZ`.

- bin_m:

  Bin width in meters. Default `0.2` (20 cm).

## Value

The same data.frame with added column `depth_class` (in cm).
