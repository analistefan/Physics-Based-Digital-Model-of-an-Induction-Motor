# Physics-Based Model of a Three-Phase Induction Motor

[![MATLAB](https://img.shields.io/badge/MATLAB-R2019a%20compatible-orange?logo=mathworks&logoColor=white)](https://www.mathworks.com/products/matlab.html)
[![Simulink](https://img.shields.io/badge/Simulink-Model-blue?logo=mathworks&logoColor=white)](https://www.mathworks.com/products/simulink.html)
[![Model](https://img.shields.io/badge/Model-Physics--Based-success)](#model-description)
[![License](https://img.shields.io/badge/License-Not%20specified-lightgrey)](#license)

MATLAB/Simulink academic project implementing dynamic models of electrical machines. The main work is a physics-based model of a three-phase induction motor in the synchronous $d$-$q$ reference frame, together with open-loop and closed-loop V/f control models.

## Contents

- [Project Scope](#project-scope)
- [Repository Contents](#repository-contents)
- [Model Description](#model-description)
- [Implemented Equations](#implemented-equations)
- [Model Parameters](#model-parameters)
- [Simulation Models and Configurations](#simulation-models-and-configurations)
- [Reproducing the Simulations](#reproducing-the-simulations)
- [Available Outputs](#available-outputs)
- [Project Figures](#project-figures)
- [Scope and Limitations](#scope-and-limitations)
- [License](#license)

## Project Scope

The project models the dynamic behaviour of an induction motor from its electrical and mechanical parameters. The main induction-motor model includes:

- a three-phase voltage source;
- a Park transformation from $abc$ to $d$-$q$ coordinates;
- stator-current and rotor-flux state dynamics;
- electromagnetic-torque calculation;
- rotor mechanical dynamics;
- load-torque input;
- signal visualisation and workspace export.

The repository also contains separate $d$-$q$ and $\alpha$-$\beta$ models for synchronous machines. These files are included as supplementary academic work; they are not required to run the main induction-motor model.

## Repository Contents

```text
.
├── IM/
│   ├── IM_d-q/
│   │   ├── IM_d_q.m
│   │   └── IM_d_q.slx
│   │
│   ├── PMSM_alpha_beta/
│   │   ├── MS_alpha_beta_.m
│   │   └── MS_alpha_beta.slx
│   │
│   └── PMSM_d_q/
│       ├── PMSM_d_q.m
│       └── PMSM_d_q_sim2.slx
│
└── V_F_Control/
    ├── parametre_IM.m
    ├── IM_Open_loop.slx
    └── IM_close-loop.slx
```

| File | Description |
|---|---|
| `IM/IM_d-q/IM_d_q.m` | Defines the parameters and matrices used by the induction-motor $d$-$q$ model. |
| `IM/IM_d-q/IM_d_q.slx` | Main Simulink model of the induction motor. |
| `V_F_Control/parametre_IM.m` | Defines induction-motor parameters for the V/f control models. |
| `V_F_Control/IM_Open_loop.slx` | Open-loop V/f control model. |
| `V_F_Control/IM_close-loop.slx` | Closed-loop V/f control model with a PID Controller block. |
| `IM/PMSM_d_q/` | Supplementary synchronous-machine model in $d$-$q$ coordinates. |
| `IM/PMSM_alpha_beta/` | Supplementary synchronous-machine model in $\alpha$-$\beta$ coordinates. |

## Model Description

The main model is located in:

```text
IM/IM_d-q/IM_d_q.slx
```

The three-phase source generates $V_a$, $V_b$, and $V_c$. These voltages are transformed into synchronous-reference-frame components $V_{sd}$ and $V_{sq}$ using the Park transformation.

The induction-motor state vector is:

$$
x =
\begin{bmatrix}
i_{sd} &
i_{sq} &
\phi_{rd} &
\phi_{rq}
\end{bmatrix}^{T}
$$

where:

- $i_{sd}$ and $i_{sq}$ are stator-current components;
- $\phi_{rd}$ and $\phi_{rq}$ are rotor-flux components.

The model calculates the state derivatives, integrates them, computes electromagnetic torque, and applies the mechanical equation to obtain rotor speed.

```text
Three-phase source
        ↓
Park transformation
        ↓
d-q stator voltages
        ↓
Electrical state-space model
        ↓
Stator currents and rotor flux
        ↓
Electromagnetic torque
        ↓
Mechanical dynamics
        ↓
Rotor speed and exported signals
```

## Implemented Equations

### Park Transformation

The Simulink model calculates the $d$-$q$ stator-voltage components from the three-phase voltages:

$$
V_{sd} =
\sqrt{\frac{2}{3}}
\left[
V_a\cos(\theta)
+
V_b\cos\left(\theta-\frac{2\pi}{3}\right)
+
V_c\cos\left(\theta+\frac{2\pi}{3}\right)
\right]
$$

$$
V_{sq} =
-\sqrt{\frac{2}{3}}
\left[
V_a\sin(\theta)
+
V_b\sin\left(\theta-\frac{2\pi}{3}\right)
+
V_c\sin\left(\theta+\frac{2\pi}{3}\right)
\right]
$$

### Electrical State-Space Model

The electrical dynamics are implemented as:

$$
\dot{x} = A_1x + \omega_r A_2x + Bu
$$

with:

$$
u =
\begin{bmatrix}
V_{sd} \\
V_{sq}
\end{bmatrix}
$$

The script defines:

$$
\sigma = 1 - \frac{M^2}{L_sL_r}
$$

$$
T_r = \frac{L_r}{R_r}
$$

$$
\lambda_1 = \frac{R_s}{\sigma L_s}
$$

$$
\lambda_2 =
\frac{R_rM^2}{\sigma L_sL_r^2}
$$

$$
\lambda = \lambda_1 + \lambda_2
$$

$$
k_s = \frac{M}{\sigma L_sL_r}
$$

The state matrices implemented in `IM_d_q.m` are:

$$
A_1 =
\begin{bmatrix}
-\lambda & \omega_s & \frac{k_s}{T_r} & 0 \\
-\omega_s & -\lambda & 0 & \frac{k_s}{T_r} \\
\frac{M}{T_r} & 0 & -\frac{1}{T_r} & \omega_s \\
0 & \frac{M}{T_r} & -\omega_s & -\frac{1}{T_r}
\end{bmatrix}
$$

$$
A_2 =
\begin{bmatrix}
0 & 0 & 0 & k_s \\
0 & 0 & -k_s & 0 \\
0 & 0 & 0 & -1 \\
0 & 0 & 1 & 0
\end{bmatrix}
$$

$$
B =
\begin{bmatrix}
\frac{1}{L_s\sigma} & 0 \\
0 & \frac{1}{L_s\sigma} \\
0 & 0 \\
0 & 0
\end{bmatrix}
$$

### Mechanical Dynamics

Rotor speed is obtained from the mechanical torque balance:

$$
J\frac{d\omega_r}{dt} + f\omega_r = C_{em} - C_r
$$

where:

| Symbol | Description |
|---|---|
| $J$ | Rotor inertia |
| $f$ | Viscous-friction coefficient |
| $C_{em}$ | Electromagnetic torque |
| $C_r$ | Load torque |
| $\omega_r$ | Rotor mechanical angular speed |

The electromagnetic-torque subsystem combines the $d$-$q$ stator-current and rotor-flux signals, then applies the gain:

$$
\frac{3}{2}\frac{pM}{L_r}
$$

## Model Parameters

### Parameters in `IM_d_q.m`

| Parameter | Value | Unit |
|---|---:|---|
| $V_s$ | 200 | V |
| $R_s$ | 1.8 | $\Omega$ |
| $R_r$ | 1.8 | $\Omega$ |
| $L_s$ | 0.1554 | H |
| $L_r$ | 0.1568 | H |
| $M$ | 0.15 | H |
| $J$ | 0.07 | kg·m² |
| $f$ | 0 | — |
| $p$ | 2 | — |
| $\omega_s$ | $2\pi \times 50$ | rad/s |

### Parameters in `parametre_IM.m`

| Parameter | Value | Unit |
|---|---:|---|
| $V_s$ | 220 | V |
| $R_s$ | 1.8 | $\Omega$ |
| $R_r$ | 1.8 | $\Omega$ |
| $L_s$ | 0.1554 | H |
| $L_r$ | 0.1568 | H |
| $M$ | 0.15 | H |
| $J$ | 0.07 | kg·m² |
| $f$ | 0 | — |
| $p$ | 2 | — |

### Reference Data Shown in the Project Documentation

| Quantity | Value |
|---|---:|
| Rated power | 4 kW |
| Nominal voltage | 220/380 V |
| Nominal current | 15 A |
| Number of poles | 2 |
| Power factor | 0.8 |
| Rated speed | 1500 rpm |
| Stator resistance | 1.2 $\Omega$ |
| Rotor resistance | 1.8 $\Omega$ |
| Stator inductance | 0.1554 H |
| Rotor inductance | 0.1568 H |
| Mutual inductance | 0.15 H |
| Rotor inertia | 0.07 kg·m² |

> The supplied input-data figure lists $R_s = 1.2\ \Omega$, whereas the MATLAB scripts use $R_s = 1.8\ \Omega$. This README reports both values exactly as they appear in the available project material.

## Simulation Models and Configurations

| Model | Simulation setup recorded in the model |
|---|---|
| `IM_d_q.slx` | Start time: 0 s; stop time: 1 s; solver: `ode3`; fixed step: $10^{-4}$ s |
| `IM_Open_loop.slx` | Start time: 0 s; stop time: 1 s; solver: `ode3`; fixed step: $10^{-4}$ s |
| `IM_close-loop.slx` | Start time: 0 s; stop time: 1 s; fixed-step configuration: $10^{-5}$ s |
| `MS_alpha_beta.slx` | Start time: 0 s; stop time: 100 s; solver: `ode3`; fixed step: $10^{-4}$ s |

### Stored Reference and Load Inputs

| Model | Input block | Stored values |
|---|---|---|
| `IM_d_q.slx` | `Cr` | Final value: 15 |
| `IM_Open_loop.slx` | `Wsref` | $2\pi \times 25$ rad/s before 5 s; $2\pi \times 50$ rad/s after 5 s |
| `IM_close-loop.slx` | `Wsref1` | $2\pi \times 50$ rad/s before 0.5 s; $2\pi \times 100$ rad/s after 0.5 s |
| `MS_alpha_beta.slx` | `Cr` | Time: 300 s; final value: 0.1 |

The stored speed-reference step in `IM_Open_loop.slx` is configured at 5 s, while the model stop time is 1 s. Therefore, the stored open-loop simulation configuration does not reach this step.

## Reproducing the Simulations

### Requirements

The Simulink files were saved with MATLAB releases ranging from R2014a to R2019a. MATLAB and Simulink R2019a are recommended to open all supplied models.

Run one model at a time and clear the MATLAB workspace before switching between induction-machine and synchronous-machine files.

### Main Induction-Motor Model

```matlab
clear; clc; close all;

cd(fullfile("IM", "IM_d-q"));

run("IM_d_q.m");
open_system("IM_d_q.slx");

sim("IM_d_q");
```

### Open-Loop V/f Model

```matlab
clear; clc; close all;

cd(fullfile("V_F_Control"));

run("parametre_IM.m");
open_system("IM_Open_loop.slx");

sim("IM_Open_loop");
```

### Closed-Loop V/f Model

```matlab
clear; clc; close all;

cd(fullfile("V_F_Control"));

run("parametre_IM.m");
open_system("IM_close-loop.slx");

sim("IM_close-loop");
```

## Available Outputs

The main induction-motor model exports the following signals using `To Workspace` blocks:

| MATLAB variable | Signal |
|---|---|
| `Cem` | Electromagnetic torque |
| `omega_r` | Rotor mechanical speed |
| `Isabc` | Three-phase stator currents |
| `phirabc` | Rotor-flux output |
| `flux` | Flux output |
| `Isa` | Stator-current component |

The model also contains scopes for:

- three-phase supply voltage;
- stator currents;
- electromagnetic torque;
- rotor flux;
- single-phase flux output;
- mechanical speed.

The V/f control models contain scopes for inverter output voltage, currents, electromagnetic torque, flux, and speed.

## Project Figures

The project documentation includes the following visual material:

| File | Description |
|---|---|
| `IM Block Diag.jpeg` | High-level representation of the induction-motor block, its inputs, outputs, and state-space equation. |
| `IM Simulink Block.jpeg` | Overview of the three-phase source, Park transformation, induction-motor subsystem, and scopes. |
| `Simulink detailed Block Diag.png` | Detailed Simulink implementation of the induction-motor equations and signal outputs. |
| `Input Data.jpeg` | Nominal, electrical, and mechanical parameter reference. |

### High-Level Architecture

<p align="center">
  <img src="docs/images/im-dq-architecture.png" alt="Induction Motor High-Level Architecture" width="900">
</p>

---

### Simulink Model Overview

<p align="center">
  <img src="docs/images/im-simulink-overview.png" alt="Simulink Model Overview" width="900">
</p>

---

### Detailed Simulink Model

<p align="center">
  <img src="docs/images/im-simulink-detail.png" alt="Detailed Simulink Block Diagram" width="900">
</p>

---

### Input Data and Parameter Reference

<p align="center">
  <img src="docs/images/induction-motor-input-data.png" alt="Induction Motor Input Data and Parameters" width="900">
</p>

## Scope and Limitations

- The project is based on MATLAB/Simulink simulation models.
- The provided files do not include experimental measurements or validation data.
- The supplied files do not include automatic result-processing scripts.
- The models use manually defined electrical and mechanical parameters.
- The repository contains separate induction-machine and synchronous-machine models; they use different parameter scripts and should not be run in the same workspace without clearing it first.
- The README describes the available scripts, models, parameters, scopes, and exported variables only.

## License

No licence file is included in the supplied project files.