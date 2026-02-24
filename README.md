<!-- README.md is generated from README.Rmd. Please edit that file -->

# GRootR <img src="man/figures/logo.png" align="right" height="139" />

<!-- badges: start -->
<!-- badges: end -->

## Overview

The **GRootR** package provides tools for processing and analyzing tree root system data obtained from Ground Penetrating Radar (GPR) with 3D scanning capabilities. It converts raw CSV point data into spatial segments, computes geometric and morphological metrics, and enables inter-tree competition analysis.

Developed as part of the NCN-funded project:
**"Zastosowanie georadaru ze skanerem 3D do pomiarów zmienności systemów korzeniowych sosny zwyczajnej"**
(**"Application of Ground-Penetrating Radar with 3D Scanner for Measuring Variability in Scots Pine Root Systems"**)

## Installation

```r
# install.packages("pak")
pak::pak("j-miszczyszyn/GRootR")
```

## Expected CSV structure

| Column | Description |
|---|---|
| `ROOT_ID` | Root identifier (integer, NAs filled forward) |
| `Node` | Node label within root (e.g. `"Node1"`, `"Node2"`) |
| `X.SRS.units.` | X coordinate (projected CRS) |
| `Y.SRS.units.` | Y coordinate (projected CRS) |
| `Depth.m.` | Depth in meters (positive = below surface) |
| `Survey` | *(optional)* Composite filename with plot ID |

All column names are configurable through function parameters.

## Quick start

### 1. Load and prepare data

```r
library(GRootR)

df <- prepare_root_data("path/to/roots.csv")
```

Or step by step:

```r
df <- load_root_csv("roots.csv")
df <- split_survey_column(df)
df <- convert_coordinates(df)
```

### 2. Build segments with metrics

```r
segments <- build_segments_with_metrics(df, crs = 2178)
```

### 3. Join with tree locations

```r
library(sf)
trees <- st_read("trees.shp")

joined <- join_nearest_tree(segments, trees, tree_id_col = "Name", max_dist = 1.5)
joined <- propagate_tree_name(joined, tree_id_col = "Name")
```

### 4. Root and tree level metrics

```r
joined <- calc_root_length(joined)
joined <- calc_tree_length(joined)
joined <- assign_depth_class(joined, bin_m = 0.2)

depth  <- calc_depth_stats(joined)
orient <- count_orientations(joined)
```

### 5. 2D convex hulls & area

```r
hulls <- build_convex_hulls(joined, crs = 2178)
hulls <- calc_hull_area(hulls)
```

### 6. 3D volume estimate

```r
z_range <- calc_real_z(joined)
vol     <- calc_range_3d(z_range, hulls)
```

### 7. Root system overlap

```r
overlaps <- calc_all_overlaps(hulls)
```

### 8. Root-to-trunk distance

```r
merged <- merge_root_segments(segments_with_trees)
merged <- calc_dist_to_trunk(merged, trees, tree_id_col = "Name")
```

### All-in-one tree summary

```r
summary <- summarise_tree_roots(joined, crs = 2178)
# Returns: $depth, $orientations, $hulls, $volume
```

## Function reference

### Loading & preparation
| Function | Description |
|---|---|
| `load_root_csv()` | Load CSV + fill ROOT_ID |
| `split_survey_column()` | Extract plot ID from composite column |
| `convert_coordinates()` | Convert X, Y, Z to numeric |
| `prepare_root_data()` | All-in-one loader |

### Segment creation
| Function | Description |
|---|---|
| `points_to_sf()` | Data frame → sf points (XYZ) |
| `make_segments()` | Consecutive points → line segments |
| `process_single_root()` | Process one ROOT_ID |
| `process_all_roots()` | Process all ROOT_IDs |

### Segment metrics
| Function | Description |
|---|---|
| `calc_segment_length()` | 3D Euclidean length |
| `calc_segment_azimuth()` | Bearing 0–360° |
| `calc_inclination()` | Angle from horizontal |
| `classify_slope()` | Slope category labels |
| `calc_all_segment_metrics()` | All of the above |

### Tree joining
| Function | Description |
|---|---|
| `join_nearest_tree()` | Spatial join within distance |
| `propagate_tree_name()` | Propagate tree ID to all segments of same root |

### Root / tree metrics
| Function | Description |
|---|---|
| `calc_root_length()` | Total length per ROOT_ID |
| `calc_tree_length()` | Total length per TREE_ID |
| `assign_depth_class()` | Depth bin classification |
| `calc_depth_stats()` | Max/mean depth, range per tree |
| `count_orientations()` | Vertical/horizontal segment counts |

### Polygons & volume
| Function | Description |
|---|---|
| `build_convex_hulls()` | 2D convex hull per tree |
| `calc_hull_area()` | Area + X/Y extent |
| `calc_real_z()` | Vertical range per tree |
| `calc_range_3d()` | 3D bounding volume |

### Overlap & distance
| Function | Description |
|---|---|
| `calc_all_overlaps()` | Pairwise root system overlap |
| `merge_root_segments()` | Union segments per root |
| `calc_dist_to_trunk()` | Distance root → tree stem |

## Acknowledgments

This package is developed with support from:

- Faculty of Forestry, University of Agriculture in Krakow
- Narodowe Centrum Nauki (National Science Centre, Poland)
