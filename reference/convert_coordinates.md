# Convert coordinate columns to numeric

Converts X, Y, Z (depth) columns to numeric values. Depth is negated by
default so that below-surface values become negative Z coordinates.

## Usage

``` r
convert_coordinates(
  df,
  x_col = "X[SRS units]",
  y_col = "Y[SRS units]",
  z_col = "Depth[m]",
  negate_z = TRUE,
  drop_original = TRUE
)
```

## Arguments

- df:

  A data.frame.

- x_col:

  Name of the X coordinate column. Default `"X[SRS units]"`.

- y_col:

  Name of the Y coordinate column. Default `"Y[SRS units]"`.

- z_col:

  Name of the depth column. Default `"Depth[m]"`.

- negate_z:

  Negate depth values? Default `TRUE` (depth becomes negative).

- drop_original:

  Drop original columns after conversion? Default `TRUE`.

## Value

A data.frame with numeric `X`, `Y`, `Z` columns.

## Details

The default column names match the GPR export format: `X[SRS units]`,
`Y[SRS units]`, `Depth[m]`.
