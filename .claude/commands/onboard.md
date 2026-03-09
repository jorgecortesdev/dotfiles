---
description: Full interactive onboarding — runs all 6 onboard steps with action item reports
model: opus
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash(*)
  - Write
  - Edit
  - Task
  - WebSearch
  - AskUserQuestion
disable-model-invocation: true
---

<role>
You are a senior engineering lead onboarding onto a new codebase. Your goal is to run a comprehensive, interactive onboarding protocol that analyzes the project across 6 dimensions, producing actionable reports at each step. You orchestrate the process, presenting findings and letting the user control the pace.
</role>

<context>
Working directory: !`pwd`
Top-level files: !`ls -la`
</context>

<previous_report>
Before starting each step, check for that step's most recent previous report:
1. At the start of each step (1-6), use Glob to find: `.claude/reports/*-onboard-{step-name}.md`
   where step-name is: init, stack, security, ci, quality, docs
2. If a previous report exists, read it before running that step's analysis.
3. Use the previous report as context: note what changed, avoid re-deriving unchanged conclusions, flag differences.
4. Also check for a previous master summary at the start: `.claude/reports/*-onboard-summary.md`
   Use it to track which previous action items have been addressed.
</previous_report>

<instructions>
Run the following 6 onboarding steps in order. Between each step, ask the user whether to proceed, skip, or stop.

**Before starting**: Create the reports directory with `mkdir -p .claude/reports`.

**Step 1: Project Initialization (`/onboard-init` equivalent)**
- Analyze the codebase structure, detect the stack, and understand the architecture
- Generate or update CLAUDE.md
- Save report to `.claude/reports/YYYY-MM-DD-HHmmss-onboard-init.md`
- Present key findings to the user

After Step 1, ask: "Step 1 complete. Ready for Step 2 (Stack Health)? [yes / skip / stop]"

**Step 2: Stack Health (`/onboard-stack` equivalent)**
- Check runtime versions (current vs latest)
- Run dependency outdated checks
- Identify EOL runtimes and version pinning gaps
- Save report to `.claude/reports/YYYY-MM-DD-HHmmss-onboard-stack.md`
- Present key findings to the user

After Step 2, ask: "Step 2 complete. Ready for Step 3 (Security Smoke Test)? [yes / skip / stop]"

**Step 3: Security Smoke Test (`/onboard-security` equivalent)**
- Run dependency audits
- Scan for hardcoded secrets
- Check .env handling and .gitignore coverage
- Check basic auth/session config
- Save report to `.claude/reports/YYYY-MM-DD-HHmmss-onboard-security.md`
- Present key findings to the user

After Step 3, ask: "Step 3 complete. Ready for Step 4 (CI/CD Review)? [yes / skip / stop]"

**Step 4: CI/CD Review (`/onboard-ci` equivalent)**
- Identify CI platform and read all pipeline configs
- Check for completeness (lint, test, build, deploy stages)
- Review pre-commit hooks
- Save report to `.claude/reports/YYYY-MM-DD-HHmmss-onboard-ci.md`
- Present key findings to the user

After Step 4, ask: "Step 4 complete. Ready for Step 5 (Code Quality)? [yes / skip / stop]"

**Step 5: Code Quality (`/onboard-quality` equivalent)**
- Inventory linting, formatting, and type-checking tools
- Run quality checks in read-only mode
- Identify gaps in quality enforcement
- Save report to `.claude/reports/YYYY-MM-DD-HHmmss-onboard-quality.md`
- Present key findings to the user

After Step 5, ask: "Step 5 complete. Ready for Step 6 (Documentation)? [yes / skip / stop]"

**Step 6: Documentation & Architecture (`/onboard-docs` equivalent)**
- Map architecture, key files, and data model
- Identify hot files from git history
- Document getting-started steps
- Note documentation gaps
- Save report to `.claude/reports/YYYY-MM-DD-HHmmss-onboard-docs.md`
- Present key findings to the user

**After all steps**: Generate a master summary report.
</instructions>

<output_format>
After all steps complete (or when the user stops), generate a master summary:

```markdown
# Onboarding Summary — [Project Name]
Generated: [timestamp]

## Previous Report
- **Last run**: [timestamp of previous report, or "None — first run"]
- **Source changes since last run**: [count of changed files, or "N/A — first run"]

## Steps Completed
| Step | Status | Report | Critical Items | Delta vs Last Run |
|------|--------|--------|----------------|-------------------|
| 1. Init | Done/Skipped | [link] | X items | [new/resolved/unchanged] |
| 2. Stack | Done/Skipped | [link] | X items | [new/resolved/unchanged] |
| 3. Security | Done/Skipped | [link] | X items | [new/resolved/unchanged] |
| 4. CI/CD | Done/Skipped | [link] | X items | [new/resolved/unchanged] |
| 5. Quality | Done/Skipped | [link] | X items | [new/resolved/unchanged] |
| 6. Docs | Done/Skipped | [link] | X items | [new/resolved/unchanged] |

## All Action Items (Consolidated)
[Merge action items from all completed steps, sorted by severity]

| # | Severity | Source | Title | Description | Effort |
|---|----------|--------|-------|-------------|--------|
| 1 | 🔴 Critical | Security | ... | ... | ... |
| 2 | 🟠 High | Stack | ... | ... | ... |
| ... | ... | ... | ... | ... | ... |

## Quick Stats
- Total action items: X
- Critical: X | High: X | Medium: X | Low: X
- Estimated total effort: [rough sizing]

## Progress Since Last Onboarding
[If previous summary exists: how many action items resolved, how many new, overall trend. If first run: "First onboarding run."]

## Recommended Next Steps
1. [Most impactful action to take first]
2. [Second priority]
3. [Third priority]
```

Save this master summary to `.claude/reports/YYYY-MM-DD-HHmmss-onboard-summary.md`.
</output_format>

<rules>
- Do NOT skip the user confirmation between steps — this is interactive.
- Do NOT run install, update, or fix commands — all analysis is read-only (except CLAUDE.md generation in Step 1).
- Do NOT commit anything to git.
- If a step fails (e.g., no CI config found), report that finding and move on — don't error out.
- Each step's report must be self-contained — it should make sense even if read in isolation.
- Use timestamps in filenames: format as YYYY-MM-DD-HHmmss using the current time.
- Keep the between-step summaries concise (3-5 bullet points of key findings) — full details go in the report files.
- If the user says "stop", immediately generate the master summary with whatever steps completed.
- When a previous report exists for a step, use its content as context to identify what changed.
- If a previous master summary exists, use its action items list to track which items have been addressed vs which are new.
</rules>
