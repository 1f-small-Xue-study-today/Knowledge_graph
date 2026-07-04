# Skill: Implement SVSDF-Aware A* Front End

## Purpose

Build a planning front end that generates a coarse collision-aware path using A* search and SVSDF or swept-volume collision checks, then passes the result to a trajectory optimizer.

## Inputs

- Occupancy grid, point-cloud map, or other discrete environment representation.
- Robot or object shape model, including orientation-dependent footprint.
- Start and goal states.
- Map resolution, search kernel size, yaw discretization, and safety margin.
- Swept-volume or SVSDF query interface.

## Procedure

1. Initialize the grid map and precompute or cache map kernels around candidate states.
2. Define grid nodes with position, parent pointer, cost-to-come, heuristic cost, and orientation state when needed.
3. Expand A* neighbors with occupancy checks and swept-volume collision checks between the current state and candidate successor.
4. Use a distance heuristic, plus optional custom costs for clearance, smoothness, yaw change, or dynamic feasibility.
5. Reconstruct the path from parent pointers after reaching the goal.
6. Convert the grid path into pose samples or SE(3) states for mid-end orientation generation and backend trajectory optimization.
7. Publish or visualize front-end path and pose samples for debugging.

## Validation

- Confirm that the front-end path avoids discrete obstacles and swept-volume collisions.
- Check that the path provides enough waypoints for downstream trajectory optimization.
- Test sensitivity to map resolution, kernel size, yaw discretization, and safety margin.
- Compare front-end success rate and runtime across several robot shapes and obstacle layouts.
