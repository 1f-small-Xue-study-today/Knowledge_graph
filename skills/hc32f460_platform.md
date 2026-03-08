# Skill: HC32F460 MCU Platform

## Purpose

Learn to configure and program the HC32F460 microcontroller (Cortex‑M4 core) used in motor control and gimbal applications.

## Procedure

1. **Toolchain Setup:** Install the compiler (e.g., Keil or GCC), CMSIS and HAL libraries for the HC32F460.
2. **Peripheral Initialization:** Configure GPIOs, ADCs, PWM timers and communication interfaces (UART, CAN, SPI).
3. **Interrupt and DMA:** Use DMA for sampling currents and hall sensors to reduce CPU load.
4. **RTOS Integration (optional):** Set up an RTOS for scheduling control loops.
5. **Debugging:** Use SWD/JTAG for in‑circuit debugging.  Configure tracing to monitor variables.

## Notes

- Pay attention to fixed‑point versus floating‑point operations and the impact on execution time.
- Carefully manage interrupt latency for high‑frequency control loops.
