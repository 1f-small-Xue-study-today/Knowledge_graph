# Skill: Apply Robotics Kinematics and Dynamics

## Purpose

Use robotics kinematics and dynamics to model, analyze, control, and debug robot or gimbal systems.

## Inputs

- Robot geometry, frames, joint definitions, motor/actuator layout, and sensor placement.
- State variables such as pose, velocity, joint position, joint velocity, acceleration, force, and torque.
- Control or planning objective, such as trajectory tracking, disturbance rejection, collision avoidance, or model identification.

## Procedure

1. Define consistent coordinate frames and state variables.
2. Build transformations between body, world, sensor, actuator, and task frames.
3. Derive forward kinematics and, when needed, inverse kinematics.
4. Derive Jacobians for velocity mapping, wrench mapping, constraint gradients, or linearization.
5. Formulate dynamics using mass, Coriolis/centrifugal, gravity, damping, friction, and external force terms.
6. Convert the model into the form needed for control, planning, estimation, or failure analysis.
7. Validate signs, units, frame conventions, and physical plausibility against logs or simulation.

## Validation

- Check that transforms compose correctly and invert back to the original frame.
- Compare Jacobian predictions against finite-difference motion.
- Verify dynamic predictions against measured acceleration, torque/current, and response data.
- Test edge cases such as singularities, zero velocity, payload changes, and coordinate-frame sign changes.
