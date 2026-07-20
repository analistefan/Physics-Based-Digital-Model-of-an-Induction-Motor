# Physics-Based-Digital-Model-of-an-Induction-Motor
Designing from the electromechanical equations a dynamic model that can accurately reproduce the machine's transient and steadystate response
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