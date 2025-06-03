# Design Document: PhysicsSnippets

## Part 1: Overall Project Design

This section covers the guiding principles for the entire collection of Physics Snippets.

1.  **Project Title**: PhysicsSnippets
2.  **Overall Project Goal & "Vibe"**:
    * **Goal**: To create a collection of beginner-to-intermediate level physics simulations/models in Julia, primarily for learning Julia, exploring its scientific computing ecosystem, and creating interesting visualizations. Assume that the target audience has a "Julia familiarity" of about 1.5 on a scale of 0 to 5, where 5 is the proficiency of the key Julia developers and 0 is 'Never heard of it'. The target audience has likely used Python or MATLAB and has seen enough of Julia to be able to understand how to do simple programming in Julia and to understand how they might transfer their MATLAB knowledge into Julia.
    * **"Vibe"**: Educational, exploratory, visually engaging, and focused on clear, idiomatic Julia code.
3.  **Target Audience**:
    * Physicists (at various levels) who are relatively new to the Julia language.
4.  **Core Technologies & Libraries**:
    * **Language**: Julia
    * **Primary Packages**:
        * `DifferentialEquations.jl`: For solving Ordinary Differential Equations (ODEs) and potentially Partial Differential Equations (PDEs).
        * `Makie.jl`: For creating 2D and 3D static plots and animations.
        * Other packages as needed, e.g., `LinearAlgebra`, `StaticArrays`, `Unitful` and so on
5.  **General Coding Style & Principles**:
    * **Clarity over Premature Optimization**: Code should be easy to read and understand, especially for those learning Julia.
    * **Idiomatic Julia**: Aim to use Julia's features and style effectively (e.g., multiple dispatch, broadcasting).
    * **Modularity**: Encapsulate distinct pieces of logic in functions.
    * **Comments**: Include comments to explain the physics, key code sections, and Julia-specific concepts, especially where it might be helpful for the target audience.
    * **Error Handling**: Basic error handling for invalid inputs where appropriate.
6.  **Overall Testing & Validation Strategy**:
    * **Comparison with Known Results**: Where possible, compare simulation outputs with analytical solutions (e.g., projectile motion without drag) or established results from textbooks/literature.
    * **Visual Inspection**: Visualizations should produce physically sensible behavior.
    * **Parameter Sensitivity**: Check if the model behaves as expected when parameters are varied.
    * **Code Review (Self or AI-assisted)**: Review generated code for correctness and adherence to style.
7.  **Directory Structure (Suggestion)**:
    * `/PhysicsSnippets`
        * `/src` (or `/scripts`)
            * `/01_PlanetaryOrbits`
                * `planetary_orbits.jl`
                * `README.md` (or notes within the .jl file based on this design doc)
            * `/02_DoublePendulum`
                * `double_pendulum.jl`
                * `README.md`
            * ... (for each snippet)
        * `/docs` (for these design documents, perhaps)
        * `Project.toml` (Julia environment manifest)
        * `README.md` (Overall project readme, based on this Part 1)

---

## Part 2: Individual Snippet Design Document Template

(Using **Snippet 11: Projectile Motion with Air Resistance** as an example)

---
### Snippet Design: 11. Projectile Motion with Air Resistance

1.  **Snippet Description & Goal**:
    * **Description from context.md**: Model a projectile’s trajectory, including the effects of air resistance, by solving ODEs with a drag force term.
    * **Expanded Goal**: To write a Julia script that numerically solves the equations of motion for a projectile subject to gravity and quadratic air resistance. The script should allow users to specify initial conditions and physical parameters, and then visualize the trajectory, comparing it to the no-drag case.

2.  **Core Physics & Mathematical Model**:
    * **Relevant Equations**:
        * Newton's Second Law: $\vec{F}_{net} = m\vec{a}$
        * Forces:
            * Gravity: $\vec{F}_g = (0, -mg)$ (assuming y is vertical)
            * Air Drag: $\vec{F}_d = -\frac{1}{2} \rho C_d A |\vec{v}| \vec{v}$ (or $-\frac{1}{2} \rho C_d A v^2 \hat{v}$, where $\hat{v}$ is the unit vector in the direction of $\vec{v}$)
        * Components of acceleration:
            * $a_x = \frac{F_{d,x}}{m} = -\frac{1}{2m} \rho C_d A v v_x$
            * $a_y = -g + \frac{F_{d,y}}{m} = -g -\frac{1}{2m} \rho C_d A v v_y$
            * where $v = \sqrt{v_x^2 + v_y^2}$
    * **Key Physical Parameters & Units**:
        * `m`: mass of projectile (kg)
        * `g`: acceleration due to gravity ($m/s^2$)
        * `rho` ($\rho$): air density ($kg/m^3$)
        * `Cd` ($C_d$): drag coefficient (dimensionless)
        * `A`: cross-sectional area ($m^2$)
        * `v0`: initial speed ($m/s$)
        * `theta0`: initial angle (degrees or radians)
        * `dt`: time step for numerical solution (s) - *if not using an adaptive solver*
        * `t_max`: maximum simulation time (s)
    * **Simplifications/Assumptions**:
        * Constant air density $\rho$.
        * Constant drag coefficient $C_d$.
        * No wind.
        * Earth is flat (constant $g$).
        * Projectile is a point mass (no spin/Magnus effect).
    
3.  **Implementation Details (for AI Guidance)**:
    * **Key Functions/Modules**:
        * `equ_of_motion(du, u, p, t)`: Function for `DifferentialEquations.jl`, where `u = [x, y, vx, vy]`, `p` contains parameters like `m, g, rho, Cd, A`. `du` will be `[vx, vy, ax, ay]`.
        * `run_simulation(params, initial_conditions, time_span)`: Sets up and solves the ODE problem.
        * `plot_trajectory(results_drag, results_no_drag, params)`: Generates the plot.
        * A function to calculate the no-drag trajectory analytically.
    * **Data Structures**:
        * Parameters: Perhaps a `struct` or `NamedTuple` for `(m, g, rho, Cd, A)`. Use what is the most 'Julian' typical choice.
        * State vector `u`: `[x_position, y_position, x_velocity, y_velocity]`.
        * Results: `ODESolution` object from `DifferentialEquations.jl`.
    * **Algorithm Outline**:
        1.  Define initial conditions: $(x_0, y_0, v_{x0}, v_{y0})$.
        2.  Define the system of ODEs ($a_x, a_y$) as a Julia function compatible with `DifferentialEquations.jl`.
        3.  (For comparison) Calculate the analytical no-drag trajectory or solve ODEs with drag parameters set to zero.
        4.  Use `DifferentialEquations.jl` to solve the ODEs for the case with drag.
        5.  Extract position data from both solutions.
        6.  Plot both trajectories.
    * **Specific Julia Packages to leverage**:
        * `DifferentialEquations.jl`: For `ODEProblem`, `solve`.
            * Solver: Generally `Tsit5` is a good starting choice, but make a different choice if warranted. Include rationale for choice in comments.
        * `Makie.jl`: For plotting.
        * `Parameters.jl` (optional, but nice for structs): e.g., `@with_kw struct PhysicalParams ... end`

4.  **Visualization Specifics**:
    * **Description from context.md**: Plot the trajectory and compare it to the ideal (no-drag) parabolic path.
    * **Type of Plot**: 2D line plot.
    * **What to Plot**:
        * Y-position vs. X-position for the trajectory with air drag.
        * Y-position vs. X-position for the trajectory without air drag (on the same axes).
    * **Labels, Titles, Legends**:
        * X-axis: "Horizontal Distance (m)"
        * Y-axis: "Vertical Distance (m)"
        * Title: "Projectile Motion: With vs. Without Air Resistance"
        * Legend: "With Air Drag", "No Air Drag"
    * **Specific `Makie.jl` features**: `lines()`, `axislegend()`, customizing line colors/styles.
    
5.  **Input Parameters (for the script/user)**:
    * `initial_velocity` (m/s)
    * `launch_angle_degrees` (degrees)
    * `mass` (kg)
    * `drag_coefficient` (dimensionless)
    * `air_density` (kg/m^3, e.g., 1.225 at sea level, 15°C)
    * `cross_sectional_area` (m^2)
    * `simulation_time_span` (seconds, e.g., `(0.0, 10.0)`)
    * *(Suggestion: Group physical constants like `g = 9.81` inside the script as defaults, but allow them to be part of the parameter structure for easy modification if needed.)*

6.  **Expected Output/Results**:
    * A `Makie.jl` plot window displaying two trajectories. The trajectory with air drag should exhibit a shorter range and lower maximum height compared to the idealized no-drag parabolic path.
    * The script might also print key comparative results to the console, such as:
        * Max height (drag vs. no-drag)
        * Range (drag vs. no-drag)
        * Time of flight (drag vs. no-drag)

7.  **Testing & Validation Notes for this Snippet**:
    * **No-Drag Case**: If $C_d = 0$ (or $\rho=0$ or $A=0$), the numerically solved trajectory should precisely match the analytical parabolic solution.
    * **Limiting Behavior**:
        * Very high drag (large $C_d$ or $A$ or $\rho$): Motion should be significantly damped; the projectile should fall more steeply and cover less distance.
        * Very low drag (small $C_d$ or $A$ or $\rho$): Should closely approach the no-drag case.
        * Varying mass: Heavier objects (larger `m`) should be less affected by drag for the same $C_d, A, \rho$.
    * **Energy Check**: Plot total mechanical energy (Kinetic + Potential) over time. For the no-drag case, it should be conserved. For the drag case, it should decrease due to work done by the non-conservative drag force.
    * **Visual Sanity Check**: Ensure the projectile follows a smooth, physically plausible path.

8.  **Learning Outcome Focus (from context.md)**: Understand drag forces and practice plotting trajectories.
    * Include explaination of the impact of the drag term on the x and y components of acceleration in the generated code