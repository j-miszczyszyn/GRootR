# Calculate segment 3D length

Euclidean distance between start (pX,pY,pZ) and end (kX,kY,kZ) of each
segment.

## Usage

``` r
calc_segment_length(segments)
```

## Arguments

- segments:

  An sf object with columns `pX, pY, pZ, kX, kY, kZ`.

## Value

The same sf object with added column `length_3d`.
