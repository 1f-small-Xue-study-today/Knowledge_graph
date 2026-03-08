# Skill: Implement FOC on HC32F460

## Purpose

Develop a complete field‑oriented control algorithm on the HC32F460 microcontroller.

## Inputs

- Phase currents from shunt resistors or hall sensors.
- Rotor electrical angle from hall sensors, encoders or sensorless observer.
- Control parameters (current and speed references).

## Procedure

1. **Signal Acquisition:** Use ADC and DMA to sample phase currents and voltage, and capture hall signals or encoder pulses.
2. **Angle Estimation:** Derive the electrical angle \(\theta_e\) using hall sensors, sensorless observer or PLL.
3. **Coordinate Transformations:** Apply Clarke and Park transforms to obtain \(i_d,i_q\).
4. **Control Loops:** Implement PI controllers for \(i_d\) and \(i_q\).  For speed control, implement an outer PID or LQR loop to generate \(i_q\) reference.
5. **Inverse Transforms:** Compute inverse Park and Clarke transforms to obtain phase voltage references.
6. **PWM Generation:** Use the timer module to generate PWM duty cycles for the inverter.
7. **Calibration:** Compensate for offset and scaling errors in current sensors and hall linearisation.

## Validation

- Measure current and speed response with an oscilloscope.
- Verify that \(i_d\) stays near zero while \(i_q\) tracks the torque command.
- Test under load changes and disturbances.
