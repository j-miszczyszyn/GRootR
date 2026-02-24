# Load and prepare root data from CSV

Convenience wrapper that loads a GPR export CSV, fills ROOT_IDs,
optionally splits the survey column, and converts coordinates.

## Usage

``` r
prepare_root_data(
  path,
  sep = ",",
  skip = 1,
  root_id_col = "N.",
  x_col = "X[SRS units]",
  y_col = "Y[SRS units]",
  z_col = "Depth[m]",
  negate_z = TRUE,
  survey_col = "Survey",
  plot_position = 4
)
```

## Arguments

- path:

  Path to CSV file.

- sep:

  CSV separator. Default `","`.

- skip:

  Number of header rows to skip. Default `1` (CRS metadata row).

- root_id_col:

  Name of the root identifier column in raw CSV. Default `"N."`.

- x_col, y_col, z_col:

  Names of coordinate columns.

- negate_z:

  Negate Z values? Default `TRUE`.

- survey_col:

  Name of survey column to split, or `NULL` to skip.

- plot_position:

  Position of plot ID in split survey. Default `4`.

## Value

A cleaned data.frame ready for segment processing.
