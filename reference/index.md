# Package index

## Loading & Preparation

Import raw GPR root CSV data and prepare coordinates.

- [`load`](https://j-miszczyszyn.github.io/GRootR/reference/load.md) :
  Load and Prepare Root Data
- [`load_root_csv()`](https://j-miszczyszyn.github.io/GRootR/reference/load_root_csv.md)
  : Load GPR root CSV file
- [`split_survey_column()`](https://j-miszczyszyn.github.io/GRootR/reference/split_survey_column.md)
  : Split survey column
- [`convert_coordinates()`](https://j-miszczyszyn.github.io/GRootR/reference/convert_coordinates.md)
  : Convert coordinate columns to numeric
- [`prepare_root_data()`](https://j-miszczyszyn.github.io/GRootR/reference/prepare_root_data.md)
  : Load and prepare root data from CSV

## Segment Creation

Convert root node points into spatial line segments.

- [`segments`](https://j-miszczyszyn.github.io/GRootR/reference/segments.md)
  : Create Root Segments
- [`points_to_sf()`](https://j-miszczyszyn.github.io/GRootR/reference/points_to_sf.md)
  : Convert root points to sf object
- [`make_segments()`](https://j-miszczyszyn.github.io/GRootR/reference/make_segments.md)
  : Build line segments between consecutive root nodes
- [`process_single_root()`](https://j-miszczyszyn.github.io/GRootR/reference/process_single_root.md)
  : Process a single root into segments
- [`process_all_roots()`](https://j-miszczyszyn.github.io/GRootR/reference/process_all_roots.md)
  : Process all roots into segments

## Segment Metrics

Calculate geometric properties for each root segment.

- [`segment_metrics`](https://j-miszczyszyn.github.io/GRootR/reference/segment_metrics.md)
  : Segment Geometric Metrics
- [`calc_segment_length()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_segment_length.md)
  : Calculate segment 3D length
- [`calc_segment_azimuth()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_segment_azimuth.md)
  : Calculate segment azimuth
- [`calc_inclination()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_inclination.md)
  : Calculate segment inclination angle
- [`classify_slope()`](https://j-miszczyszyn.github.io/GRootR/reference/classify_slope.md)
  : Classify segment slope
- [`calc_all_segment_metrics()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_all_segment_metrics.md)
  : Calculate all segment metrics at once

## Tree Joining

Link root segments to tree stem positions.

- [`trees`](https://j-miszczyszyn.github.io/GRootR/reference/trees.md) :
  Join Roots with Tree Locations
- [`join_nearest_tree()`](https://j-miszczyszyn.github.io/GRootR/reference/join_nearest_tree.md)
  : Join root segments to nearest tree
- [`propagate_tree_name()`](https://j-miszczyszyn.github.io/GRootR/reference/propagate_tree_name.md)
  : Propagate tree name to all segments of the same root

## Root & Tree Metrics

Aggregate segment data at root and tree level.

- [`root_metrics`](https://j-miszczyszyn.github.io/GRootR/reference/root_metrics.md)
  : Root and Tree Level Metrics
- [`calc_root_length()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_root_length.md)
  : Calculate total length per root
- [`calc_tree_length()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_tree_length.md)
  : Calculate total root length per tree
- [`assign_depth_class()`](https://j-miszczyszyn.github.io/GRootR/reference/assign_depth_class.md)
  : Assign depth class
- [`calc_depth_stats()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_depth_stats.md)
  : Calculate depth statistics per tree
- [`count_orientations()`](https://j-miszczyszyn.github.io/GRootR/reference/count_orientations.md)
  : Count segment orientations per tree

## 2D Polygons

Convex hull polygons representing root system spread.

- [`polygons`](https://j-miszczyszyn.github.io/GRootR/reference/polygons.md)
  : 2D Root System Polygons
- [`build_convex_hulls()`](https://j-miszczyszyn.github.io/GRootR/reference/build_convex_hulls.md)
  : Build convex hull polygons per tree
- [`calc_hull_area()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_hull_area.md)
  : Calculate hull area and extent

## 3D Volume

Estimate 3D bounding volume of root systems.

- [`volume`](https://j-miszczyszyn.github.io/GRootR/reference/volume.md)
  : 3D Root System Volume
- [`calc_real_z()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_real_z.md)
  : Calculate real vertical range per tree
- [`calc_range_3d()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_range_3d.md)
  : Calculate 3D bounding volume

## Overlap & Distance

Inter-tree competition and root-to-trunk distances.

- [`overlap`](https://j-miszczyszyn.github.io/GRootR/reference/overlap.md)
  : Root System Overlap Analysis
- [`make_tree_pairs()`](https://j-miszczyszyn.github.io/GRootR/reference/make_tree_pairs.md)
  : Generate unique tree pairs
- [`calc_pair_overlap()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_pair_overlap.md)
  : Calculate overlap between two geometries
- [`calc_all_overlaps()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_all_overlaps.md)
  : Calculate all pairwise root system overlaps
- [`distance`](https://j-miszczyszyn.github.io/GRootR/reference/distance.md)
  : Root-to-Trunk Distance
- [`merge_root_segments()`](https://j-miszczyszyn.github.io/GRootR/reference/merge_root_segments.md)
  : Merge root segments into single geometries
- [`calc_dist_to_trunk()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_dist_to_trunk.md)
  : Calculate distance from each root to its tree trunk

## Pipeline Wrappers

Convenience functions chaining multiple steps.

- [`pipeline`](https://j-miszczyszyn.github.io/GRootR/reference/pipeline.md)
  : Processing Pipelines
- [`build_segments_with_metrics()`](https://j-miszczyszyn.github.io/GRootR/reference/build_segments_with_metrics.md)
  : Full segment pipeline
- [`summarise_tree_roots()`](https://j-miszczyszyn.github.io/GRootR/reference/summarise_tree_roots.md)
  : Tree-level summary pipeline
- [`GRootR`](https://j-miszczyszyn.github.io/GRootR/reference/GRootR-package.md)
  [`GRootR-package`](https://j-miszczyszyn.github.io/GRootR/reference/GRootR-package.md)
  : GRootR: 3D Visualization and Statistical Analysis of Tree Roots from
  GPR
