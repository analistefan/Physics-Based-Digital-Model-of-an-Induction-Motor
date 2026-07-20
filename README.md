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
