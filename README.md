# Physics-Based Digital Model of an Induction Motor

[![MATLAB](https://img.shields.io/badge/MATLAB-R2019a%2B-orange?logo=mathworks&logoColor=white)](https://www.mathworks.com/products/matlab.html)
[![Simulink](https://img.shields.io/badge/Simulink-Physics--Based%20Model-blue?logo=mathworks&logoColor=white)](https://www.mathworks.com/products/simulink.html)
[![Model](https://img.shields.io/badge/Model-Induction%20Motor-success)](#model-description)
[![Reproducibility](https://img.shields.io/badge/Reproducibility-Documented-brightgreen)](#reproducibility-protocol)
[![License](https://img.shields.io/badge/License-Not%20specified-lightgrey)](#license)

A physics-based MATLAB/Simulink project for modelling the dynamic behaviour of a three-phase induction motor in rotating \(d\!-\!q\) and stationary \(\alpha\!-\!\beta\) reference frames. The core model represents electrical, magnetic, and mechanical dynamics, and includes open-loop and closed-loop V/f control configurations.

> **Scientific scope.** This repository contains a simulation-based physical model. It is not a field-connected Digital Twin and has not been validated against experimental or industrial measurements. Its purpose is to provide a transparent and reproducible physical baseline for future condition-monitoring or Digital Twin work.

---## Table of Contents

- [Scientific Context and Objectives](#scientific-context-and-objectives)
- [Model Description](#model-description)
- [Repository Structure](#repository-structure)
- [Author Contribution](#author-contribution)
- [Software Requirements](#software-requirements)
- [Model Parameters](#model-parameters)
- [Simulation Scenarios](#simulation-scenarios)
- [Reproducibility Protocol](#reproducibility-protocol)
- [Outputs and Result Interpretation](#outputs-and-result-interpretation)
- [Figures and Visual Assets](#figures-and-visual-assets)
- [Known Limitations](#known-limitations)
- [Future Improvements](#future-improvements)
- [License](#license)

---
## Scientific Context and Objectives

Induction motors are widely used in industrial rotating equipment. Their behaviour results from the coupling of electrical excitation, electromagnetic torque generation, rotor flux dynamics, inertia, friction, and mechanical load.

The project aims to:

1. Implement a transparent physics-based induction-motor model in MATLAB/Simulink.
2. Represent the machine dynamics in the \(d\!-\!q\) synchronous reference frame.
3. Simulate three-phase supply, Park transformation, electromagnetic torque, rotor flux, stator currents, and mechanical speed.
4. Compare open-loop and closed-loop V/f control structures.
5. Export simulated signals for analysis of speed, torque, current, and flux responses.
6. Establish a reproducible physical baseline for later work on condition monitoring and hybrid Digital Twins.

---

## Model Description

The core induction-motor model is implemented in:

```text
IM/IM_d-q/IM_d_q.slx
```

The state-space implementation uses the form:

\[
\dot{x} = A_1x + \omega_r A_2x + Bu
\]

where:

- \(x\) contains electrical states, including stator-current and rotor-flux components;
- \(u = [V_{sd}, V_{sq}]^T\) contains the stator-voltage components in the rotating reference frame;
- \(A_1\), \(A_2\), and \(B\) are calculated from the machine parameters;
- \(\omega_r\) is rotor speed.

The mechanical subsystem follows the torque balance:

\[
J\frac{d\omega_r}{dt} + f\omega_r = C_{em} - C_r
\]

where:

- \(J\) is rotor inertia;
- \(f\) is viscous-friction coefficient;
- \(C_{em}\) is electromagnetic torque;
- \(C_r\) is load torque.

The electromagnetic torque is computed from the interaction between stator-current and rotor-flux components, using the model gain:

\[
\frac{3}{2}\frac{pM}{L_r}
\]

### Signal Flow

```text
Three-phase supply
        ↓
Park transformation
        ↓
d-q stator voltages
        ↓
Electrical state-space model
        ↓
Rotor flux + stator currents
        ↓
Electromagnetic torque
        ↓
Mechanical dynamics
        ↓
Rotor speed, torque, currents, and flux outputs
```

---

## Repository Structure

```text
.
├── IM/
│   ├── IM_d-q/
│   │   ├── IM_d_q.m                 # Parameters and state-space matrices for the IM d-q model
│   │   └── IM_d_q.slx               # Core induction-motor d-q Simulink model
│   │
│   ├── PMSM_alpha_beta/
│   │   ├── MS_alpha_beta_.m         # Parameters for alpha-beta synchronous-machine exploration
│   │   └── MS_alpha_beta.slx        # Alpha-beta model
│   │
│   └── PMSM_d_q/
│       ├── PMSM_d_q.m               # Parameters for d-q synchronous-machine exploration
│       └── PMSM_d_q_sim2.slx        # d-q synchronous-machine model
│
├── V_F_Control/
│   ├── parametre_IM.m               # Induction-motor parameter initialisation for V/f models
│   ├── IM_Open_loop.slx             # Open-loop V/f control model
│   └── IM_close-loop.slx            # Closed-loop V/f control model
│
└── docs/                            # Recommended folder for GitHub packaging
    ├── images/
    └── media/
```

> The induction-motor \(d\!-\!q\) model and the V/f control models form the core reproducibility path. The synchronous-machine files are supplementary exploratory models and are not required to reproduce the main induction-motor simulations.

---

## Author Contribution

My contribution to this project includes:

- Implementing the induction-motor \(d\!-\!q\) state-space equations and associated parameter matrices \(A_1\), \(A_2\), and \(B\).
- Developing the Simulink architecture for three-phase supply, Park transformation, electrical dynamics, torque calculation, mechanical dynamics, and signal export.
- Configuring the open-loop and closed-loop V/f control structures.
- Integrating inverter, voltage-reference, speed-reference, saturation, and PID-control blocks.
- Defining speed-reference and load-torque inputs for transient simulations.
- Exporting and analysing simulated electromagnetic torque, rotor speed, stator currents, and flux signals.
- Documenting the model assumptions, parameter values, scenario settings, and reproducibility checks.

---

## Software Requirements

| Requirement | Recommended version | Notes |
|---|---:|---|
| MATLAB | R2019a or later | R2019a is the latest release identified in the supplied model metadata. |
| Simulink | R2019a or later | Required to open and run `.slx` files. |
| Control System Toolbox | Optional | Not required for the core state-space implementation. |
| Simscape Electrical | Not required | No Simscape Electrical dependency was identified in the supplied core models. |

Older model metadata identifies some files as originating from MATLAB R2014a. Open models in R2019a or later and save upgraded copies separately if Simulink requests an upgrade.

---

## Model Parameters

### Core Induction-Motor Parameters

Values below are read from `V_F_Control/parametre_IM.m`.

| Parameter | Symbol | Value | Unit | Description |
|---|---:|---:|---|---|
| Stator supply voltage | \(V_s\) | 220 | V | Nominal voltage used by the V/f parameter script |
| Stator resistance | \(R_s\) | 1.8 | \(\Omega\) | Stator winding resistance |
| Rotor resistance | \(R_r\) | 1.8 | \(\Omega\) | Rotor winding resistance |
| Stator inductance | \(L_s\) | 0.1554 | H | Stator cyclic inductance |
| Rotor inductance | \(L_r\) | 0.1568 | H | Rotor cyclic inductance |
| Mutual inductance | \(M\) | 0.15 | H | Mutual inductance |
| Rotor inertia | \(J\) | 0.07 | kg·m² | Mechanical inertia |
| Friction coefficient | \(f\) | 0 | SI | Viscous-friction coefficient |
| Model parameter | \(p\) | 2 | — | Used in torque and speed conversion blocks |

Derived quantities include:

\[
\sigma = 1 - \frac{M^2}{L_sL_r}
\]

\[
T_r = \frac{L_r}{R_r}
\]

\[
T_s = \frac{L_s}{R_s}
\]

### Nameplate Reference Data

The accompanying input-data figure provides the following nominal reference values.

| Quantity | Value |
|---|---:|
| Rated power | 4 kW |
| Nominal voltage | 220/380 V |
| Nominal current | 15 A |
| Number of poles | 2 |
| Power factor | 0.8 |
| Rated speed | 1500 rpm |

### Parameter Reconciliation Check

Before publishing simulation results, reconcile the following values:

| Item | Value in supplied visual data | Value in supplied MATLAB script | Required action |
|---|---:|---:|---|
| Stator resistance \(R_s\) | 1.2 \(\Omega\) | 1.8 \(\Omega\) | Select and document the authoritative value. |
| Supply voltage \(V_s\) | 220/380 V | 220 V in `parametre_IM.m`; 200 V in `IM_d_q.m` | State the voltage convention used in each simulation. |
| Load-step timing | Not specified in visual data | Some stored Step blocks omit an explicit time | Set and report a deliberate load-step time before comparative runs. |

---

## Simulation Scenarios

| Model | Purpose | Stored configuration | Reproducibility note |
|---|---|---|---|
| `IM_d_q.slx` | Core induction-motor physical model | 0–1 s, `ode3`, fixed step \(10^{-4}\) s | Includes a load-torque block `Cr` with final value 15. Set an explicit step time, e.g. 0.5 s, for transient analysis. |
| `IM_Open_loop.slx` | Open-loop V/f control | Speed reference: \(2\pi \times 25\) to \(2\pi \times 50\) rad/s at 5 s; default stop time: 1 s | The stored speed step occurs after the default simulation horizon. Increase stop time to at least 6 s or move the step inside the horizon. |
| `IM_close-loop.slx` | Closed-loop V/f control with PID block | Speed reference: \(2\pi \times 50\) to \(2\pi \times 100\) rad/s at 0.5 s; stop time: 1 s | The speed step is inside the default simulation horizon. |
| `MS_alpha_beta.slx` | Supplementary alpha-beta exploration | 0–100 s, `ode3`, fixed step \(10^{-4}\) s | Stored load step is at 300 s; it is outside the default horizon. |
| `PMSM_d_q_sim2.slx` | Supplementary synchronous-machine exploration | Step at 0.2 s | Not part of the core induction-motor reproducibility path. |

---
