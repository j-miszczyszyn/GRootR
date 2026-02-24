# Calculate overlap between two geometries

Computes the intersection area and overlap percentages between two
polygon geometries.

## Usage

``` r
calc_pair_overlap(geom_a, geom_b)
```

## Arguments

- geom_a:

  An sf geometry (sfc) object.

- geom_b:

  An sf geometry (sfc) object.

## Value

A list with `overlap_area`, `pct_a` (% of A covered), and `pct_b` (% of
B covered), or NULL if no overlap.
