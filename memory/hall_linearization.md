# Memory: Hall Linearization

Hall sensors provide coarse rotor position information.  To improve resolution, a linearisation table is used.

## Calibration Details

- **Table size:** 256 points covering one electrical cycle.
- **Pole pairs:** 7.
- **Wrap hysteresis:** 1000 (counts used to debounce wrap‑around).
- **Method:** Measure the time intervals between hall transitions over one mechanical revolution.  Create a lookup table mapping timer counts to a linearised electrical angle.  Wrap the index after the 256th entry.

## Usage

During runtime, read the time since the last hall event, look up the corresponding angle increment in the table, and add it to the last commutation angle.  This provides a continuous angle estimate for FOC.