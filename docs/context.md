# Physics Snippets
The goal here is to provide some beginner-ish examples which are interesting and visualization-friendly. The intented audience is a physicist (at almost any level) who is still relatively new to the Julia language.
---
1. **Planetary Orbits**  
**Description:** Simulate the motion of planets in the solar system by numerically solving the gravitational equations of motion (Newton’s law of gravitation).  
**Visualization:** Use `Makie.jl` to create a 3D plot showing the elliptical orbits of planets over time.  
**Learning Outcome:** You’ll practice solving ordinary differential equations (ODEs) using Julia’s `DifferentialEquations.jl` package and explore 3D plotting in `Makie.jl`.  
2. **Double Pendulum**  
**Description:** Model the chaotic motion of a double pendulum, a system where two pendulums are attached end-to-end, by solving its coupled ODEs.  
**Visualization:**: Animate the pendulum’s motion over time, showing its unpredictable swings.  
**Learning Outcome:** Gain experience with ODE solvers and learn to create animations in `Makie.jl`.  
3. **Electric Field Lines**  
**Description:**: Calculate the electric field produced by a set of point charges and determine the field lines.  
**Visualization:**: Plot the field lines using streamplots or vector arrows in `Makie.jl` to show the field’s direction and strength.  
**Learning Outcome:** Learn to compute vector fields and visualize them effectively.  
4. **Quantum Particle in a Box**  
**Description:**: Solve the time-independent Schrödinger equation for a particle in a one-dimensional infinite potential well (a classic quantum mechanics problem).  
**Visualization:**: Plot the wave functions (ψ) and probability densities (|ψ|²) for different energy levels.  
**Learning Outcome:** Understand basic quantum computations in Julia and practice plotting functions.  
5. **Ideal Gas Simulation**  
**Description:**: Simulate an ideal gas in a 2D box, modeling particle motion and elastic collisions with the walls.  
**Visualization:**: Animate the particles’ motion and plot their velocity distribution to compare with the Maxwell-Boltzmann distribution.  
**Learning Outcome:** Implement particle dynamics and create statistical visualizations.  
6. **Ray Tracing for Optics**  
**Description:**: Write a simple ray tracing algorithm to model how light rays pass through a converging lens.  
**Visualization:**: Plot the paths of light rays as they refract through the lens, showing focal points.  
**Learning Outcome:** Practice geometric calculations and line plotting in `Makie.jl`.  
7. **Heat Equation**  
**Description:**: Numerically solve the heat equation in one or two dimensions to model heat diffusion across a material.  
**Visualization:**: Create a time-evolving plot or animation of the temperature distribution.  
**Learning Outcome:** Learn to solve partial differential equations (PDEs) and visualize spatiotemporal data.  
8. **Harmonic Oscillator**  
**Description:**: Simulate a simple harmonic oscillator (e.g., a mass on a spring) by solving its ODE.  
**Visualization:**: Plot the position and velocity over time, or create a phase space diagram (position vs. velocity).  
**Learning Outcome:** Reinforce ODE solving and explore time series or phase space plotting.  
9. **Monte Carlo Pi Estimation**  
**Description:**: Estimate the value of π using a Monte Carlo method: generate random points in a square and count how many fall inside an inscribed circle.  
**Visualization:**: Plot the points, coloring those inside vs. outside the circle to illustrate the method.  
**Learning Outcome:** Get comfortable with random number generation and basic scatter plotting.  
10. **Lorentz Attractor**  
**Description:**: Simulate the Lorentz system, a set of ODEs famous for its chaotic behavior and butterfly-shaped attractor.  
**Visualization:**: Create a 3D plot of the strange attractor trajectory.  
**Learning Outcome:** Explore chaotic systems and 3D trajectory visualization.  
11. **Projectile Motion with Air Resistance**  
**Description:**: Model a projectile’s trajectory, including the effects of air resistance, by solving ODEs with a drag force term.  
**Visualization:**: Plot the trajectory and compare it to the ideal (no-drag) parabolic path.  
**Learning Outcome:** Understand drag forces and practice plotting trajectories.  
12. **Charged Particle in Magnetic Field**  
**Description:**: Simulate the motion of a charged particle in a uniform magnetic field, which follows a helical path due to the Lorentz force.  
**Visualization:**: Create a 3D plot of the particle’s helical trajectory.  
**Learning Outcome:** Model electromagnetic forces and visualize 3D paths.  
13. **Wave Interference**  
**Description:**: Simulate the interference pattern from two wave sources (e.g., two slits or point sources) by combining their wave fields.  
**Visualization:**: Plot the 2D wave field, highlighting areas of constructive and destructive interference.  
**Learning Outcome:** Work with wave equations and create 2D field visualizations.  
14. **Electrostatic Potential**  
**Description:**: Numerically solve Laplace’s equation for the electrostatic potential in a 2D region with given boundary conditions.  
**Visualization:**: Plot equipotential lines and overlay the electric field vectors.  
**Learning Outcome:** Solve PDEs and visualize scalar and vector fields together.  
---
**Why These Problems?**  
**Physics Relevance:** These span classical mechanics, electromagnetism, quantum mechanics, thermodynamics, and more—familiar territory for a physicist.  
**Julia Suitability:** They leverage Julia’s strengths, like fast numerical computations and packages (`DifferentialEquations.jl` for ODEs/PDEs, `Makie.jl` for visuals).  
**Visualization Focus:** Each offers a chance to learn `Makie.jl` features—scatter plots, animations, 3D trajectories, vector fields, etc.  
**Beginner-Friendly:** They start with manageable concepts (e.g., harmonic oscillator) and scale to more complex systems (e.g., Lorentz attractor), with Julia’s documentation and community to support you.