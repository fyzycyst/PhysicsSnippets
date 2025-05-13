"""
Monte Carlo Pi Estimation

This script demonstrates how to estimate π using the Monte Carlo method.
The method works by:
1. Drawing random points in a 2x2 square centered at the origin
2. Counting how many points fall inside a unit circle inscribed in the square
3. The ratio of points inside the circle to total points approaches π/4 as n → ∞

Author: fyzycyst
"""

using CairoMakie  # Using CairoMakie as the backend for static plots
using Random
using Statistics

# Set a random seed for reproducibility
Random.seed!(42)

"""
    generate_points(n::Int) -> Tuple{Vector{Float64}, Vector{Float64}}

Generate n random points in a 2x2 square centered at the origin.
Returns x and y coordinates as separate vectors.
"""
function generate_points(n::Int)
    # Generate random points in [-1, 1] × [-1, 1]
    x = rand(n) .* 2 .- 1  # Scale [0,1] to [-1,1]
    y = rand(n) .* 2 .- 1
    return x, y
end

"""
    is_inside_circle(x::Float64, y::Float64) -> Bool

Check if a point (x,y) lies inside the unit circle centered at the origin.
A point is inside if x² + y² ≤ 1.
"""
function is_inside_circle(x::Float64, y::Float64)
    return x^2 + y^2 ≤ 1
end

"""
    estimate_pi(n::Int) -> Tuple{Float64, Vector{Float64}, Vector{Float64}, Vector{Bool}}

Estimate π using n random points.
Returns:
- The estimated value of π
- x coordinates of points
- y coordinates of points
- Boolean mask indicating which points are inside the circle
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
    visualize_estimation(x::Vector{Float64}, y::Vector{Float64}, inside::AbstractVector{Bool})

Create a scatter plot showing the random points, with different colors
for points inside and outside the circle.
"""
function visualize_estimation(x::Vector{Float64}, y::Vector{Float64}, inside::AbstractVector{Bool})
    # Create a new figure
    fig = Figure()
    ax = Axis(fig[1, 1], aspect=DataAspect())
    
    # Plot points inside circle in blue, outside in red
    scatter!(ax, x[inside], y[inside], color=:blue, label="Inside")
    scatter!(ax, x[.!inside], y[.!inside], color=:red, label="Outside")
    
    # Add a circle to show the boundary
    circle = Circle(Point2f(0, 0), 1)
    lines!(ax, circle, color=:black, linewidth=2)
    
    # Add labels and title
    axislegend(ax)
    ax.title = "Monte Carlo Pi Estimation"
    ax.xlabel = "x"
    ax.ylabel = "y"
    
    return fig
end

# Main execution
function main()
    # Number of points to use
    n = 10_000
    
    # Estimate π
    pi_estimate, x, y, inside = estimate_pi(n)
    
    # Print results
    println("Number of points: ", n)
    println("Estimated π: ", pi_estimate)
    println("Actual π: ", π)
    println("Absolute error: ", abs(pi_estimate - π))
    
    # Create and display visualization
    fig = visualize_estimation(x, y, inside)
    display(fig)
end

# Run the main function
main() 