# RANSAC Homography Implementation Demo

Purpose: re-implement homography estimation with RANSAC in MATLAB.

Status: implemented.

## Reference example

The `example/` folder contains source code from the referenced homography-estimation project. The copied image assets are stored in `data/`.

- `example/`: source files and project documentation.
- `data/`: image-only example assets.

Expected entry point:

```text
scripts/run_homography_implement_demo.m
```

The main implementation is:

```text
scripts/main.m
functions/ransacHomography.m
```

Running the script writes keypoint, match, inlier-match, stitched panorama,
point-map CSV, and info text outputs into a timestamped folder under
`figures/`.
