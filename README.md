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

## Requirements

- Julia 1.6 or higher
- Required packages:
  - CairoMakie
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

- **Use docstrings and comments liberally.** They help both you and others understand the code.
- **Leverage Julia's multiple dispatch and type system.**
- **Start with simple integrators, but learn when to use specialized ones (like symplectic methods for Hamiltonian systems).**
- **Plotting in Julia is powerful but can require iteration to get the best results.**
- **Don't be afraid to experiment with plotting options and integrator settings.**

<!-- As more examples are added, accumulate additional tips here. --> 