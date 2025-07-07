# Project Constitution for PhysicsSnippets

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