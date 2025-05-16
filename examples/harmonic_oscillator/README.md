# Harmonic Oscillator Simulation in Julia

This example demonstrates how to simulate a simple harmonic oscillator (mass on a spring) using Julia. The script `harmonic_oscillator.jl` is designed to be clear and educational for beginners, and illustrates best practices for ODE modeling, numerical integration, and scientific plotting in Julia.

## Problem Overview
The harmonic oscillator is governed by the equation:

    mẍ + kx = 0

where:
- `m` is the mass
- `k` is the spring constant
- `x` is the displacement from equilibrium

The analytical solution is:

    x(t) = A cos(ωt + φ)
    v(t) = -Aω sin(ωt + φ)

where:
- `A` is the amplitude
- `ω = sqrt(k/m)` is the angular frequency
- `φ` is the phase angle

## ODE Formulation and Integrator Choice

### Standard vs. Hamiltonian Formulation
- **Standard ODE:** The system can be written as a second-order ODE or as a first-order system in position and velocity.
- **Hamiltonian (Partitioned) Form:** For symplectic integrators, it's best to split the system into position and momentum (or velocity) components, matching the structure of Hamiltonian mechanics.

### Integrator Selection
- **Non-symplectic Integrators (e.g., Tsit5):**
  - Easy to use and accurate for many problems.
  - Do not conserve energy exactly in Hamiltonian systems; energy may drift over time.
- **Symplectic Integrators (e.g., VerletLeapfrog):**
  - Designed for Hamiltonian systems (like the harmonic oscillator).
  - Conserve energy over long times (energy oscillates but does not drift).
  - Require the problem to be formulated in partitioned (Hamiltonian) form.
  - Require a fixed time step (`dt` must be set explicitly).

**In this project:**
- We reformulated the ODE as a Hamiltonian system to use the `VerletLeapfrog` symplectic integrator.
- We set an explicit time step (`DT = 0.001`) for accuracy and energy conservation.
- We verified the solution against the analytical result and checked energy conservation with tests.

## Running the Script
1. Make sure you have Julia and the required packages installed:
   - `DifferentialEquations`
   - `CairoMakie`
   - `Test`
2. Run the script:
   ```sh
   julia harmonic_oscillator.jl
   ```
3. The script will:
   - Run tests to verify correctness and energy conservation.
   - Simulate the oscillator and display four plots:
     - Position vs. time
     - Velocity vs. time
     - Phase space (position vs. velocity)
     - Energy (kinetic, potential, total) vs. time

## Plotting Settings and Legend Placement

### Key Plot Customizations
- **Legend Placement:**
  - By default, Makie places legends inside the plot area, which can obscure data.
  - We used `axislegend(..., position=(0.5, 1.1))` to move the legend above the plot, with a horizontal layout and no frame for clarity.
  - The `position` argument accepts values outside `[0, 1]` to place the legend outside the axis area.
- **Font and Padding:**
  - Legend font size was reduced for compactness (`labelsize=10`).
  - Padding was minimized to avoid excess whitespace.
- **Axis Limits and Margins:**
  - Y-axis limits and margins were adjusted to provide space for the legend and avoid overlap with data.

### Lessons Learned
- **Legend placement in Makie can be tricky.** Use custom positions and experiment with `position`, `padding`, and `framevisible` for best results.
- **Symplectic integrators require partitioned ODEs and fixed time steps.**
- **Testing is essential:** Always check both solution accuracy and energy conservation for physical systems.

## Further Exploration
- Try different time steps and observe the effect on energy conservation.
- Experiment with other integrators (e.g., `SymplecticEuler`).
- Extend the example to damped or driven oscillators.

---

**This example is part of a collection of beginner-friendly Julia physics snippets.**
See the repository for more examples and learning resources. 