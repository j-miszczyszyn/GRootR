# Calculate segment azimuth

Azimuth (bearing) from start to end point, measured clockwise from north
in degrees (0-360).

## Usage

``` r
calc_segment_azimuth(segments)
```

## Arguments

- segments:

  An sf object with columns `pX, pY, kX, kY`.

## Value

The same sf object with added column `azimuth`.
