# Calculate all segment metrics at once

Convenience wrapper that runs length, azimuth, inclination, and slope
classification in sequence.

## Usage

``` r
calc_all_segment_metrics(segments, ...)
```

## Arguments

- segments:

  An sf object with columns `pX, pY, pZ, kX, kY, kZ`.

- ...:

  Additional arguments passed to
  [`classify_slope()`](https://j-miszczyszyn.github.io/GRootR/reference/classify_slope.md).

## Value

The same sf object with all metric columns added.
