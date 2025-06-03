# Harmonic Oscillator

This snippet simulates a simple harmonic oscillator (mass on a spring) by solving its ordinary differential equation and comparing numerical and analytical solutions.

## Core Physics & Mathematical Model

### Relevant Equations
- Equation of Motion: $m\ddot{x} + kx = 0$
- Analytical Solution:
  - Position: $x(t) = A\cos(\omega t + \phi)$
  - Velocity: $v(t) = -A\omega\sin(\omega t + \phi)$
- Energy:
  - Kinetic: $T = \frac{1}{2}mv^2$
  - Potential: $V = \frac{1}{2}kx^2$
  - Total: $E = T + V = \frac{1}{2}kA^2$ (constant)

### Key Physical Parameters & Units
- `MASS`: Mass of the oscillator (1.0 kg)
- `SPRING_CONSTANT`: Spring constant (1.0 N/m)
- `AMPLITUDE`: Initial displacement (1.0 m)
- `PHASE`: Initial phase angle (0.0 rad)
- `ANGULAR_FREQUENCY`: $\omega = \sqrt{k/m}$ (1.0 rad/s)
- `PERIOD`: $T = 2\pi/\omega$ (2π s)

### Simplifications/Assumptions
- No damping (undamped oscillator)
- No external forces
- Massless spring
- Point mass
- Linear spring force (Hooke's law)
- No relativistic effects

## Implementation Details

### Key Functions
- `harmonic_oscillator_v!(dv, v, u, p, t)`: Velocity function
- `harmonic_oscillator_f!(du, v, u, p, t)`: Force function
- `analytical_solution(t)`: Calculate exact solution
- `run_simulation()`: Main simulation function
- `plot_solutions()`: Visualization function

### Data Structures
- State vector: `[position, velocity]`
- Solution arrays: Time series of positions and velocities
- Plot data: Time, numerical and analytical solutions

### Algorithm Outline
1. Define physical parameters and initial conditions
2. Set up partitioned ODE system
3. Solve using VerletLeapfrog integrator
4. Calculate analytical solution
5. Compare and visualize results

### Specific Julia Packages
- `DifferentialEquations.jl`: For ODE solving
  - Solver: `VerletLeapfrog` with fixed time step
  - Problem type: `DynamicalODEProblem`
- `Makie.jl`: For visualization
- `Test`: For unit testing

## Visualization Specifics

### Type of Plot
- Four-panel figure showing:
  1. Position vs. time
  2. Velocity vs. time
  3. Phase space (position vs. velocity)
  4. Energy components vs. time

### Plot Elements
- Time plots: Numerical (solid) and analytical (dashed) solutions
- Phase space: Closed elliptical orbit
- Energy plot: Kinetic, potential, and total energy
- Grid lines and legends
- Consistent axis limits and labels

## Testing & Validation

### Energy Conservation
- Total energy should remain constant
- Maximum energy drift < 1e-6
- Kinetic and potential energy oscillate out of phase

### Periodicity
- Position and velocity should be periodic
- Period = 2π/ω
- Phase space trajectory should be closed

### Numerical Accuracy
- Maximum deviation from analytical solution < 1e-5
- Symplectic integrator preserves phase space volume
- Fixed time step ensures stability

## Learning Outcomes
- Understanding of simple harmonic motion
- Experience with symplectic integrators
- Practice with energy conservation
- Visualization of phase space
- Comparison of numerical and analytical solutions

## Usage
```julia
julia> include("harmonic_oscillator.jl")
```

## Dependencies
- DifferentialEquations.jl
- Makie.jl
- Test

## Further Exploration
- Add damping (γẋ term)
- Include driving force
- Try different integrators
- Analyze energy conservation
- Extend to coupled oscillators
- Add interactive controls
- Implement Hamiltonian formulation
- Study resonance phenomena 