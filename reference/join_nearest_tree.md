# Join root segments to nearest tree

Performs a spatial join between root segments and tree point locations,
matching within a given distance threshold.

## Usage

``` r
join_nearest_tree(roots, trees, tree_id_col = "TREE_ID", max_dist = 1.5)
```

## Arguments

- roots:

  An sf object with root segments.

- trees:

  An sf point object with tree locations. Must contain a column
  identifying each tree.

- tree_id_col:

  Name of the tree identifier column in `trees`. Default `"TREE_ID"`.

- max_dist:

  Maximum distance (in CRS units) for the join. Default `1.5`.

## Value

An sf object with the tree identifier joined to matching segments.
