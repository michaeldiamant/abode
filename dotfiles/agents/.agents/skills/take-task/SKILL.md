---
name: take-task
description: Take task is a workflow for implementing a task created by plan-task skill and updating task status in the plan pull request. Use when user asks to take a task or take the next task from a plan.
---

# Take-Task Workflow

## Overview
Your role is to identify the next task to work on, delegate implementation to a sub-agent, and ensure the task requirements are fulfilled. Please do not write the code yourself. 

## Plan Structure
Tasks are contained in a plan. The plan is a series of markdown docs in a pull request. You use these files to understand candidate tasks and the requirements for each task.

The plan contains a file called tasks-summary.md (might have a few prefix characters), which outlines all the tasks, task status, and dependencies. Each row in the task summary table links to a task detail page that explains the task's requirements.

## Phases
Here are the steps for taking a task:
1. Find next available tasks.
2. Confirm task selection with the user.
3. Mark task in-progress in plan task summary.
3. Work on the task.
4. Iterate via PR feedback (if needed).
5. Mark task done in plan task summary.

### 1. Find Next Available Tasks
If the user has not provided the pull request (PR) containing the plan docs, then prompt the user for a PR link.

Review plan task summary to find the next available task(s). Identify candidate tasks by reviewing dependencies and dependent task status. Tasks with no dependencies are ready for pick up. If a task has dependencies and the dependent tasks have status = done, then the task is available for pick up.

### 2. Confirm Task Selection
You might identify 0, 1 or multiple candidate tasks. In all cases, prompt the user to confirm how to proceed. The user can only specify 1 task to be picked up.

### 3. Mark Task In-Progress
In the plan PR, update the plan task summary to show that you've started work on a task. Change the selected task status from not done to in-progress. If the selected task status != not done, then ask the user for help. It might mean another agent picked up the task, so we may need to repeat step (1) to find available tasks.

Push changes to the plan PR.

### 4. Work on the Task
Open empty PR to provide visibility into the work that's happening. 

Review the requirements and see if you spot gaps. If you spot gaps, then ask the user clarifying questions. Update the PR description with a click-to-expand section called Q&A that shows all clarifying questions + answers.

Spin up implementer sub-agent. Pick the model with the lowest cost that you feel can solve the problem. Choose between Haiku and Sonnet. Use low effort only.

The PR description includes a click-to-expand section called AI models and rationale. It includes the model(s) used (you and all sub-agents), and rationale for picking the model. Do not add other explanations or content. The user will curate the PR description.

PR description includes "Task Details: Task $ID" where $ID is the task ID taken from the plan task summary. Link Task $ID to the task detail view from the plan PR.

Skip other PR description content and let the user otherwise curate the PR description.

Keep iterating with the implementer until you believe the requirements are fulfilled. Then, push changes to the PR and let the user know.

### 4. Iterate via PR feedback
Await message from user asking you to review PR feedback for further iteration. 

### 5. Mark Task Done
Await the user to tell you (either directly in chat or through PR feedback) that the task is done. Update the task summary in the plan PR to change the task status from in-progress to done. Push changes to the plan PR.
