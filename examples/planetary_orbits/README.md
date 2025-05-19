# Planetary Orbits Simulation in Julia

This example demonstrates how to simulate the orbits of Mercury, Venus, Earth, and Mars around the Sun using Newtonian gravity. The script `planetary_orbits.jl` is designed to be clear and educational for beginners, illustrating ODE modeling, numerical integration, and scientific plotting in Julia.

## Problem Overview
The goal is to numerically solve the equations of motion for the inner planets of the solar system, assuming Newtonian gravity and a fixed Sun at the origin. The simulation visualizes the orbits and highlights the start and end positions for each planet over one Martian year.

### Method
- Each planet is modeled as a point mass orbiting a fixed Sun.
- The gravitational force is computed as:

      F = -GM_sun * m_planet * r / |r|^3

  where `r` is the position vector of the planet relative to the Sun.
- The ODE system is integrated using Julia's `DifferentialEquations.jl` package.
- The simulation runs for one Martian year (687 days), and the orbits are visualized in the x-y plane.

## Implementation Details
- **ODE Modeling:**
  - Each planet's state is represented by its position and velocity in 2D (z=0).
  - The ODE function updates positions and velocities using Newton's law of gravitation.
  - The Sun is fixed at the origin and not integrated as a body.
- **Initial Conditions:**
  - Planets start at perihelion on the x-axis with velocity perpendicular to the radius vector.
  - Mars' velocity is computed for a perfect circular orbit at 1.524 AU.
- **Integration:**
  - The ODE is solved for 687 days (in seconds) with daily output.
  - The Tsit5 integrator is used for accuracy and efficiency.
- **Testing:**
  - The simulation is checked by verifying that Mars returns to its starting point after one Martian year.

## Visualization and Plotting Settings
- **2D Orbit Plot:**
  - Orbits are plotted in the x-y plane with the Sun at the origin.
  - Start and end positions for each planet are marked with distinct symbols.
  - The legend is placed in a separate column to the right of the plot for clarity.
  - Axis limits are set to [-1.7, 1.7] AU for both x and y.
  - Grid lines are enabled for reference.
- **Legend Order:**
  - "Start" and "End" markers appear first, followed by each planet and the Sun.
- **Makie Settings:**
  - Uses `CairoMakie` for high-quality vector graphics output.
  - Handles and labels are managed explicitly for custom legend placement.

## Lessons Learned
- **Unit Consistency:**
  - Always ensure positions, velocities, and time are in consistent SI units when integrating ODEs.
- **Initial Conditions Matter:**
  - For a closed orbit, the initial velocity must match the circular velocity for the given radius.
- **Legend Placement:**
  - Placing the legend outside the plot area avoids obscuring data and improves clarity.
- **Numerical Accuracy:**
  - With correct initial conditions and integration settings, the simulation reproduces closed orbits for integer multiples of the orbital period.

## Further Exploration
- Add more planets or include planet-planet gravitational interactions.
- Animate the orbits over time.
- Visualize energy conservation or angular momentum.
- Try different integrators (e.g., symplectic methods) for long-term stability.
- Extend to 3D or include the Sun's motion.

---

**This example is part of a collection of beginner-friendly Julia physics snippets.**
See the repository for more examples and learning resources. 