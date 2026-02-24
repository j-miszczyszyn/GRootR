# Data Format & Import

## Expected CSV structure

GRootR expects a CSV file exported from GPR processing software (e.g.,
REFLEXW, GPR-SLICE, or similar). Each row represents a single node
(point) along a detected root, with the following columns:

| Column                        | Type              | Description                                                                                             |
|-------------------------------|-------------------|---------------------------------------------------------------------------------------------------------|
| `ROOT_ID`                     | integer           | Unique root identifier. May contain NAs for continuation rows — these are filled forward automatically. |
| `Node`                        | character/numeric | Node label within each root, e.g. `"Node1"`, `"Node2"` or just numbers. Used for ordering.              |
| `X.SRS.units.`                | numeric           | X coordinate in a projected Coordinate Reference System.                                                |
| `Y.SRS.units.`                | numeric           | Y coordinate in a projected CRS.                                                                        |
| `Depth.m.`                    | numeric           | Depth below surface in meters. **Positive values** = below ground.                                      |
| `Altitude.m.`                 | numeric           | *(optional)* Surface altitude — dropped during import.                                                  |
| `Survey`                      | character         | *(optional)* Composite string encoding date, number, plot ID, etc., separated by `_`.                   |
| `Channel`                     | numeric           | *(optional)* GPR channel number. Retained in output.                                                    |
| `Propagation.Velocity.cm.ns.` | numeric           | *(optional)* Wave propagation velocity. Retained in output.                                             |
| `Cross.Distance.m.`           | numeric           | *(optional)* Cross-line distance. Retained in output.                                                   |

### Example raw data

    ROOT_ID;Node;Survey;Channel;Propagation.Velocity.cm.ns.;Cross.Distance.m.;X.SRS.units.;Y.SRS.units.;Depth.m.;Altitude.m.
    1;Node1;scan_20240715_001_A_raw;1;8.5;0.12;5546823.45;5765432.10;0.35;312.5
    ;Node2;scan_20240715_001_A_raw;1;8.5;0.15;5546823.52;5765432.08;0.42;312.5
    ;Node3;scan_20240715_001_A_raw;1;8.5;0.18;5546823.61;5765432.05;0.48;312.5
    2;Node1;scan_20240715_001_A_raw;1;8.5;0.22;5546824.10;5765433.20;0.28;312.5

Note that `ROOT_ID` is only specified in the first row of each root —
subsequent rows are empty (NA). GRootR fills these automatically.

## Column name mapping

All column names are **configurable**. If your CSV uses different names:

``` r
df <- load_root_csv("my_data.csv", sep = ";", root_id_col = "RootNumber")

df <- convert_coordinates(
  df,
  x_col = "Easting",
  y_col = "Northing",
  z_col = "DepthMeters",
  negate_z = TRUE
)
```

## Coordinate Reference System

GRootR does not reproject data — it uses whatever CRS your coordinates
are in. You specify the EPSG code when building segments:

``` r
# Polish CS2000 zone 7
segments <- process_all_roots(df, crs = 2178)

# UTM zone 33N
segments <- process_all_roots(df, crs = 32633)

# Any other projected CRS
segments <- process_all_roots(df, crs = 25832)
```

**Important:** Use a *projected* CRS (meters), not geographic (degrees).
Distances and areas are computed in CRS units.

## The Survey column

The `Survey` column typically contains a composite filename like:

    scan_20240715_001_A_raw

[`split_survey_column()`](https://j-miszczyszyn.github.io/GRootR/reference/split_survey_column.md)
splits it by `_` and extracts one part as the plot ID:

``` r
# Default: 4th part → "A"
df <- split_survey_column(df, survey_col = "Survey", sep = "_", plot_position = 4)

# If your plot ID is in a different position:
df <- split_survey_column(df, plot_position = 3)
```

If you don’t have a Survey column or don’t need it, pass
`survey_col = NULL` to
[`prepare_root_data()`](https://j-miszczyszyn.github.io/GRootR/reference/prepare_root_data.md).

## Comma vs semicolon CSV

``` r
# Semicolon-separated (csv2 format, European)
df <- load_root_csv("data.csv", sep = ";")

# Comma-separated (standard csv)
df <- load_root_csv("data.csv", sep = ",")
```

## Tree location data

For joining roots with trees, you need a spatial file (shapefile,
GeoPackage, etc.) with tree stem positions as **points**:

``` r
library(sf)

# Shapefile
trees <- st_read("trees.shp")

# GeoPackage
trees <- st_read("trees.gpkg")

# From CSV with coordinates
trees <- read.csv("trees.csv") %>%
  st_as_sf(coords = c("X", "Y"), crs = 2178)
```

The tree data must have an **ID column** (any name) that uniquely
identifies each tree. CRS is automatically matched during the join.
