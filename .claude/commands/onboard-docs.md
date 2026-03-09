---
description: Quick architecture overview, key files map, and getting-started guide
model: sonnet
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash(ls:*)
  - Bash(wc:*)
  - Bash(git log:*)
  - Bash(tree:*)
  - Bash(git diff:*)
  - Write
disable-model-invocation: true
---

<role>
You are a technical writer and software architect creating a quick-start documentation package for a new team member joining this project. Your goal is to produce a concise architecture overview, a map of the most important files, and a getting-started guide — enough for someone to understand and contribute to the project within their first day.
</role>

<context>
Working directory: !`pwd`
Top-level files: !`ls -la`
</context>

<data_gathering>
Before analysis, gather project data using your tools:
1. Use Glob with `src/**/*` (or equivalent) to map project structure
2. Read `README.md` if it exists
3. Read the main manifest file (`package.json`, `composer.json`, etc.)
4. Use Bash: `git log --oneline -30` to see recent history
5. Use Bash: `git log --pretty=format: --name-only -30` and review the output to identify hot files
6. Read entry point files, routing config, and key architectural files
</data_gathering>

<previous_report>
Before beginning analysis, check for a previous run of this command:
1. Use Glob to find: `.claude/reports/*-onboard-docs.md`
2. If found, read the most recent one (last alphabetically = most recent, since filenames are timestamp-prefixed).
3. Note the timestamp from the filename.
4. Use the previous report as context during analysis. You still perform a full analysis, but:
   - Skip re-explaining things that have not changed
   - Focus reasoning on what IS different
   - Explicitly call out changes, additions, and removals vs the previous run
5. If no previous report is found, proceed as a fresh run.
</previous_report>

<instructions>
1. **Architecture overview**: Read the main entry points, routing config, and key architectural files. Produce a high-level description of how the application is structured — layers, modules, and data flow.

2. **Directory structure guide**: For each top-level directory in `src/` (or equivalent), write a one-line description of its purpose. Read representative files if the purpose isn't obvious from the name.

3. **Key files map**: Identify the 10-15 most important files a new developer should read first. For each, provide:
   - File path
   - Purpose (one line)
   - Why it matters (one line)

4. **Data model overview**: If there are database models, schemas, or type definitions that represent the core domain, list the key entities and their relationships.

5. **Getting started guide**: Write step-by-step instructions to:
   - Clone and install dependencies
   - Set up environment variables (reference .env.example if it exists)
   - Run the development server
   - Run tests
   - Make a typical change (describe the workflow)

6. **Hot files**: Using git history, identify the files that change most frequently — these are often the most important (or most problematic) files in the codebase.

7. **Documentation gaps**: Note what documentation exists (README, CLAUDE.md, JSDoc, docstrings, API docs) and what's missing.

8. Generate the report and save to `.claude/reports/YYYY-MM-DD-HHmmss-onboard-docs.md`.
</instructions>

<output_format>
```markdown
# Documentation & Architecture Report — [Project Name]
Generated: [timestamp]

## Previous Report
- **Last run**: [timestamp of previous report, or "None — first run"]
- **Source changes since last run**: [count of changed files, or "N/A — first run"]

## Architecture Overview
[2-4 paragraphs describing how the application is structured]

## Directory Guide
| Directory | Purpose |
|-----------|---------|
| src/components/ | React UI components |
| src/hooks/ | Custom React hooks |
| ... | ... |

## Key Files Map
| File | Purpose | Why It Matters |
|------|---------|----------------|
| src/App.tsx | Application root | Entry point, routing setup |
| ... | ... | ... |

## Data Model
[Entity list with key relationships, or "No structured data model found"]

## Getting Started
1. Clone: `git clone [repo-url]`
2. Install: `npm install`
3. Environment: `cp .env.example .env` and fill in...
4. Run: `npm run dev`
5. Test: `npm test`

## Hot Files (most frequently changed)
| File | Changes (last 30 commits) | Notes |
|------|---------------------------|-------|
| ... | ... | ... |

## Existing Documentation
| Document | Status | Notes |
|----------|--------|-------|
| README.md | Present/Missing | ... |
| CLAUDE.md | Present/Missing | ... |
| API docs | Present/Missing | ... |
| JSDoc/Docstrings | Sparse/Good/None | ... |

## Changes Since Last Run
[If previous report exists: list New findings, Resolved findings, Changed findings, and count of Unchanged items. If first run: "First run — no comparison available."]

## Action Items

| # | Severity | Title | Description | Effort |
|---|----------|-------|-------------|--------|
| ... | ... | ... | ... | ... |

### Action Item Details
[Detailed breakdown of each item]
```
</output_format>

<rules>
- Do NOT create or modify any documentation files — report only (CLAUDE.md creation is handled by /onboard-init).
- Do NOT run dev server, build, or any long-running commands.
- Keep descriptions concise — one line per directory, one line per key file.
- Focus on what a new developer NEEDS to know, not everything that EXISTS.
- If the project has no README, make that a 🟠 High action item.
- If the getting-started steps can't be determined, note what's missing and make it an action item.
- When a previous report exists, you MUST still analyze all current data — the previous report is context, not a substitute for analysis.
- Do NOT copy the previous report wholesale. Write fresh analysis informed by previous findings.
- If previous findings are still accurate, say so briefly rather than re-explaining in full.
</rules>
