# GRootR 0.1.0

## New Features

- **Data loading**: `load_root_csv()`, `split_survey_column()`, `convert_coordinates()`, `prepare_root_data()` for importing and cleaning GPR CSV data.
- **Segment creation**: `points_to_sf()`, `make_segments()`, `process_single_root()`, `process_all_roots()` for converting root points into spatial line segments.
- **Segment metrics**: `calc_segment_length()`, `calc_segment_azimuth()`, `calc_inclination()`, `classify_slope()`, `calc_all_segment_metrics()` for geometric analysis.
- **Tree joining**: `join_nearest_tree()`, `propagate_tree_name()` for linking root segments to tree stem positions.
- **Root/tree metrics**: `calc_root_length()`, `calc_tree_length()`, `assign_depth_class()`, `calc_depth_stats()`, `count_orientations()` for aggregated statistics.
- **2D polygons**: `build_convex_hulls()`, `calc_hull_area()` for root system spread estimation.
- **3D volume**: `calc_real_z()`, `calc_range_3d()` for bounding volume estimation.
- **Overlap analysis**: `calc_all_overlaps()` for inter-tree root competition.
- **Distance**: `merge_root_segments()`, `calc_dist_to_trunk()` for root-to-trunk measurements.
- **Pipeline wrappers**: `build_segments_with_metrics()`, `summarise_tree_roots()` for streamlined workflows.

## Project Context

This package is part of the research project:
**"Zastosowanie georadaru ze skanerem 3D do pomiarów zmienności systemów korzeniowych sosny zwyczajnej"**
(**"Application of Ground-Penetrating Radar with 3D Scanner for Measuring Variability in Scots Pine Root Systems"**)

- **Project number**: G-1447/WL/24-25
- **Funding agency**: Narodowe Centrum Nauki (National Science Centre, Poland)
- **Principal investigator**: Dr inż. Luiza Tymińska-Czabańska

# GRootR 0.0.0.9000

- Initial package skeleton — name reservation on GitHub.
