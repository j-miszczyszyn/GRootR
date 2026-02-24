# Changelog

## GRootR 0.1.0

### New Features

- **Data loading**:
  [`load_root_csv()`](https://j-miszczyszyn.github.io/GRootR/reference/load_root_csv.md),
  [`split_survey_column()`](https://j-miszczyszyn.github.io/GRootR/reference/split_survey_column.md),
  [`convert_coordinates()`](https://j-miszczyszyn.github.io/GRootR/reference/convert_coordinates.md),
  [`prepare_root_data()`](https://j-miszczyszyn.github.io/GRootR/reference/prepare_root_data.md)
  for importing and cleaning GPR CSV data.
- **Segment creation**:
  [`points_to_sf()`](https://j-miszczyszyn.github.io/GRootR/reference/points_to_sf.md),
  [`make_segments()`](https://j-miszczyszyn.github.io/GRootR/reference/make_segments.md),
  [`process_single_root()`](https://j-miszczyszyn.github.io/GRootR/reference/process_single_root.md),
  [`process_all_roots()`](https://j-miszczyszyn.github.io/GRootR/reference/process_all_roots.md)
  for converting root points into spatial line segments.
- **Segment metrics**:
  [`calc_segment_length()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_segment_length.md),
  [`calc_segment_azimuth()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_segment_azimuth.md),
  [`calc_inclination()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_inclination.md),
  [`classify_slope()`](https://j-miszczyszyn.github.io/GRootR/reference/classify_slope.md),
  [`calc_all_segment_metrics()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_all_segment_metrics.md)
  for geometric analysis.
- **Tree joining**:
  [`join_nearest_tree()`](https://j-miszczyszyn.github.io/GRootR/reference/join_nearest_tree.md),
  [`propagate_tree_name()`](https://j-miszczyszyn.github.io/GRootR/reference/propagate_tree_name.md)
  for linking root segments to tree stem positions.
- **Root/tree metrics**:
  [`calc_root_length()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_root_length.md),
  [`calc_tree_length()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_tree_length.md),
  [`assign_depth_class()`](https://j-miszczyszyn.github.io/GRootR/reference/assign_depth_class.md),
  [`calc_depth_stats()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_depth_stats.md),
  [`count_orientations()`](https://j-miszczyszyn.github.io/GRootR/reference/count_orientations.md)
  for aggregated statistics.
- **2D polygons**:
  [`build_convex_hulls()`](https://j-miszczyszyn.github.io/GRootR/reference/build_convex_hulls.md),
  [`calc_hull_area()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_hull_area.md)
  for root system spread estimation.
- **3D volume**:
  [`calc_real_z()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_real_z.md),
  [`calc_range_3d()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_range_3d.md)
  for bounding volume estimation.
- **Overlap analysis**:
  [`calc_all_overlaps()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_all_overlaps.md)
  for inter-tree root competition.
- **Distance**:
  [`merge_root_segments()`](https://j-miszczyszyn.github.io/GRootR/reference/merge_root_segments.md),
  [`calc_dist_to_trunk()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_dist_to_trunk.md)
  for root-to-trunk measurements.
- **Pipeline wrappers**:
  [`build_segments_with_metrics()`](https://j-miszczyszyn.github.io/GRootR/reference/build_segments_with_metrics.md),
  [`summarise_tree_roots()`](https://j-miszczyszyn.github.io/GRootR/reference/summarise_tree_roots.md)
  for streamlined workflows.

### Project Context

This package is part of the research project: **“Zastosowanie georadaru
ze skanerem 3D do pomiarów zmienności systemów korzeniowych sosny
zwyczajnej”** (**“Application of Ground-Penetrating Radar with 3D
Scanner for Measuring Variability in Scots Pine Root Systems”**)

- **Project number**: G-1447/WL/24-25
- **Funding agency**: Narodowe Centrum Nauki (National Science Centre,
  Poland)
- **Principal investigator**: Dr inż. Luiza Tymińska-Czabańska

## GRootR 0.0.0.9000

- Initial package skeleton — name reservation on GitHub.
