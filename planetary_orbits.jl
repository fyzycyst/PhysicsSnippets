using DifferentialEquations
using CairoMakie
using StaticArrays
using Unitful
using UnitfulAstro
using LinearAlgebra

# Constants
const G = 6.67430e-11u"m^3/kg/s^2"  # Gravitational constant
const AU = 149597870700u"m"         # Astronomical Unit
const M_sun = 1.989e30u"kg"         # Solar mass

# Planet data structure
struct Planet
    name::String
    mass::typeof(1.0u"kg")
    initial_position::SVector{3,typeof(1.0u"m")}
    initial_velocity::SVector{3,typeof(1.0u"m/s")}
end

# Function to calculate acceleration due to gravity
"""
    gravity_acceleration!(du, u, p, t)

ODE function for planetary orbits. Each planet feels only the Sun's gravity (fixed at the origin).
"""
function gravity_acceleration!(du, u, p, t)
    G, M_sun = p
    N = Int(length(u) / 6)
    for i in 1:N
        # Position and velocity of planet i
        r = SVector(u[6i-5], u[6i-4], u[6i-3])
        v = SVector(u[6i-2], u[6i-1], u[6i])
        # Acceleration due to Sun at origin
        r_mag = norm(r)
        acc = -G * M_sun * r / r_mag^3
        du[6i-5:6i-3] = v
        du[6i-2:6i] = acc
    end
end

# Function to calculate total energy of the system
function calculate_energy(u, p)
    G, masses, positions = p
    T = 0.0  # Kinetic energy
    V = 0.0  # Potential energy
    
    # Calculate kinetic energy
    for i in 1:length(masses)
        v = u[6i-2:6i]
        T += 0.5 * masses[i] * dot(v, v)
    end
    
    # Calculate potential energy
    for i in 1:length(masses)
        for j in (i+1):length(masses)
            r = positions[j] - positions[i]
            r_mag = norm(r)
            V -= G * masses[i] * masses[j] / r_mag
        end
    end
    
    return T + V
end

# Helper function to strip units
function strip_units(x::Quantity)
    return ustrip(x)
end

# Main simulation function
"""
    simulate_solar_system(tspan=(0.0, 687*86400.0))

Simulate the inner solar system for one Martian year (687 days, in seconds).
Returns the solution and planet list.
"""
function simulate_solar_system(tspan=(0.0, 687*86400.0))  # 1 Mars year in seconds
    # Compute correct circular velocity for Mars
    mars_r = 1.524 * AU
    mars_v = sqrt(G * M_sun / mars_r)
    planets = [
        Planet("Mercury", 3.285e23u"kg", 
               SVector(0.387*AU, 0.0u"m", 0.0u"m"),
               SVector(0.0u"m/s", 47.36e3u"m/s", 0.0u"m/s")),
        Planet("Venus", 4.867e24u"kg",
               SVector(0.723*AU, 0.0u"m", 0.0u"m"),
               SVector(0.0u"m/s", 35.02e3u"m/s", 0.0u"m/s")),
        Planet("Earth", 5.972e24u"kg",
               SVector(1.0*AU, 0.0u"m", 0.0u"m"),
               SVector(0.0u"m/s", 29.78e3u"m/s", 0.0u"m/s")),
        Planet("Mars", 6.39e23u"kg",
               SVector(mars_r, 0.0u"m", 0.0u"m"),
               SVector(0.0u"m/s", mars_v, 0.0u"m/s"))
    ]
    
    # Prepare initial conditions
    u0 = Float64[]
    for p in planets
        # Strip units before adding to state vector
        append!(u0, [strip_units(p.initial_position[1]), 
                     strip_units(p.initial_position[2]), 
                     strip_units(p.initial_position[3]),
                     strip_units(p.initial_velocity[1]), 
                     strip_units(p.initial_velocity[2]), 
                     strip_units(p.initial_velocity[3])])
    end
    
    # Debug: print initial position and velocity for Earth
    # println("Initial position for Earth (m): ", [strip_units(planets[3].initial_position[i]) for i in 1:3])
    # println("Initial velocity for Earth (m/s): ", [strip_units(planets[3].initial_velocity[i]) for i in 1:3])
    
    # Parameters for the ODE solver: just G and M_sun
    p = (strip_units(G), strip_units(M_sun))
    
    # Solve the ODE
    prob = ODEProblem(gravity_acceleration!, u0, tspan, p)
    sol = solve(prob, Tsit5(), reltol=1e-8, abstol=1e-8, saveat=86400.0)  # daily samples
    
    return sol, planets
end

# Visualization function
"""
    plot_orbits_2d(sol, planets)

Plot the orbits in the x-y plane (2D) with the Sun at the origin.
"""
function plot_orbits_2d(sol, planets)
    fig = Figure()
    ax = Axis(fig[1, 1], 
                title="Planetary Orbits (2D, 1 Mars Year)",
                xlabel="X (AU)",
                ylabel="Y (AU)",
                limits=(-1.7, 1.7, -1.7, 1.7),
                aspect=1,
                xgridvisible=true,
                ygridvisible=true)
    colors = [:red, :orange, :blue, :brown]
    handles = []
    labels = []
    # Orbits and planet markers
    # First, collect start and end handles for Mercury (for legend order)
    x1 = [sol[j][1]/strip_units(AU) for j in 1:length(sol)]
    y1 = [sol[j][2]/strip_units(AU) for j in 1:length(sol)]
    h_start = scatter!(ax, [x1[1]], [y1[1]], color=colors[1], marker=:circle, markersize=8)
    h_end = scatter!(ax, [x1[end]], [y1[end]], color=colors[1], marker=:rect, markersize=8)
    push!(handles, h_start)
    push!(labels, "Start")
    push!(handles, h_end)
    push!(labels, "End")
    # Now plot all orbits and markers
    for (i, p) in enumerate(planets)
        x = [sol[j][6i-5]/strip_units(AU) for j in 1:length(sol)]
        y = [sol[j][6i-4]/strip_units(AU) for j in 1:length(sol)]
        # Draw the orbit trace
        h1 = lines!(ax, x, y, color=colors[i])
        push!(handles, h1)
        push!(labels, p.name)
        # Mark starting and ending positions for all planets (not in legend)
        scatter!(ax, [x[1]], [y[1]], color=colors[i], marker=:circle, markersize=8)
        scatter!(ax, [x[end]], [y[end]], color=colors[i], marker=:rect, markersize=8)
    end
    # Sun
    h_sun = scatter!(ax, [0.0], [0.0], color=:yellow, marker=:star5, markersize=16)
    push!(handles, h_sun)
    push!(labels, "Sun")
    # Place legend in second column
    Legend(fig[1, 2], handles, labels)
    return fig
end

# Run simulation and plot
sol, planets = simulate_solar_system()
fig = plot_orbits_2d(sol, planets)
save("planetary_orbits.png", fig) 