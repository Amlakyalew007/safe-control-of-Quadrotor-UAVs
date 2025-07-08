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
![Alt Text](https://github.com/Amlakyalew007/safe-control-of-Quadrotor-UAVs/blob/main/images/problem.png)

  # Control objectives:

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


## Figure 1: The Full Control Design Scheme Seen From Simulink Design  

![Alt Text](https://github.com/Amlakyalew007/safe-control-of-Quadrotor-UAVs/blob/main/images/system%20design.png)

---



## 🧪 Simulation Setup

The control framework was tested on a quadrotor UAV with external disturbances (wind-like sinusoidal signals) acting on all axes. The same control structure was applied to all subsystems (altitude, lateral, and rotational motions), but only the Z-axis (altitude) controller is shown for brevity.

## Figure 2: Z-axis (Vertical Lift) Control Design
![Alt Text](https://github.com/Amlakyalew007/safe-control-of-Quadrotor-UAVs/blob/main/images/z-axis%20control.png)

---

## 📊 Simulation Results

### Figure 3: Constraint Satisfaction via Improved BLF (Seen From Error Dynamics) 
> Demonstrates how the improved BLF allows state trajectories to violate constraints during `t ∈ [0, Ts]`, then strictly enforces constraints afterward. Unlike traditional BLFs, the proposed method handles poor initial conditions smoothly.
> If we look at the red line (error) it starts outside the boundary line of the constraint yet it was able to come in before the predefined time Ts (Ts is found from the inducible factor which is a variant sigmoid function used to relax the constraint by creating a weak constraint stage at the start).

![Alt Text](https://github.com/Amlakyalew007/safe-control-of-Quadrotor-UAVs/blob/main/images/e1.jpg)

### Figure 4: 3D trajectory tracking performance  
> This figure shows the 3D trajectory tracking performance of a quadrotor UAV. The red line represents the desired helical trajectory, while the blue line indicates the obtained trajectory under the proposed control system. The close alignment between the two confirms the controller’s effectiveness in accurately tracking complex spatial paths.
![Alt Text](https://github.com/Amlakyalew007/safe-control-of-Quadrotor-UAVs/blob/main/images/tracking.jpg)
---

## 📌 Conclusion

This project successfully demonstrates a robust, adaptive, and safe tracking control strategy for UAVs under full-state constraints. The proposed method combines control theory with neural adaptation and disturbance estimation in a structured framework, suitable for real-world autonomous aerial systems.

The use of a **two-stage BLF**, dynamic observer design, and **RBF-NN-based compensation** provides a flexible and scalable architecture for future extension to **multi-agent systems**, **visual navigation**, or **reinforcement learning-based control**.

---


**NOTE:** the design process is shown below which is part of my masters degree project done under the guidance of professor Wu Dawei, Hohai University Dept. of Artificial intelligent and Automation 


![Alt Text](https://github.com/Amlakyalew007/safe-control-of-Quadrotor-UAVs/blob/main/images/page1.jpg)
![Alt Text](https://github.com/Amlakyalew007/safe-control-of-Quadrotor-UAVs/blob/main/images/page2.jpg)
![Alt Text](https://github.com/Amlakyalew007/safe-control-of-Quadrotor-UAVs/blob/main/images/page3.jpg)
![Alt Text](https://github.com/Amlakyalew007/safe-control-of-Quadrotor-UAVs/blob/main/images/page4.jpg)
![Alt Text](https://github.com/Amlakyalew007/safe-control-of-Quadrotor-UAVs/blob/main/images/page5.jpg)
![Alt Text](https://github.com/Amlakyalew007/safe-control-of-Quadrotor-UAVs/blob/main/images/page6.jpg)
![Alt Text](https://github.com/Amlakyalew007/safe-control-of-Quadrotor-UAVs/blob/main/images/page7.jpg)
![Alt Text](https://github.com/Amlakyalew007/safe-control-of-Quadrotor-UAVs/blob/main/images/page8.jpg)
![Alt Text](https://github.com/Amlakyalew007/safe-control-of-Quadrotor-UAVs/blob/main/images/page9.jpg)
![Alt Text](https://github.com/Amlakyalew007/safe-control-of-Quadrotor-UAVs/blob/main/images/page10.jpg)
![Alt Text](https://github.com/Amlakyalew007/safe-control-of-Quadrotor-UAVs/blob/main/images/page11.jpg)


**MORE NOTE:** If necessary we can design the (roll, Pitch, Yaw) control law (U2, U3, U4) according to the above design method! For the time being, as mentioned above the control law (U2, U3, U4) are designed using Fast super twisting adaptive backstepping sliding mode control, this is to say constraints were not imposed on the states. For more information and detailed design process refer to https://github.com/Amlakyalew007/Quadrotor-UAV-fast-super-twisting-adaptive-backstepping-SMC.git


