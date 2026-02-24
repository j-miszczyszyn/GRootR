# Split survey column

Splits a composite survey/filename column into parts by a separator and
extracts the plot identifier.

## Usage

``` r
split_survey_column(
  df,
  survey_col = "Survey",
  sep = "_",
  plot_position = 4,
  plot_name = "PLOT_ID",
  drop_original = TRUE
)
```

## Arguments

- df:

  A data.frame.

- survey_col:

  Name of the column to split. Default `"Survey"`.

- sep:

  Separator string. Default `"_"`.

- plot_position:

  Which part (after split) contains the plot ID. Default `4`.

- plot_name:

  Name for the new plot column. Default `"PLOT_ID"`.

- drop_original:

  Drop the original survey column? Default `TRUE`.

## Value

A data.frame with a new plot column.
