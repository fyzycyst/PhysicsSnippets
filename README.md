# Physics Snippets

A collection of physics-based examples and visualizations implemented in Julia. These examples are designed to be both educational and visually engaging, making them suitable for physicists learning Julia or anyone interested in computational physics.

## Examples

### 1. Monte Carlo Pi Estimation
- **Description**: Estimates π using the Monte Carlo method by randomly sampling points in a square and counting those that fall within an inscribed circle.
- **Files**:
  - `monte_carlo_pi.jl`: Basic implementation with visualization
  - `monte_carlo_pi_convergence.jl`: Analysis of convergence and performance
- **[Detailed documentation →](examples/monte_carlo_pi/README.md)** 

### 2. Harmonic Oscillator Simulation
- **Description**: Simulates a simple harmonic oscillator (mass on a spring) using Julia.
- **Files**:
  - `harmonic_oscillator.jl`: Demonstrates best practices for ODE modeling, numerical integration, and scientific plotting in Julia.
- **[Detailed documentation →](examples/harmonic_oscillator/README.md)**

### 3. Planetary Orbits Simulation
- **Description**: Simulates the orbits of Mercury, Venus, Earth, and Mars around the Sun using Newtonian gravity and visualizes their paths.
- **Files**:
  - `planetary_orbits.jl`: Main simulation and visualization script
- **[Detailed documentation →](examples/planetary_orbits/README.md)**

## Requirements

- Julia 1.6 or higher
- Required packages:
  - CairoMakie
  - StaticArrays
  - Unitful
  - UnitfulAstro
  - Random
  - Statistics
  - DifferentialEquations
  - Test

## Installation

1. Clone the repository:
```bash
git clone https://github.com/fyzycyst/PhysicsSnippets.git
cd PhysicsSnippets
```

2. Install required packages:
```julia
julia --project -e 'using Pkg; Pkg.instantiate()'
```

## Usage

Each example can be run directly with Julia. For example:
```bash
julia monte_carlo_pi.jl
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

- fyzycyst

---

# Tips for Julia Beginners

- **Be rigorous with physical units.** Use packages like `Unitful.jl` to catch unit mismatches early and ensure all quantities (positions, velocities, time) are in consistent units before numerical integration.
- **Check initial conditions carefully.** For dynamical simulations, ensure that initial positions and velocities are physically consistent (e.g., use the correct formula for circular velocity if you want a closed orbit).
- **Understand your integrator's requirements.** Some integrators (like symplectic methods) require specific ODE formulations or fixed time steps. Read the documentation for `DifferentialEquations.jl` integrators to choose the right one for your problem.
- **Use `StaticArrays` for small, fixed-size vectors.** This can significantly improve performance in tight loops or ODE functions involving 2D/3D vectors.
- **Explicitly manage legend and plot layout in Makie.** For publication-quality figures, use Makie's grid layout and explicit legend placement to avoid obscuring data.
- **Debug with print statements and small test cases.** If your simulation isn't behaving as expected, print out the first few values of your state variables to check for errors in units, indexing, or ODE setup.
- **Always use SI units for ODE integration unless you are certain of your scaling.** This avoids subtle bugs, especially when mixing astronomical and SI units.
- **Validate your simulation with known results.** For orbits, check that a planet returns to its starting point after one period, or that energy is conserved (if appropriate).
- **Use docstrings and comments liberally.** They help both you and others understand the code.
- **Leverage Julia's multiple dispatch and type system.**
- **Start with simple integrators, but learn when to use specialized ones (like symplectic methods for Hamiltonian systems).**
- **Plotting in Julia is powerful but can require iteration to get the best results.**
- **Don't be afraid to experiment with plotting options and integrator settings.**

<!-- As more examples are added, accumulate additional tips here. --> 