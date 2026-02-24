# Load root CSV file

Reads a CSV file with root point data and fills missing ROOT_ID values
using last observation carried forward.

## Usage

``` r
load_root_csv(path, sep = ";", root_id_col = "ROOT_ID")
```

## Arguments

- path:

  Path to CSV file.

- sep:

  Column separator. Default `";"` (csv2 format).

- root_id_col:

  Name of the root identifier column. Default `"ROOT_ID"`.

## Value

A data.frame with filled ROOT_ID.
