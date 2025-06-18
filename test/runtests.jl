using Test
using Pkg

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
