# Segment Metrics Explained

## From points to segments

GPR root detection produces a series of **nodes** (3D points) along each
detected root. GRootR connects consecutive nodes into **line segments**,
and computes geometric properties for each segment.

    Root points:    ●────●────●────●────●
                    N1   N2   N3   N4   N5

    Segments:       ├─S1─┤─S2─┤─S3─┤─S4─┤

Each segment is defined by a start point (`pX, pY, pZ`) and an end point
(`kX, kY, kZ`).

## 3D Length (`length_3d`)

Euclidean distance in 3D space between start and end points:

$$\text{length\_3d} = \sqrt{(\Delta X)^{2} + (\Delta Y)^{2} + (\Delta Z)^{2}}$$

Computed by
[`calc_segment_length()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_segment_length.md).
Units follow the CRS (typically meters).

## Azimuth (`azimuth`)

Horizontal bearing from the start point to the end point, measured
clockwise from north (0°–360°):

$$\text{azimuth} = \text{atan2}(\Delta X,\Delta Y) \cdot \frac{180}{\pi}{\mspace{8mu}\operatorname{mod}\ 360}$$

Computed by
[`calc_segment_azimuth()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_segment_azimuth.md).

Interpretation:

| Azimuth   | Direction |
|-----------|-----------|
| 0° / 360° | North     |
| 90°       | East      |
| 180°      | South     |
| 270°      | West      |

This metric describes the **horizontal direction** the root segment
grows in. Useful for analyzing preferred root growth directions (e.g.,
toward water sources, away from competing trees).

## Inclination angle (`inclination_angle`)

Angle of the segment relative to the horizontal plane, in degrees:

$$\text{inclination} = \text{atan}\left( \frac{\Delta Z}{\sqrt{\Delta X^{2} + \Delta Y^{2}}} \right) \cdot \frac{180}{\pi}$$

Computed by
[`calc_inclination()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_inclination.md).

- **0°** = perfectly horizontal
- **-90°** = vertical (straight down)
- **-45°** = 45° angle downward

Negative values indicate downward growth. The sign follows the Z axis
convention where below-surface is negative.

## Slope category (`slope_category`)

Classification of segments based on absolute inclination angle. Computed
by
[`classify_slope()`](https://j-miszczyszyn.github.io/GRootR/reference/classify_slope.md):

| Category       | Absolute angle range | Description                 |
|----------------|----------------------|-----------------------------|
| `"horizontal"` | 0°–15°               | Nearly flat, lateral growth |
| `"slight"`     | 15°–30°              | Gently angled               |
| `"moderate"`   | 30°–45°              | Intermediate angle          |
| `"steep"`      | 45°–75°              | Steeply angled              |
| `"vertical"`   | 75°–90°              | Nearly straight down        |

The thresholds and labels are customizable:

``` r
segments <- classify_slope(
  segments,
  breaks = c(10, 25, 50, 80),
  labels = c("flat", "gentle", "angled", "steep", "plunging")
)
```

## Orientation (`orientation`)

Binary classification: `"vertical"` if absolute inclination \> 45°,
`"horizontal"` otherwise. Used for counting proportions of vertical vs
horizontal root growth per tree.

## Applying all metrics at once

[`calc_all_segment_metrics()`](https://j-miszczyszyn.github.io/GRootR/reference/calc_all_segment_metrics.md)
runs all four calculations in sequence:

``` r
segments <- calc_all_segment_metrics(segments)

# Equivalent to:
segments <- calc_segment_length(segments)
segments <- calc_segment_azimuth(segments)
segments <- calc_inclination(segments)
segments <- classify_slope(segments)
```

## Depth class (`depth_class`)

Not a segment metric per se, but applied at the segment level.
[`assign_depth_class()`](https://j-miszczyszyn.github.io/GRootR/reference/assign_depth_class.md)
bins each segment’s start depth into classes:

``` r
# Default: 20 cm bins
segments <- assign_depth_class(segments, bin_m = 0.2)

# Result: 0, 20, 40, 60, 80, ... (in cm)
```

This enables analysis of root density and orientation by depth layer.
