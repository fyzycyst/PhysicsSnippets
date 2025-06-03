# Monte Carlo Pi Estimation

This snippet estimates the value of π using a Monte Carlo method by generating random points in a square and counting how many fall inside an inscribed circle.

## Core Physics & Mathematical Model

### Relevant Equations
- Area of unit circle: $A_{circle} = \pi r^2 = \pi$ (for r = 1)
- Area of 2×2 square: $A_{square} = 4$
- Ratio of areas: $\frac{A_{circle}}{A_{square}} = \frac{\pi}{4}$
- Monte Carlo estimate: $\pi \approx 4 \times \frac{N_{inside}}{N_{total}}$
- Standard error: $\sigma \approx \frac{1}{\sqrt{N}}$

### Key Physical Parameters & Units
- Square dimensions: 2×2 units centered at origin
- Circle radius: 1 unit
- Number of points: 10,000 (configurable)
- Random seed: 42 (for reproducibility)

### Simplifications/Assumptions
- Points are uniformly distributed
- Perfect circle inscribed in square
- Points are infinitesimal (no size)
- No measurement errors
- Random number generator is unbiased
- Points are independent and identically distributed

## Implementation Details

### Key Functions
- `generate_points(n)`: Generate random points in square
- `is_inside_circle(x, y)`: Check if point is inside circle
- `estimate_pi(n)`: Calculate π estimate
- `visualize_estimation(x, y, inside)`: Create scatter plot

### Data Structures
- Point coordinates: `Vector{Float64}` for x and y
- Inside/outside mask: `Vector{Bool}`
- Plot elements: Circle, scatter points, legend

### Algorithm Outline
1. Set random seed for reproducibility
2. Generate n random points in [-1,1]×[-1,1]
3. Check which points satisfy x² + y² ≤ 1
4. Calculate π estimate as 4 × (points inside / total)
5. Visualize results with scatter plot

### Specific Julia Packages
- `CairoMakie`: For static visualization
- `Random`: For random number generation
- `Statistics`: For statistical analysis

## Visualization Specifics

### Type of Plot
- Scatter plot showing:
  - Points inside circle (blue)
  - Points outside circle (red)
  - Circle boundary (black line)

### Plot Elements
- Square boundary (implicit)
- Unit circle
- Scatter points with legend
- Axis labels and title
- Equal aspect ratio
- Grid lines

## Testing & Validation

### Convergence Analysis
- Error decreases as 1/√N
- Multiple runs show consistent behavior
- Standard error estimation
- Comparison with known π value

### Statistical Properties
- Unbiased estimator
- Variance analysis
- Confidence intervals
- Distribution of estimates

### Visual Checks
- Points appear uniformly distributed
- Circle is properly drawn
- Color coding is correct
- Aspect ratio is maintained

## Learning Outcomes
- Understanding of Monte Carlo methods
- Practice with random number generation
- Experience with statistical estimation
- Visualization of geometric probability
- Error analysis and convergence

## Usage
```julia
julia> include("monte_carlo_pi.jl")
```

## Dependencies
- CairoMakie
- Random
- Statistics

## Further Exploration
- Try different random number generators
- Analyze convergence rate
- Compare with other π estimation methods
- Extend to 3D (sphere in cube)
- Add interactive controls
- Implement parallel computation
- Study variance reduction techniques
- Add confidence interval visualization 