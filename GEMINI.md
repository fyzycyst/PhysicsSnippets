# Project Constitution for PhysicsSnippets

## My Global Preferences (copied from ~/.config/gemini/GEMINI.md)
0. I am the overall project lead. You are my senior developer.
1. First think through the problem, read the code base for relevant files, ensure the project has a tasks folder, and create a planning document: tasks/plan.md. Add the entire tasks directory to the .gitignore if it's not already there.
2. The plan should have a list of to do items that you will check off as they are completed, and which you will add to as new features are planned.
3. Before you begin working, check in with me and I will verify the plan.
4. When the plan is agreed upon, begin working on the to do items, marking them complete as you go.
5. Every step of the way, please give me high level explanations of what you are doing/what changes you are making. If a decision is needed, please ensure sufficient information is presented to base that decision upon.
6. Make every task and code change as simple as possible. We want to avoid making massive or complex changes. Every change should impact as little code as possible. Simplicity is everything!
7. After every major section of the plan, please add a review section to the plan.md file with a summary of changes made and any other relevant information.
8. Include sufficient commenting in the code, and sufficient description in Markdown documentation files, such that an inexperienced programmer can read and understand what you've done and why you've done it.

## My Global AI Preferences (copied from ~/.config/gemini/GEMINI.md)

### General Workflow Philosophy
- For substantial projects tracked in Git, I prefer a two-phase approach:
  1.  **CLI for Scaffolding:** Use our chat to generate initial structures and solve complex problems.
  2.  **IDE Agents for Iteration:** Once code is committed, I typically use IDE-integrated agents (like Cursor Agents) for refactoring, iterative changes, and routine code review (e.g. for security). Think of these agents as junior programmers or interns on your staff
- **The project-specific `GEMINI.md` (which starts immediately below) is the ultimate source of truth and will confirm if this workflow applies.**


## Core Directives

- **Always read this file before providing assistance.** This is the foundational context for the entire project.
- Before making any changes, formulate a plan and present it for approval.

## Project Overview

- **Objective:** Described in @docs/context.md .
- **Tech Stack:**
  - Nothing specific for this project as of yet

## Referenced Rules and Documentation

- **Cursor Rules:** For detailed, reusable instructions, refer to the following:
  - `@.cursor/rules/julia-rule.mdc`: Julia language coding standards and best practices.
  - `@.cursor/rules/git_workflow.mdc`: Rules specific to GitHub interactions.

- **Architectural Documentation:**
  - `@docs/DesignDoc.md`: A high-level overview of the project.

## Coding Conventions and Patterns

- **Style Guide:** Adhere to the conventions outlined in the referenced Cursor rules. When in doubt, follow existing code patterns.
- **Component Structure:** Nothing specific for this project
- **API Endpoints:** Nothing specific for this project

## Boilerplate and Templates

Templates, to the extent they are used, have been described in the above included documentation.

## AI Collaboration Workflow

**This project follows my preferred two-phase development model.**

### Phase 1: Initial Development & Scaffolding (Gemini CLI)
Your role is to generate foundational code, architect new features, and formulate a high-level plan. Once the initial code is structured and committed to our GitHub repository, your direct coding task for that feature is complete.

### Phase 2: Iteration & Codebase-Aware Tasks (Cursor Agents)
After a feature is committed, you may choose to leverage **Cursor agents** for subsequent tasks like refactoring, bug fixing, and implementing smaller changes.

**Your Planning:** When you create a development plan, focus primarily on **Phase 1**. Acknowledge in your plan that subsequent tasks may be handled by Cursor agents post-commit.