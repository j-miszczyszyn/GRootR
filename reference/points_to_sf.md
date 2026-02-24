# Convert root points to sf object

Converts a data.frame with X, Y, Z columns to an sf point object with
XYZ dimensions.

## Usage

``` r
points_to_sf(df, crs = 2178)
```

## Arguments

- df:

  A data.frame with X, Y, Z columns.

- crs:

  EPSG code or CRS object. Default `2178`.

## Value

An sf point object with XYZ geometry.
