# Planetary Orbits

This snippet simulates the motion of planets in the solar system by numerically solving the gravitational equations of motion using Newton's law of gravitation.

## Core Physics & Mathematical Model

### Relevant Equations
- Newton's Law of Gravitation: $\vec{F} = -G\frac{Mm}{r^2}\hat{r}$
- For each planet:
  - Position: $\vec{r} = (x, y, z)$
  - Velocity: $\vec{v} = (v_x, v_y, v_z)$
  - Acceleration: $\vec{a} = -G\frac{M_{sun}}{r^3}\vec{r}$

### Key Physical Parameters & Units
- `G`: Gravitational constant (6.67430e-11 m³/kg/s²)
- `M_sun`: Solar mass (1.989e30 kg)
- `AU`: Astronomical Unit (149597870700 m)
- Planet masses (kg)
- Initial positions (m)
- Initial velocities (m/s)

### Simplifications/Assumptions
- Sun is fixed at the origin
- Planets are treated as point masses
- No planet-planet gravitational interactions
- No relativistic effects
- No solar radiation pressure
- No tidal forces

## Implementation Details

### Key Functions
- `gravity_acceleration!(du, u, p, t)`: ODE function for planetary motion
- `calculate_energy(u, p)`: Computes total system energy
- `simulate_solar_system(tspan)`: Main simulation function
- `plot_orbits_2d(sol, planets)`: Visualization function

### Data Structures
- `Planet`: Struct containing planet properties
  - `name`: String
  - `mass`: Quantity (kg)
  - `initial_position`: SVector{3} (m)
  - `initial_velocity`: SVector{3} (m/s)

### Algorithm Outline
1. Define physical constants and planet data
2. Set up initial conditions for each planet
3. Solve ODE system using DifferentialEquations.jl
4. Extract and plot results

### Specific Julia Packages
- `DifferentialEquations.jl`: For ODE solving
  - Solver: `Tsit5` with high precision (reltol=1e-8, abstol=1e-8)
- `Makie.jl`: For visualization
- `StaticArrays`: For efficient small vector operations
- `Unitful`: For physical units
- `UnitfulAstro`: For astronomical units

## Visualization Specifics

### Type of Plot
- 2D line plot showing planetary orbits
- Scatter points for start/end positions
- Sun marked at origin

### Plot Elements
- X-axis: "X (AU)"
- Y-axis: "Y (AU)"
- Title: "Planetary Orbits (2D, 1 Mars Year)"
- Legend: Planet names, Start/End markers, Sun
- Grid lines for reference
- Equal aspect ratio
- Axis limits: [-1.7, 1.7] AU

## Testing & Validation

### Energy Conservation
- Total energy (kinetic + potential) should remain constant
- Energy drift indicates numerical errors

### Orbital Periods
- Planets should return to starting positions after integer multiples of their orbital periods
- Mars completes one orbit in 687 days

### Visual Checks
- Orbits should be closed (elliptical)
- No unphysical behavior (e.g., planets escaping)
- Proper scaling of orbits relative to each other

## Learning Outcomes
- Understanding of gravitational force and orbital mechanics
- Practice with ODE solving in Julia
- Experience with physical units and unit conversion
- Visualization of complex physical systems
- Appreciation of numerical precision requirements

## Usage
```julia
julia> include("planetary_orbits.jl")
```

## Dependencies
- DifferentialEquations.jl
- Makie.jl
- LinearAlgebra
- StaticArrays
- Unitful
- UnitfulAstro

## Further Exploration
- Add more planets or include planet-planet interactions
- Animate the orbits over time
- Visualize energy conservation or angular momentum
- Try different integrators (e.g., symplectic methods)
- Extend to 3D or include the Sun's motion
- Add interactive controls for initial conditions 