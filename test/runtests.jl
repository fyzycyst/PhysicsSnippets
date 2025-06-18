using Test
using Pkg

# Activate the project environment
Pkg.activate(@__DIR__)

# Include the project
using PhysicsSnippets

@testset "Basic CI Test" begin
    @test 1 + 1 == 2
end

# Add a test for the planetary orbits module
@testset "Planetary Orbits" begin
    # Basic test to ensure the module loads
    @test true
end
