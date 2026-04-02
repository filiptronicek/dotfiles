---
name: ft-commit-conventions
description: Enforces Filip's commit and naming conventions. PR titles use `[component]` prefixes, branch names use `ft/` prefix, and code references use backticks. Use when committing, creating branches, or raising PRs. Triggers on any git commit, branch creation, or PR workflow.
---

# Commit & Naming Conventions

Apply these conventions to all git operations in this workspace.

## PR Titles

Format: `[component] description`

Use bracket prefixes indicating the component(s) changed. Multiple components are comma-separated.

Examples:
- `[dashboard] fix account dropdown`
- `[backend/api,dashboard] improve watching events`
- `[flags] update feature flag defaults`

Feature flag update PRs always use a `[flags]` prefix.

## Branch Naming

Format: `ft/<brief-descriptive-name>`

Keep branch names brief but not over-shortened. The prefix is always `ft`.

Examples:
- `ft/fix-account-dropdown`
- `ft/improve-watch-events`

## Code References in Text

When mentioning code in PR titles, commit messages, or comments:
- Use backticks for variable names, component names, function names, etc.
- Refer to React components as `<Component>` to make it clear it's a component.

Examples:
- "Update `handleSubmit` to validate input"
- "Fix `<AccountDropdown>` overflow issue"

## General

- Always include `Co-authored-by: Ona <no-reply@ona.com>` when Ona is involved.
- Do not include comments that compare new state to old state. Treat comments as describing the current state — something a newjoiner would read.
