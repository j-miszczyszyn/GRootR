# Calculate hull area and extent

Computes the area of each convex hull polygon and the X/Y extent
(bounding box width and height).

## Usage

``` r
calc_hull_area(hulls)
```

## Arguments

- hulls:

  An sf object with convex hull polygons, as returned by
  [`build_convex_hulls()`](https://j-miszczyszyn.github.io/GRootR/reference/build_convex_hulls.md).

## Value

The same sf object with added columns: `area_2d`, `extent_x`,
`extent_y`.
