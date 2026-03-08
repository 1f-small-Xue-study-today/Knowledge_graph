# Quaternion Mathematics

## Overview

Quaternions provide a compact representation of 3D rotations without singularities.  A quaternion is \(q = w + x\,i + y\,j + z\,k\) with unit norm.

## Operations

- **Multiplication:** Combines two rotations.  Quaternion multiplication is non‑commutative.
- **Conjugate:** For \(q=[w,x,y,z]\), the conjugate is \(q^\ast=[w,-x,-y,-z]\).  Inverts the rotation.
- **Rotation of a vector:** For vector \(v\) represented as \(0+v_x i + v_y j + v_z k\), the rotated vector is \(v' = q v q^\ast\).

## Properties

- Unit quaternions lie on the 4D unit hypersphere.
- Avoid gimbal lock inherent in Euler angles.
