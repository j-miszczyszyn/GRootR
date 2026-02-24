# Classify segment slope

Assigns orientation (`"vertical"` / `"horizontal"`) and a slope category
based on inclination angle thresholds.

## Usage

``` r
classify_slope(
  segments,
  breaks = c(15, 30, 45, 75),
  labels = c("horizontal", "slight", "moderate", "steep", "vertical")
)
```

## Arguments

- segments:

  An sf object with column `inclination_angle`.

- breaks:

  Numeric vector of 4 thresholds (ascending). Default
  `c(15, 30, 45, 75)`.

- labels:

  Character vector of 5 category labels (from flattest to steepest).
  Default English labels.

## Value

The same sf object with added columns `orientation` and
`slope_category`.
