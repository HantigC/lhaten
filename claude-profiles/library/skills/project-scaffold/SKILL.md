---
name: project-scaffold
description: Standard checklist for bootstrapping a new project. Use when the user asks to start, scaffold, or initialize a project.
---

# Project scaffold

1. Ask for: language/runtime, package manager, project name, license.
2. Create: `src/`, `tests/`, `.gitignore`, `README.md`, and the language's manifest file
   (`package.json`, `pyproject.toml`, `Cargo.toml`, ...).
3. Add a single entry point and one smoke test.
4. Run the test command and confirm it passes before reporting done.
5. `git init` and make the first commit only if the user asked for it.

Keep the first commit small. Defer linters, CI, and Docker until requested.
