"""
Monte Carlo Pi Estimation Convergence Analysis

This script analyzes how the accuracy of π estimation improves with increasing
number of points, while also measuring execution time. It starts with 1000 points
and increases by powers of 10 up to MAX_POINTS, with a TIME_LIMIT_SECONDS limit per iteration.

Author: fyzycyst
"""

using CairoMakie
using Random
using Statistics
using Printf

# Configuration parameters
# ----------------------
# Maximum number of points to test (in powers of 10)
# WARNING: Setting this too high (e.g., > 1e9) may:
#   - Consume excessive memory
#   - Take extremely long to complete
#   - Potentially crash your system
const MAX_POINTS = 100_000_000  # 100 million points

# Time limit per iteration in seconds
# WARNING: Setting this too high may result in very long execution times
# Recommended: 60-300 seconds depending on your system's performance
const TIME_LIMIT_SECONDS = 120

# Starting number of points (in powers of 10)
const START_POINTS = 1_000  # 1 thousand points

# Reuse the core functions from monte_carlo_pi.jl
"""
    generate_points(n::Int) -> Tuple{Vector{Float64}, Vector{Float64}}

Generate n random points in a 2x2 square centered at the origin.
Returns x and y coordinates as separate vectors.
"""
function generate_points(n::Int)
    x = rand(n) .* 2 .- 1
    y = rand(n) .* 2 .- 1
    return x, y
end

"""
    is_inside_circle(x::Float64, y::Float64) -> Bool

Check if a point (x,y) lies inside the unit circle centered at the origin.
"""
function is_inside_circle(x::Float64, y::Float64)
    return x^2 + y^2 ≤ 1
end

"""
    estimate_pi(n::Int) -> Float64

Estimate π using n random points.
"""
function estimate_pi(n::Int)
    x, y = generate_points(n)
    inside = is_inside_circle.(x, y)
    return 4 * sum(inside) / n
end

"""
    run_convergence_analysis() -> Tuple{Vector{Int}, Vector{Float64}, Vector{Float64}}

Run the convergence analysis with increasing number of points.
Returns:
- Vector of point counts used
- Vector of absolute errors
- Vector of execution times (in seconds)
"""
function run_convergence_analysis()
    # Initialize arrays to store results
    point_counts = Int[]
    errors = Float64[]
    times = Float64[]
    
    # Calculate the sequence of point counts using half-powers of 10
    max_power = log10(MAX_POINTS)
    start_power = log10(START_POINTS)
    # Generate sequence with 0.5 step size
    powers = start_power:0.5:max_power
    point_counts_sequence = Int.(round.(10 .^ powers))
    
    for n in point_counts_sequence
        println("Processing n = ", n, " points...")
        
        # Time the estimation
        start_time = time()
        pi_estimate = estimate_pi(n)
        elapsed_time = time() - start_time
        
        # Calculate absolute error
        error = abs(pi_estimate - π)
        
        # Store results
        push!(point_counts, n)
        push!(errors, error)
        push!(times, elapsed_time)
        
        # Print current results
        @printf("n = %d: π ≈ %.10f, error = %.10f, time = %.2f seconds\n",
                n, pi_estimate, error, elapsed_time)
        
        # Check if we've exceeded the time limit
        if elapsed_time > TIME_LIMIT_SECONDS
            println("\nTime limit (", TIME_LIMIT_SECONDS, " seconds) exceeded at n = ", n)
            break
        end
    end
    
    return point_counts, errors, times
end

"""
    plot_convergence(point_counts::Vector{Int}, errors::Vector{Float64}, times::Vector{Float64})

Create a figure with two subplots:
1. Absolute error vs number of points (log-log scale)
2. Execution time vs number of points (log-log scale)
"""
function plot_convergence(point_counts::Vector{Int}, errors::Vector{Float64}, times::Vector{Float64})
    fig = Figure()
    
    # Error plot
    ax1 = Axis(fig[1, 1],
               xscale=log10,
               yscale=log10,
               xlabel="Number of Points",
               ylabel="Absolute Error",
               title="Convergence of Monte Carlo Pi Estimation")
    
    scatter!(ax1, point_counts, errors, label="Measured Error")
    
    # Add theoretical convergence line (1/√n)
    theoretical_error = 1 ./ sqrt.(point_counts)
    lines!(ax1, point_counts, theoretical_error, color=:red, label="Theoretical (1/√n)")
    
    # Place legend in upper right for error plot (default position)
    axislegend(ax1)
    
    # Time plot
    ax2 = Axis(fig[2, 1],
               xscale=log10,
               yscale=log10,
               xlabel="Number of Points",
               ylabel="Execution Time (seconds)",
               title="Performance Analysis")
    
    scatter!(ax2, point_counts, times, label="Measured Time")
    
    # Add theoretical time complexity line (linear) using second point as reference
    # to avoid JIT compilation overhead in first run
    if length(point_counts) >= 2
        theoretical_time = times[2] * point_counts ./ point_counts[2]
        lines!(ax2, point_counts, theoretical_time, color=:red, label="Theoretical (O(n))")
    end
    
    # Place legend in lower right for time plot
    axislegend(ax2, position=:rb)
    
    # Adjust layout
    rowgap!(fig.layout, 20)
    
    return fig
end

# Main execution
function main()
    println("Starting Monte Carlo Pi convergence analysis...")
    println("Configuration:")
    println("  - Starting points: ", START_POINTS)
    println("  - Maximum points: ", MAX_POINTS)
    println("  - Time limit per iteration: ", TIME_LIMIT_SECONDS, " seconds")
    println("----------------------------------------")
    
    # Run the analysis
    point_counts, errors, times = run_convergence_analysis()
    
    # Create and display the plots
    fig = plot_convergence(point_counts, errors, times)
    display(fig)
    
    println("\nAnalysis complete!")
    println("Final results:")
    @printf("Largest n tested: %d\n", point_counts[end])
    @printf("Final error: %.10f\n", errors[end])
    @printf("Total time: %.2f seconds\n", sum(times))
end

# Run the main function
main() 