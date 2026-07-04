# Project: Robot Planning Algorithms Project

## Description

Implement a suite of planning algorithms for mobile robots that generate dynamically feasible, collision-free trajectories using optimization and kinodynamic search.

## Requirements

- Develop polynomial trajectory optimization modules (e.g., MINCO).
- Implement kinodynamic planning using sampling-based or heuristic algorithms.
- Compute SVSDFs and continuous collision constraints for robust avoidance.
- Implement an SVSDF-aware A* front end that produces collision-aware path and pose initialization for the optimizer.
- Integrate components and demonstrate on simulated or physical robotic platforms.

## Milestones

1. **Trajectory Optimization:** Implement polynomial optimizers and test on simple scenarios.
2. **Kinodynamic Planning:** Develop kinodynamic planners and integrate with trajectory optimizers.
3. **SVSDF Front End:** Implement A* search with swept-volume successor checks and pose/path visualization.
4. **Collision Avoidance:** Implement SVSDF and continuous collision avoidance constraints.
5. **Integration and Demonstration:** Combine planners, optimizers and collision modules and demonstrate on a mobile robot.
