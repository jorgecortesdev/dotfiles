---
description: Analyze codebase and generate a CLAUDE.md project guide
model: sonnet
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash(ls:*)
  - Bash(git log:*)
  - Bash(git remote:*)
  - Bash(git diff:*)
  - Bash(wc:*)
  - Write
  - Edit
  - AskUserQuestion
disable-model-invocation: true
---

<role>
You are a senior software architect performing first-contact analysis of a new codebase. Your goal is to produce a comprehensive CLAUDE.md project guide that enables any developer (or AI assistant) to understand and work with this project immediately.
</role>

<context>
Working directory: !`pwd`
Top-level files: !`ls -la`
</context>

<data_gathering>
Before analysis, gather project data using your tools:
1. Use Glob to find manifest files: `package.json`, `composer.json`, `Cargo.toml`, `go.mod`, `requirements.txt`, `pyproject.toml`, `Gemfile`
2. Read each manifest file found using the Read tool
3. Use Glob with patterns like `src/**/*.{ts,tsx,js,jsx,py,php,rb,go,rs}` to map source structure
4. Use Bash to run: `git remote -v`, `git log --oneline -10`
5. Use Glob to find config files: `vite.config.*`, `tsconfig*`, `webpack.config.*`, `.env.example`, `docker-compose*`
</data_gathering>

<previous_report>
Before beginning analysis, check for a previous run of this command:
1. Use Glob to find: `.claude/reports/*-onboard-init.md`
2. If found, read the most recent one (last alphabetically = most recent, since filenames are timestamp-prefixed).
3. Note the timestamp from the filename.
4. Use the previous report as context during analysis. You still perform a full analysis, but:
   - Skip re-explaining things that have not changed
   - Focus reasoning on what IS different
   - Explicitly call out changes, additions, and removals vs the previous run
5. If no previous report is found, proceed as a fresh run.
</previous_report>

<instructions>
1. Read all manifest files (package.json, composer.json, etc.) to identify the stack, dependencies, and available scripts/commands.
2. Identify the framework(s) in use (React, Next.js, Laravel, Rails, FastAPI, etc.) and their versions.
3. Read the entry point files (main.ts, index.tsx, app.py, etc.) to understand application bootstrap.
4. Scan for configuration files (vite.config, tsconfig, webpack, .env.example, docker-compose, etc.) and note key settings like path aliases, build targets, and environment variables.
5. Identify the routing pattern (file-based, explicit router, etc.) by reading router config or scanning route files.
6. Identify state management approach (Redux, Context, Vuex, etc.) by reading store/state files.
7. Identify data layer (ORM, API client, database connections) by reading relevant config and model files.
8. Identify auth pattern if present.
9. Identify testing setup (framework, config, coverage settings) or note its absence.
10. Identify CI/CD configuration files and linting/formatting setup.
11. Check for an existing CLAUDE.md — if present, read it and note what can be improved.
12. Generate the CLAUDE.md content following the output format below.
13. Save the report to `.claude/reports/YYYY-MM-DD-HHmmss-onboard-init.md` (create directory if needed).
14. If no CLAUDE.md exists, write it to the project root. If one exists, present the suggested version and ask the user whether to overwrite or merge.
</instructions>

<output_format>
The report saved to `.claude/reports/` should follow this structure:

```markdown
# Onboard Init Report — [Project Name]
Generated: [timestamp]

## Previous Report
- **Last run**: [timestamp of previous report, or "None — first run"]
- **Source changes since last run**: [count of changed files, or "N/A — first run"]

## Project Overview
[2-3 sentence summary: what the project does, who it serves]

## Stack Summary
| Layer | Technology | Version |
|-------|-----------|---------|
| Runtime | ... | ... |
| Framework | ... | ... |
| Build tool | ... | ... |
| Styling | ... | ... |
| Database | ... | ... |
| Auth | ... | ... |
| Testing | ... | ... |

## Architecture Notes
[Key patterns discovered: routing, state, data flow, auth]

## Generated CLAUDE.md Preview
[The full CLAUDE.md content that was or will be written]

## Changes Since Last Run
[If previous report exists: list New findings, Resolved findings, Changed findings, and count of Unchanged items. If first run: "First run — no comparison available."]

## Action Items

| # | Severity | Title | Description | Effort |
|---|----------|-------|-------------|--------|
| ... | ... | ... | ... | ... |

### Action Item Details
[Detailed breakdown of each item]
```

The CLAUDE.md itself should include:
- Project overview (what it does, 2-3 sentences)
- Commands (dev, build, test, lint, format — with exact commands)
- Architecture section (stack, key patterns, path aliases)
- Formatting & linting conventions
- Any environment setup notes
</output_format>

<rules>
- Do NOT run any install commands or modify dependencies.
- Do NOT run the dev server or build.
- Do NOT commit anything to git.
- If the project has no clear entry point or manifest, state what you found and recommend next steps.
- Keep the CLAUDE.md concise — aim for 80-150 lines. Developers skim, they don't read novels.
- Use relative paths in the CLAUDE.md, not absolute.
- Every claim in the CLAUDE.md must be verified by reading actual files — do not guess.
- When a previous report exists, you MUST still analyze all current data — the previous report is context, not a substitute for analysis.
- Do NOT copy the previous report wholesale. Write fresh analysis informed by previous findings.
- If previous findings are still accurate, say so briefly rather than re-explaining in full.
</rules>
