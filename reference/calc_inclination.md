# Calculate segment inclination angle

Angle of the segment relative to the horizontal plane, in degrees. 0 =
horizontal, 90 = vertical (downward).

## Usage

``` r
calc_inclination(segments)
```

## Arguments

- segments:

  An sf object with columns `pX, pY, pZ, kX, kY, kZ`.

## Value

The same sf object with added columns `deltaX, deltaY, deltaZ`, and
`inclination_angle`.
