"""
Harmonic Oscillator Simulation

This script simulates a simple harmonic oscillator (mass on a spring) and compares
the numerical solution with the analytical solution. The system is described by:

    mẍ + kx = 0

where:
- m is the mass
- k is the spring constant
- x is the displacement from equilibrium

The analytical solution is:
    x(t) = A cos(ωt + φ)
    v(t) = -Aω sin(ωt + φ)

where:
- A is the amplitude
- ω = √(k/m) is the angular frequency
- φ is the phase angle

The simulation uses a symplectic integrator (VerletLeapfrog) to ensure long-term
energy conservation and accurate phase space trajectories.

Author: fyzycyst
"""

using CairoMakie
using DifferentialEquations
using Test
using LinearAlgebra

# Physical parameters with units
# ----------------------------
const MASS = 1.0        # mass in kg
const SPRING_CONSTANT = 1.0  # spring constant in N/m
const AMPLITUDE = 1.0   # initial displacement in m
const PHASE = 0.0       # initial phase in radians

# Simulation parameters
# -------------------
const T_START = 0.0     # start time in seconds
const T_END = 10.0      # end time in seconds
const DT = 0.001        # time step in seconds

# Derived physical parameters
# -------------------------
const ANGULAR_FREQUENCY = sqrt(SPRING_CONSTANT / MASS)  # rad/s
const PERIOD = 2π / ANGULAR_FREQUENCY                   # s
const TOTAL_ENERGY = 0.5 * SPRING_CONSTANT * AMPLITUDE^2  # J

"""
    harmonic_oscillator_v!(dv, v, u, p, t)

Define the velocity function for the harmonic oscillator.
This is part of the partitioned ODE system.

# Arguments
- `dv`: Vector to store velocity derivatives
- `v`: Current velocity vector
- `u`: Current position vector
- `p`: Parameters (unused)
- `t`: Current time

# Notes
- Implements the velocity equation: dx/dt = v
- Part of the partitioned ODE system for symplectic integration
"""
function harmonic_oscillator_v!(dv, v, u, p, t)
    dv[1] = v[1]  # dx/dt = v
end

"""
    harmonic_oscillator_f!(du, v, u, p, t)

Define the force function for the harmonic oscillator.
This is part of the partitioned ODE system.

# Arguments
- `du`: Vector to store position derivatives
- `v`: Current velocity vector
- `u`: Current position vector
- `p`: Parameters (unused)
- `t`: Current time

# Notes
- Implements the force equation: dv/dt = -(k/m)x
- Part of the partitioned ODE system for symplectic integration
"""
function harmonic_oscillator_f!(du, v, u, p, t)
    du[1] = -(SPRING_CONSTANT/MASS) * u[1]  # dv/dt = -(k/m)x
end

"""
    analytical_solution(t)

Calculate the analytical solution for position and velocity at time t.

# Arguments
- `t`: Time in seconds

# Returns
- Tuple of (position, velocity) in meters and meters per second

# Notes
- Uses the exact solution for simple harmonic motion
- Position: x(t) = A cos(ωt + φ)
- Velocity: v(t) = -Aω sin(ωt + φ)
"""
function analytical_solution(t)
    position = AMPLITUDE * cos(ANGULAR_FREQUENCY * t + PHASE)
    velocity = -AMPLITUDE * ANGULAR_FREQUENCY * sin(ANGULAR_FREQUENCY * t + PHASE)
    return position, velocity
end

"""
    calculate_energy(position, velocity)

Calculate the total energy of the oscillator.

# Arguments
- `position`: Current position in meters
- `velocity`: Current velocity in meters per second

# Returns
- Tuple of (kinetic_energy, potential_energy, total_energy) in joules

# Notes
- Kinetic energy: T = ½mv²
- Potential energy: V = ½kx²
- Total energy: E = T + V
"""
function calculate_energy(position, velocity)
    kinetic = 0.5 * MASS * velocity^2
    potential = 0.5 * SPRING_CONSTANT * position^2
    total = kinetic + potential
    return kinetic, potential, total
end

"""
    run_simulation() -> Tuple{Vector{Float64}, Vector{Float64}, Vector{Float64}, Vector{Float64}, Vector{Float64}}

Run the harmonic oscillator simulation and return time series data.

# Returns
- Tuple containing:
  - Time points
  - Numerical position
  - Numerical velocity
  - Analytical position
  - Analytical velocity

# Notes
- Uses VerletLeapfrog integrator for symplectic integration
- Fixed time step for stability
- Compares numerical and analytical solutions
"""
function run_simulation()
    # Initial conditions [position, velocity]
    u0 = [AMPLITUDE]  # initial position
    v0 = [0.0]       # initial velocity
    
    # Time span
    tspan = (T_START, T_END)
    
    # Create and solve the ODE problem
    prob = DynamicalODEProblem(harmonic_oscillator_f!, harmonic_oscillator_v!, v0, u0, tspan)
    sol = solve(prob, VerletLeapfrog(), dt=DT, saveat=DT)
    
    # Extract time points and solutions
    t = sol.t
    numerical_position = [sol(ti)[2][1] for ti in t]  # position is in the second component
    numerical_velocity = [sol(ti)[1][1] for ti in t]  # velocity is in the first component
    
    # Calculate analytical solutions
    analytical_pos = Float64[]
    analytical_vel = Float64[]
    for ti in t
        pos, vel = analytical_solution(ti)
        push!(analytical_pos, pos)
        push!(analytical_vel, vel)
    end
    
    return t, numerical_position, numerical_velocity, analytical_pos, analytical_vel
end

"""
    plot_solutions(t, numerical_position, numerical_velocity, analytical_pos, analytical_vel)

Create plots comparing numerical and analytical solutions.

# Arguments
- `t`: Time points
- `numerical_position`: Numerical position values
- `numerical_velocity`: Numerical velocity values
- `analytical_pos`: Analytical position values
- `analytical_vel`: Analytical velocity values

# Returns
- `fig`: Makie figure object containing the plots

# Notes
- Creates a 2x2 grid of plots:
  1. Position vs. time
  2. Velocity vs. time
  3. Phase space
  4. Energy components
"""
function plot_solutions(t, numerical_position, numerical_velocity, analytical_pos, analytical_vel)
    fig = Figure()
    
    # Position plot
    ax1 = Axis(fig[1, 1],
               xlabel="Time (s)",
               ylabel="Position (m)",
               title="Harmonic Oscillator Position",
               limits=(nothing, (-1.5, 1.5)),
               yautolimitmargin=(0.25, 0.05))
    
    lines!(ax1, t, numerical_position, label="Numerical")
    lines!(ax1, t, analytical_pos, label="Analytical", linestyle=:dash)
    axislegend(ax1, position=(0.5, 1.1), labelsize=10, orientation=:horizontal, padding=(2, 8, 2, 8), framevisible=false)
    
    # Velocity plot
    ax2 = Axis(fig[2, 1],
               xlabel="Time (s)",
               ylabel="Velocity (m/s)",
               title="Harmonic Oscillator Velocity",
               limits=(nothing, (-1.5, 1.5)),
               yautolimitmargin=(0.25, 0.05))
    
    lines!(ax2, t, numerical_velocity, label="Numerical")
    lines!(ax2, t, analytical_vel, label="Analytical", linestyle=:dash)
    axislegend(ax2, position=(0.5, 1.1), labelsize=10, orientation=:horizontal, padding=(2, 8, 2, 8), framevisible=false)
    
    # Phase space plot
    ax3 = Axis(fig[1, 2],
               xlabel="Position (m)",
               ylabel="Velocity (m/s)",
               title="Phase Space",
               limits=(nothing, (-1.5, 1.5)),
               yautolimitmargin=(0.25, 0.05))
    
    lines!(ax3, numerical_position, numerical_velocity, label="Numerical")
    lines!(ax3, analytical_pos, analytical_vel, label="Analytical", linestyle=:dash)
    axislegend(ax3, position=(0.5, 1.1), labelsize=10, orientation=:horizontal, padding=(2, 8, 2, 8), framevisible=false)
    
    # Energy plot
    ax4 = Axis(fig[2, 2],
               xlabel="Time (s)",
               ylabel="Energy (J)",
               title="Total Energy",
               limits=(nothing, (0, 0.6)),
               yautolimitmargin=(0.25, 0.05))
    
    # Calculate energies
    kinetic_energy = 0.5 .* MASS .* numerical_velocity.^2
    potential_energy = 0.5 .* SPRING_CONSTANT .* numerical_position.^2
    total_energy = kinetic_energy .+ potential_energy
    
    lines!(ax4, t, kinetic_energy, label="Kinetic")
    lines!(ax4, t, potential_energy, label="Potential")
    lines!(ax4, t, total_energy, label="Total")
    axislegend(ax4, position=(0.5, 1.1), labelsize=10, orientation=:horizontal, padding=(2, 8, 2, 8), framevisible=false)
    
    # Adjust layout
    rowgap!(fig.layout, 20)
    colgap!(fig.layout, 20)
    
    return fig
end

"""
    run_tests()

Run tests to verify the implementation.

# Notes
- Tests analytical solution at t=0
- Verifies periodicity
- Checks energy conservation
- Compares numerical and analytical solutions
"""
function run_tests()
    @testset "Harmonic Oscillator Tests" begin
        # Test analytical solution at t=0
        pos, vel = analytical_solution(0.0)
        @test isapprox(pos, AMPLITUDE, atol=1e-10)
        @test isapprox(vel, 0.0, atol=1e-10)
        
        # Test period
        period = 2π / ANGULAR_FREQUENCY
        pos1, _ = analytical_solution(0.0)
        pos2, _ = analytical_solution(period)
        @test isapprox(pos1, pos2, atol=1e-10)
        
        # Test energy conservation
        t, num_pos, num_vel, _, _ = run_simulation()
        kinetic = 0.5 .* MASS .* num_vel.^2
        potential = 0.5 .* SPRING_CONSTANT .* num_pos.^2
        total_energy = kinetic .+ potential
        
        # Energy should be nearly constant
        @test maximum(abs.(total_energy .- total_energy[1])) < 1e-6
        
        # Test numerical vs analytical solution
        _, num_pos, num_vel, ana_pos, ana_vel = run_simulation()
        @test maximum(abs.(num_pos .- ana_pos)) < 1e-5
        @test maximum(abs.(num_vel .- ana_vel)) < 1e-5
    end
end

"""
    main()

Main function to run the simulation and display results.

# Notes
- Prints configuration information
- Runs tests
- Executes simulation
- Creates and displays plots
"""
function main()
    println("Running harmonic oscillator simulation...")
    println("Configuration:")
    println("  - Mass: ", MASS, " kg")
    println("  - Spring constant: ", SPRING_CONSTANT, " N/m")
    println("  - Initial amplitude: ", AMPLITUDE, " m")
    println("  - Angular frequency: ", ANGULAR_FREQUENCY, " rad/s")
    println("  - Period: ", PERIOD, " s")
    println("  - Total energy: ", TOTAL_ENERGY, " J")
    println("----------------------------------------")
    
    # Run tests
    println("\nRunning tests...")
    run_tests()
    println("All tests passed!")
    
    # Run simulation
    println("\nRunning simulation...")
    t, num_pos, num_vel, ana_pos, ana_vel = run_simulation()
    
    # Create and display plots
    fig = plot_solutions(t, num_pos, num_vel, ana_pos, ana_vel)
    display(fig)
    
    println("\nSimulation complete!")
end

# Run the main function
main() 