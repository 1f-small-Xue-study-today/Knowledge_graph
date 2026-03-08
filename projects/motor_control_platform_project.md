# Project: Motor Control Platform on HC32F460

## Description

Develop a motor control platform using the HC32F460 microcontroller.  The platform should support field‑oriented control of a brushless motor, including current, speed and position loops, and incorporate sensor fusion for state estimation.

## Requirements

- Implement FOC for torque control with decoupled \(i_d\) and \(i_q\).
- Tune PID controllers for the current and speed loops.
- Implement a Kalman filter for estimating speed and current if sensors are noisy.
- Integrate hall sensor linearisation and calibration.
- Provide communication interface (UART or CAN) for parameter adjustment and telemetry.
- Validate performance across load conditions and temperatures.

## Milestones

1. **Hardware Setup:** Configure ADC, PWM and hall inputs on HC32F460.
2. **FOC Implementation:** Implement Clarke/Park transforms and current regulators.
3. **Speed Control:** Develop outer loop PID or LQR controller.
4. **Observer Design:** Implement Kalman filter or PLL for speed/angle estimation.
5. **Testing:** Perform open‑loop and closed‑loop testing, measure efficiency and response.
