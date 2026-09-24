---
name: plan-tasks
description: Plan tasks is a workflow for deconstructing a larger objective into a series of dependencies we call tasks pushed to a pull request in markdown format. Use when user asks to plan work or works.
---

# Plan-Tasks Workflow

## Overview
Your role is to create workstreams other agents can pick up by decomposing the broader objective and work proposals into a series of tasks. The output of your effort is a pull request (PR) with markdown files representing the work stream.

## Output Structure
In the repo you're working in, add markdown output under the dir `plans/$plan_name/` where $plan_name is a concise name you pick to summarize the effort. The markdown files added here will be part of the PR you open. 

Include a file called "0-tasks-summary.md" with the following information in table form to summarize the workstream tasks.
* Task ID - Unique integer that provides shorthand for referencing the task. Task ID is a link to the detail view of the task.
* Status - Helps maintainers and other agents understand task state. Can be not done, in-progress, or done. Other agents will update the value as they work.
* Title - Brief task description that communicates the gist of the work.
* Dependencies - List of Task IDs that must be completed before the task can be worked on. Other agents will use the column to find the next available task.

For each task you define, create a task detail file called "$task_id-$task_title.md" where $task_id matches task ID from the summary and $take_title matches the summary title. The task detail file structure is:
* Big Picture - Concise explanation of the broader objective that gives the agent enough context to understand the problem space and see how the task moves us closer to the workstream objective.
* Requirements - Open-form section where you itemize constraints + requirements and define the definition of done. 

## Task Identification
You must decompose the user's broader objective into a series of incremental steps. Each step (task) should be the size of 1 PR. So that we can iterate quickly, prefer task scopes that produce PRs which have limited + independent scope, minimize inter-dependencies, and are easy to review. Tasks include writing tests. Your role is to identify how to split the work and identify dependencies, and you are not implementing tasks.

## Phases
Here are the steps to conduct in a planning session:
1. Analyze workstream repos.
2. Decompose tasks.
3. Ask up to 3 rounds of clarifying questions.
4. Update tasks.
5. Iterate via PR feedback (if needed).

### 1. Analyze Workstream Repos
Ensure workstream repos are on the main branch without local changes pointing to latest commit from remote. Read project silently (no output unless directly relevant) before decomposing tasks and asking clarifying questions. Check:

1. Directory structure (top 2 levels)
2. `package.json`, `build.gradle`, `build.gradle.kts`, `go.mod`, `requirements.txt`, `Cargo.toml`, `pom.xml`, or equivalent
3. Existing dependencies + versions
4. Build system, scripts (`Makefile`, `scripts/`, CI config)
5. `README.md` or `README.*`

### 2. Decompose Tasks
Perform initial task decomposition. Push (or open) PR for user to review.

### 3. Ask Clarifying Questions
Perform up to 3 rounds of clarifying questions. Number your questions and ask up to 5 questions in 1 round. Ask questions when:
1. You cannot infer details from the repo(s).
2. You see gaps between the tasks and the broader outcome.
3. You do not see a clear decomposition of tasks and want user feedback on tradeoffs.

After each round of questions, update the PR description with a click-to-expand section called Q&A that shows each round of clarifying questions + answers.

### 4. Update Tasks
Use the clarifying question responses to update tasks and update the PR.

### 5. Iterate via PR feedback
Await message from user asking you to review PR feedback for further iteration. Until you hear back from the user, you can consider your work done.
