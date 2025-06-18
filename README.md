# PhysicsSnippets

<!-- Trigger CI: trivial change -->

A collection of beginner-to-intermediate level physics simulations and models in Julia, designed for learning Julia, exploring its scientific computing ecosystem, and creating interesting visualizations.

## Project Structure

```
/PhysicsSnippets
    /src
        /01_PlanetaryOrbits
        /02_DoublePendulum
        /03_ElectricFieldLines
        /04_QuantumParticleInBox
        /05_IdealGasSimulation
        /06_RayTracingOptics
        /07_HeatEquation
        /08_HarmonicOscillator
        /09_MonteCarloPi
        /10_LorentzAttractor
        /11_ProjectileMotion
        /12_ChargedParticleMagneticField
        /13_WaveInterference
        /14_ElectrostaticPotential
    /docs
    Project.toml
    README.md
```

## Available Snippets

1. **Planetary Orbits**: Simulate planetary motion using Newton's law of gravitation
2. **Double Pendulum**: Model chaotic motion of a double pendulum
3. **Electric Field Lines**: Calculate and visualize electric fields from point charges
4. **Quantum Particle in a Box**: Solve the time-independent Schrödinger equation
5. **Ideal Gas Simulation**: Simulate particle motion and collisions in a 2D box
6. **Ray Tracing for Optics**: Model light ray paths through a converging lens
7. **Heat Equation**: Solve heat diffusion in 1D or 2D
8. **Harmonic Oscillator**: Simulate a mass-spring system
9. **Monte Carlo Pi Estimation**: Estimate π using random sampling
10. **Lorentz Attractor**: Simulate the famous chaotic system
11. **Projectile Motion**: Model trajectories with air resistance
12. **Charged Particle in Magnetic Field**: Simulate helical motion in a B-field
13. **Wave Interference**: Model interference patterns from wave sources
14. **Electrostatic Potential**: Solve Laplace's equation for electric potential

## Getting Started

1. Clone the repository:
```bash
git clone https://github.com/yourusername/PhysicsSnippets.git
cd PhysicsSnippets
```

2. Start Julia and activate the project:
```julia
julia> using Pkg
julia> Pkg.activate(".")
julia> Pkg.instantiate()
```

3. Run any snippet:
```julia
julia> include("src/01_PlanetaryOrbits/planetary_orbits.jl")
```

## Dependencies

- Julia 1.6 or later
- DifferentialEquations.jl
- Makie.jl
- Other packages as needed for specific snippets

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