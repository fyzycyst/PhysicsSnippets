"""
Monte Carlo Pi Estimation

This script demonstrates how to estimate π using the Monte Carlo method.
The method works by:
1. Drawing random points in a 2x2 square centered at the origin
2. Counting how many points fall inside a unit circle inscribed in the square
3. The ratio of points inside the circle to total points approaches π/4 as n → ∞

The standard error of the estimate decreases as 1/√N, where N is the number of points.
This makes it a good example of Monte Carlo integration and statistical estimation.

Author: fyzycyst
"""

using CairoMakie
using Random
using Statistics
using Test

# Configuration parameters
# ---------------------
const N_POINTS = 10_000  # Number of random points
const RANDOM_SEED = 42   # For reproducibility
const SQUARE_SIZE = 2.0  # Size of the square (2×2)
const CIRCLE_RADIUS = 1.0  # Radius of the inscribed circle

# Set a random seed for reproducibility
Random.seed!(RANDOM_SEED)

"""
    generate_points(n::Int) -> Tuple{Vector{Float64}, Vector{Float64}}

Generate n random points in a 2×2 square centered at the origin.

# Arguments
- `n::Int`: Number of points to generate

# Returns
- Tuple of (x, y) coordinates as separate vectors

# Notes
- Points are uniformly distributed in [-1, 1] × [-1, 1]
- Uses Julia's built-in random number generator
"""
function generate_points(n::Int)
    # Generate random points in [-1, 1] × [-1, 1]
    x = rand(n) .* SQUARE_SIZE .- SQUARE_SIZE/2  # Scale [0,1] to [-1,1]
    y = rand(n) .* SQUARE_SIZE .- SQUARE_SIZE/2
    return x, y
end

"""
    is_inside_circle(x::Float64, y::Float64) -> Bool

Check if a point (x,y) lies inside the unit circle centered at the origin.

# Arguments
- `x::Float64`: x-coordinate of the point
- `y::Float64`: y-coordinate of the point

# Returns
- `Bool`: true if point is inside the circle, false otherwise

# Notes
- A point is inside if x² + y² ≤ 1
- Circle is centered at origin with radius 1
"""
function is_inside_circle(x::Float64, y::Float64)
    return x^2 + y^2 ≤ CIRCLE_RADIUS^2
end

"""
    is_inside_circle(x::Int64, y::Int64) -> Bool

Check if a point (x,y) lies inside the unit circle centered at the origin.

# Arguments
- `x::Int64`: x-coordinate of the point
- `y::Int64`: y-coordinate of the point

# Returns
- `Bool`: true if point is inside the circle, false otherwise

# Notes
- A point is inside if x² + y² ≤ 1
- Circle is centered at origin with radius 1
"""
function is_inside_circle(x::Int64, y::Int64)
    return is_inside_circle(Float64(x), Float64(y))
end

"""
    estimate_pi(n::Int) -> Tuple{Float64, Vector{Float64}, Vector{Float64}, Vector{Bool}}

Estimate π using n random points.

# Arguments
- `n::Int`: Number of random points to use

# Returns
- Tuple containing:
  - Estimated value of π
  - x coordinates of points
  - y coordinates of points
  - Boolean mask indicating which points are inside the circle

# Notes
- Uses Monte Carlo method: π ≈ 4 × (points inside / total points)
- Standard error decreases as 1/√n
"""
function estimate_pi(n::Int)
    # Generate random points
    x, y = generate_points(n)
    
    # Check which points are inside the circle
    inside = is_inside_circle.(x, y)
    
    # Calculate π estimate: 4 * (points inside / total points)
    pi_estimate = 4 * sum(inside) / n
    
    return pi_estimate, x, y, inside
end

"""
    calculate_statistics(pi_estimate::Float64, n::Int) -> Tuple{Float64, Float64}

Calculate statistical properties of the π estimate.

# Arguments
- `pi_estimate::Float64`: Estimated value of π
- `n::Int`: Number of points used

# Returns
- Tuple of (standard_error, confidence_interval)

# Notes
- Standard error = 1/√n
- 95% confidence interval = ±1.96 × standard_error
"""
function calculate_statistics(pi_estimate::Float64, n::Int)
    standard_error = 1.0 / sqrt(n)
    confidence_interval = 1.96 * standard_error
    return standard_error, confidence_interval
end

"""
    visualize_estimation(x::Vector{Float64}, y::Vector{Float64}, inside::AbstractVector{Bool})

Create a scatter plot showing the random points, with different colors
for points inside and outside the circle.

# Arguments
- `x::Vector{Float64}`: x-coordinates of points
- `y::Vector{Float64}`: y-coordinates of points
- `inside::AbstractVector{Bool}`: Boolean mask for points inside circle

# Returns
- `fig`: Makie figure object containing the plot

# Notes
- Points inside circle are blue
- Points outside circle are red
- Circle boundary is shown in black
- Plot has equal aspect ratio
"""
function visualize_estimation(x::Vector{Float64}, y::Vector{Float64}, inside::AbstractVector{Bool})
    # Create a new figure
    fig = Figure()
    ax = Axis(fig[1, 1], 
              aspect=DataAspect(),
              title="Monte Carlo Pi Estimation",
              xlabel="x",
              ylabel="y")
    
    # Plot points inside circle in blue, outside in red
    scatter!(ax, x[inside], y[inside], color=:blue, label="Inside")
    scatter!(ax, x[.!inside], y[.!inside], color=:red, label="Outside")
    
    # Add a circle to show the boundary
    circle = Circle(Point2f(0, 0), CIRCLE_RADIUS)
    lines!(ax, circle, color=:black, linewidth=2)
    
    # Add legend and grid
    axislegend(ax)
    ax.xgridvisible = true
    ax.ygridvisible = true
    
    return fig
end

"""
    run_tests()

Run tests to verify the implementation.

# Notes
- Tests point generation
- Verifies circle membership
- Checks π estimation accuracy
- Validates statistical properties
"""
function run_tests()
    @testset "Monte Carlo Pi Tests" begin
        # Test point generation
        x, y = generate_points(1000)
        @test length(x) == length(y) == 1000
        @test all(-1 .≤ x .≤ 1)
        @test all(-1 .≤ y .≤ 1)
        
        # Test circle membership
        @test is_inside_circle(0, 0)  # Center
        @test is_inside_circle(0.5, 0.5)  # Inside
        @test !is_inside_circle(1, 1)  # Outside
        @test is_inside_circle(1, 0)  # On boundary
        
        # Test π estimation
        pi_est, _, _, _ = estimate_pi(100_000)
        @test abs(pi_est - π) < 0.1  # Should be within 0.1 of π
        
        # Test statistics
        std_err, conf_int = calculate_statistics(pi_est, 100_000)
        @test std_err > 0
        @test conf_int > std_err
    end
end

"""
    main()

Main function to run the simulation and display results.

# Notes
- Sets up random number generator
- Runs tests
- Performs π estimation
- Calculates statistics
- Creates visualization
"""
function main()
    println("Running Monte Carlo Pi estimation...")
    println("Configuration:")
    println("  - Number of points: ", N_POINTS)
    println("  - Random seed: ", RANDOM_SEED)
    println("  - Square size: ", SQUARE_SIZE, "×", SQUARE_SIZE)
    println("  - Circle radius: ", CIRCLE_RADIUS)
    println("----------------------------------------")
    
    # Run tests
    println("\nRunning tests...")
    run_tests()
    println("All tests passed!")
    
    # Estimate π
    println("\nEstimating π...")
    pi_estimate, x, y, inside = estimate_pi(N_POINTS)
    
    # Calculate statistics
    std_err, conf_int = calculate_statistics(pi_estimate, N_POINTS)
    
    # Print results
    println("\nResults:")
    println("  - Estimated π: ", pi_estimate)
    println("  - Actual π: ", π)
    println("  - Absolute error: ", abs(pi_estimate - π))
    println("  - Standard error: ", std_err)
    println("  - 95% confidence interval: ±", conf_int)
    
    # Create and display visualization
    println("\nCreating visualization...")
    fig = visualize_estimation(x, y, inside)
    display(fig)
    
    println("\nSimulation complete!")
end

# Run the main function
main() 