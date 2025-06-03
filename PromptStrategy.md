 ### AI Prompting Strategy Ideas: 
    * **Initial Prompt for ODE function**: "Write a Julia function suitable for `DifferentialEquations.jl` that defines the 2D equations of motion for a projectile. The state vector `u` should be `[x, y, vx, vy]`. The function should take `du, u, p, t` as arguments. Parameters `p` should include mass `m`, gravitational acceleration `g`, air density `rho`, drag coefficient `Cd`, and cross-sectional area `A`. Implement quadratic air drag force: $F_d = -0.5 * rho * Cd * A * |v| * v$." 
    * **Prompt for Simulation Setup**: "Using the ODE function from above, write a Julia script segment that: 
        1.  Defines default physical parameters (mass, g, rho, Cd, A) and initial conditions (initial velocity, launch angle). 
        2.  Sets up an `ODEProblem` for a specified time span. 
        3.  Solves the `ODEProblem` using an appropriate solver from `DifferentialEquations.jl` (e.g., `Tsit5()`). 
        4.  Also, sets up and solves the problem for the no-drag case (e.g., by setting Cd=0 or by using analytical equations)."  
    * **Prompt for Visualization**: "Using `Makie.jl`, generate a 2D plot showing: 
        1.  The trajectory (y vs. x) for the projectile with air drag (e.g., blue line). 
        2.  The trajectory (y vs. x) for the projectile without air drag (e.g., red dashed line) on the same axes. 
        3.  Include appropriate axis labels ('Horizontal Distance (m)', 'Vertical Distance (m)'), a title ('Projectile Motion: With vs. Without Air Resistance'), and a legend." 
    * **Follow-up/Refinement Prompts**: 
        * "Package the parameters `m, g, rho, Cd, A` into a Julia struct named `ProjectileParams` using `Parameters.jl` with default values." 
        * "Refactor the script to include a main function `run_projectile_simulation(initial_velocity, launch_angle_degrees; params...)` that runs the simulation and generates the plot." 
        * "Add comments to the ODE function explaining the calculation of drag force components." 
        * "Print the calculated maximum height and range for both trajectories to the console." 
        * "Add another plot showing the kinetic, potential, and total energy vs. time for the trajectory with drag." 