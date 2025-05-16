# Monte Carlo Pi Estimation in Julia

This example demonstrates how to estimate π using the Monte Carlo method in Julia. The scripts `monte_carlo_pi.jl` and `monte_carlo_pi_convergence.jl` are designed to be clear and educational for beginners, illustrating random sampling, statistical estimation, and scientific plotting in Julia.

## Problem Overview
The goal is to estimate the value of π by simulating random points in a square and counting how many fall inside an inscribed circle. The ratio of points inside the circle to the total number of points approximates π/4.

### Method
- Generate random points (x, y) uniformly in the unit square [0, 1] × [0, 1].
- Count how many points fall inside the quarter circle of radius 1 (i.e., x² + y² ≤ 1).
- Estimate π as:

      π ≈ 4 × (number of points inside circle) / (total number of points)

- The accuracy improves as the number of random points increases.

## Implementation Details
- **Random Sampling:** Uses Julia's `rand()` function to generate random (x, y) pairs.
- **Counting:** Uses a simple loop or vectorized operation to count points inside the circle.
- **Convergence Analysis:** The script `monte_carlo_pi_convergence.jl` runs the estimation for increasing numbers of points (up to 100 million) and plots the convergence and execution time.
- **Testing:** The script can be easily extended to test statistical properties (e.g., mean, variance) of the estimator.

## Visualization and Plotting Settings
- **Scatter Plot:**
  - Points inside the circle are colored differently from those outside, visually illustrating the Monte Carlo method.
  - The circle and square are drawn for reference.
- **Convergence Plot:**
  - Shows how the estimate of π approaches the true value as the number of points increases.
  - Includes a reference line for the true value of π.
- **Performance Plot:**
  - Plots execution time vs. number of points, with an O(n) reference line for comparison.
- **Legend Placement:**
  - Legends are placed to avoid overlap with data, using Makie's legend positioning options.
- **Axis Limits and Margins:**
  - Adjusted to ensure all points and reference shapes are visible.

## Lessons Learned
- **Randomness and Convergence:**
  - Monte Carlo methods converge slowly (error ~ 1/√N). Large numbers of samples are needed for high accuracy.
  - Results will vary between runs due to randomness unless a random seed is set.
- **Plotting in Julia:**
  - Makie makes it easy to create clear, publication-quality scatter plots and convergence plots.
  - Legend and axis adjustments may be needed for best appearance.
- **Performance:**
  - Vectorized operations and preallocation can significantly speed up large simulations.
  - Execution time grows linearly with the number of points (O(n)).

## Further Exploration
- Try different random number generators or set a seed for reproducibility.
- Animate the convergence of the estimate as more points are added.
- Extend to estimate areas of more complex shapes.
- Compare the Monte Carlo estimate to other numerical integration methods.

---

**This example is part of a collection of beginner-friendly Julia physics snippets.**
See the repository for more examples and learning resources. 