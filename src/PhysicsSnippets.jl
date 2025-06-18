module PhysicsSnippets

using DifferentialEquations
using CairoMakie
using StaticArrays
using Unitful
using UnitfulAstro
using LinearAlgebra
using Test

# Re-export commonly used functions
export Planet, simulate_solar_system, plot_orbits_2d, calculate_energy

# Export all the physics snippets
include("01_PlanetaryOrbits/planetary_orbits.jl")
# Add other includes as needed

end # module 