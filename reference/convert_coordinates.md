# Convert coordinate columns to numeric

Converts X, Y, Z (depth) columns to numeric values. Depth is negated so
that below-surface values are negative.

## Usage

``` r
convert_coordinates(
  df,
  x_col = "X.SRS.units.",
  y_col = "Y.SRS.units.",
  z_col = "Depth.m.",
  negate_z = TRUE,
  drop_original = TRUE
)
```

## Arguments

- df:

  A data.frame.

- x_col:

  Name of the X coordinate column.

- y_col:

  Name of the Y coordinate column.

- z_col:

  Name of the depth column.

- negate_z:

  Negate depth values? Default `TRUE` (depth becomes negative).

- drop_original:

  Drop original columns after conversion? Default `TRUE`.

## Value

A data.frame with numeric `X`, `Y`, `Z` columns.
