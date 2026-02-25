# Load GPR root CSV file

Reads a CSV file exported from GPR processing software. The file
typically has a metadata header row (e.g., Spatial Reference System
info) followed by column names and data. The root identifier column
(`N.` by default) is only filled in the first row of each root —
subsequent rows are empty. This function fills those gaps using last
observation carried forward.

## Usage

``` r
load_root_csv(
  path,
  sep = ",",
  skip = 1,
  root_id_col = "N.",
  root_id_name = "ROOT_ID"
)
```

## Arguments

- path:

  Path to CSV file.

- sep:

  Column separator. Default `","`.

- skip:

  Number of header rows to skip before column names. Default `1` (skips
  the CRS metadata row).

- root_id_col:

  Name of the root identifier column. Default `"N."`.

- root_id_name:

  New name for the root ID column. Default `"ROOT_ID"`.

## Value

A data.frame with a filled `ROOT_ID` column (integer).

## Raw CSV structure

A typical GPR export CSV looks like:

    Spatial Reference System:,EPSG:2178,ETRS89 / Poland CS2000 zone 7,...
    N.,Type,Name,...,Node,X[SRS units],Y[SRS units],Depth[m],Altitude[m],Survey,...
    1,Pipe,Feature 0010,...,node1,7394244.316,5578579.578,0.202,-0.202,...
    ,,,,,...,node2,7394245.057,5578579.786,0.202,-0.202,...
    ,,,,,...,node3,7394245.455,5578580.134,0.202,-0.202,...
    2,Pipe,Feature 0011,...,node1,7394244.185,5578580.438,0.202,-0.202,...

The first row contains CRS metadata (skipped via `skip`). The `N.`
column identifies each root but is only populated in the first node row
— continuation rows are empty/NA.

Note: GPR exports often have a trailing comma on data rows, which is
handled automatically.
