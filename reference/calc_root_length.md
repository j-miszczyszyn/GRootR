# Calculate total length per root

Sums segment lengths within each ROOT_ID.

## Usage

``` r
calc_root_length(df)
```

## Arguments

- df:

  A data.frame with columns `ROOT_ID` and `length_3d`.

## Value

The same data.frame with added column `total_length_root`.
