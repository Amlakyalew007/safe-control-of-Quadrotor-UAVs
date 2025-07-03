# Safe Control of Quadrotor UAV Based on Fast Super-Twisted Adaptive Backstepping Sliding Mode Control

## 📘 Introduction

This project presents a **safety-critical control framework** for quadrotor UAVs operating under **full-state constraints** and subject to **matched and unmatched disturbances**. The controller is designed using:

- **Fast Super-Twisted Sliding Mode Control (FSTSMC)**
- **Adaptive Radial Basis Function Neural Networks (RBF-NN)**
- **Improved Barrier Lyapunov Functions (BLF)**
- **Dynamic Compensation System (DCS)**
- **Nonlinear Disturbance Observers (DO)**

The design ensures all system signals remain **semi-globally uniformly ultimately bounded (SGUUB)** while enforcing safe operation through state constraints.

---

## 🧠 Key Contributions

1. **Unified Feedback Design**  
   A dynamic compensation system (DCS) avoids algebraic loops and unifies strict and non-strict feedback system control.

2. **Improved Barrier Lyapunov Function (BLF)**  
   Introduces an inducible factor (IF) based on a sigmoid function, eliminating dependence on initial states.

3. **Enhanced Disturbance Observer (DO)**  
   DCS-integrated DO structure improves decoupling and robustness under unknown dynamics.

4. **Adaptive RBF Neural Network Integration**  
   Estimates uncertainties and disturbances for real-time compensation without model dependency.

---

## ⚙️ Problem Formulation

We consider a second-order nonlinear system of the form:

Control objectives:

- Ensure SGUUB of all signals.
- Achieve accurate trajectory tracking.
- Constrain all system states within a predefined safe region after a specified time `Ts`.

---

## 🛠️ Controller Design

The control law combines multiple advanced techniques:

- **FSTSMC**: Provides robustness against disturbances and fast convergence.
- **DCS**: Filters estimation and control signals to remove algebraic loops.
- **BLF with IF**: Allows transition from unconstrained to constrained control.
- **RBF-NN**: Provides online approximation of unknown nonlinear functions.
- **DO**: Estimates external disturbances with reduced order.

---

## 🧪 Simulation Setup

The control framework was tested on a quadrotor UAV with external disturbances (wind-like sinusoidal signals) acting on all axes. The same control structure was applied to all subsystems (altitude, lateral, and rotational motions), but only the Z-axis (altitude) controller is shown for brevity.

---

## 📊 Simulation Results

### Figure 1: Z-axis Tracking Control Performance  
> Shows the UAV altitude tracking performance. The controller tracks the desired trajectory accurately despite disturbances and state constraints.

### Figure 2: Constraint Satisfaction via Improved BLF  
> Demonstrates how the improved BLF allows state trajectories to violate constraints during `t ∈ [0, Ts]`, then strictly enforces constraints afterward. Unlike traditional BLFs, the proposed method handles poor initial conditions smoothly.

### Figure 3: Sliding Surface and Error Dynamics  
> Displays the evolution of sliding surface `s` and tracking error `e` under the influence of control and compensation mechanisms.

### Figure 4: Disturbance Observer Performance  
> Illustrates how the DO effectively estimates both matched and unmatched disturbances in real time.

### Figure 5: Control Input Signals  
> Shows the bounded and smooth control efforts applied to the UAV motors during tracking and stabilization.

---

## 📌 Conclusion

This project successfully demonstrates a robust, adaptive, and safe tracking control strategy for UAVs under full-state constraints. The proposed method combines control theory with neural adaptation and disturbance estimation in a structured framework, suitable for real-world autonomous aerial systems.

The use of a **two-stage BLF**, dynamic observer design, and **RBF-NN-based compensation** provides a flexible and scalable architecture for future extension to **multi-agent systems**, **visual navigation**, or **reinforcement learning-based control**.

---

## 📁 Repository Structure


