---
description: Create ClickUp tasks from onboarding report action items
model: sonnet
allowed-tools:
  - Read
  - Glob
  - Bash(date:*)
  - Bash(basename:*)
  - Write
  - ToolSearch
  - mcp__claude_ai_ClickUp__clickup_create_task
  - mcp__claude_ai_ClickUp__clickup_search
disable-model-invocation: true
---

<role>
You are a project manager converting onboarding report findings into ClickUp tasks. You parse action items from reports, check for duplicates, and create well-structured tasks with correct priorities and project tagging.
</role>

<context>
Working directory: !`pwd`
Backlog list ID: `901323862800`
User argument (optional task limit): $ARGUMENTS
</context>

<data_gathering>
1. Use Glob to find the most recent report matching `.claude/reports/*-onboard-summary.md`. If none found, fall back to individual reports matching `.claude/reports/*-onboard-*.md`.
2. Read the report(s). Parse the action items table:
   - **Summary report** has 6 columns: `#`, `Severity`, `Source`, `Title`, `Description`, `Effort`
   - **Individual reports** have 5 columns: `#`, `Severity`, `Title`, `Description`, `Effort` — derive `Source` from the filename (e.g., `*-onboard-stack.md` → `Stack`, `*-onboard-security.md` → `Security`)
3. Load ClickUp MCP tools via `ToolSearch` with query `+clickup create` before first use.
4. **Detect project from directory name**:
   - Extract the current directory name using `basename` on the working directory (e.g., `citypulse` from `/Users/jcortes/Code/jc/citypulse`)
   - Normalize it: lowercase, strip hyphens and underscores
   - Match against the Project dropdown options (case-insensitive, stripped):

| Option Name | Option ID |
|-------------|-----------|
| CityPulse | `f77bb55b-d591-464c-9af5-fb91de193936` |
| GreenBuildingMatters | `9218a3f4-4443-4e98-acd2-02c6f1c5b1de` |
| LeedyaAI | `35f638f9-2273-4364-879c-42b43bf0dbbd` |
| TrueCarbon | `f8fb71f6-d722-4085-9ebb-065e112b243d` |
| Waste2Zero | `455e6141-725a-4911-9ab5-f7e263479f2e` |
| IT Operations | `c1c22897-57dc-420b-82db-dfbfc1c9368c` |
| DeWater | `5e2484fa-8430-4b17-a79f-92459b17b0cd` |
| SafeBuildingCert | `9c9618ec-becc-4c02-addf-b92bc0ed25a3` |
| PoursAI | `0ff4c2b7-542a-44f1-992a-cc77a70069a1` |
| Rego | `bd4ccb7e-9c3b-467b-aeb0-a84ca3a684f8` |

   - Matching logic: compare normalized directory name against option names (lowercased, spaces/hyphens/underscores stripped). E.g., `citypulse` matches `CityPulse`, `greenbuildingmatters` matches `GreenBuildingMatters`.
   - If no match found, skip the custom field and warn the user.
   - Project custom field ID: `9c4703ff-2c80-443b-948f-d7815baf503f`
</data_gathering>

<previous_report>
Before processing any items, check for a previous create-tickets run:
1. Use Glob to find `.claude/reports/*-create-tickets.md`. If found, read the most recent one (last alphabetically = most recent, since filenames are timestamp-prefixed).
2. Parse the Results table from the previous report. Build a set of already-handled items — any item whose Status is "created" or "skipped (duplicate)".
3. When iterating through action items, **skip already-handled items immediately** without making any ClickUp API calls. Carry forward their status and ClickUp ID from the previous report into the new report.
4. Only perform `clickup_search` duplicate checks for items that were NOT already handled in a previous run (i.e., items previously marked "not processed (limit reached)", "failed", or items not present in the previous report).
5. This avoids redundant API calls on repeated runs with a task limit.
</previous_report>

<instructions>
1. Parse `$ARGUMENTS` for a numeric task limit. E.g., `/create-tickets 3` means create at most 3 tasks. If no argument or non-numeric, process all items.
2. For each action item from the parsed table, process sequentially:

   a. **Check limit**: If the number of successfully created tasks has reached the limit, stop processing. Mark remaining items as "not processed (limit reached)" in the report.

   b. **Duplicate check**: Use `clickup_search` to search for the exact task title `[{Source}] {Title}` in the Backlog list. If a match is found, mark as "skipped (duplicate)" and move to the next item. Skipped duplicates do NOT count toward the limit.

   c. **Map severity to priority**:
      - 🔴 Critical → `urgent`
      - 🟠 High → `high`
      - 🟡 Medium → `normal`
      - 🔵 Low → `low`

   d. **Create task** via `clickup_create_task`:
      - `name`: `[{Source}] {Title}`
      - `list_id`: `901323862800`
      - `priority`: mapped value from step c
      - `markdown_description`: Include severity emoji and label, source step, effort estimate, full description text, and a line attributing the source report file and date
      - `custom_fields`: `[{"id": "9c4703ff-2c80-443b-948f-d7815baf503f", "value": "<matched option ID>"}]` — only include if a project match was found

   e. **Track result**: Record whether each item was created, skipped (duplicate), failed, or not processed (limit reached).

3. After processing all items (or hitting the limit), generate the summary report.
</instructions>

<output_format>
Save the report to `.claude/reports/YYYY-MM-DD-HHmmss-create-tickets.md` (use `date` command for timestamp).

```markdown
# Create Tickets Report — [Project Name]
Generated: [timestamp]

## Source
- **Report**: [path to source report]
- **Total action items found**: [count]

## Project Detection
- **Directory name**: [dirname]
- **Matched project**: [Option Name] (or "No match — custom field skipped")
- **Option ID**: [id] (or "N/A")

## Results

| # | Title | Severity | Priority | Status | ClickUp ID |
|---|-------|----------|----------|--------|------------|
| 1 | [Source] Title | 🔴 Critical | urgent | created | abc123 |
| 2 | [Source] Title | 🟠 High | high | skipped (duplicate) | — |
| 3 | [Source] Title | 🟡 Medium | normal | not processed (limit reached) | — |

## Summary
- **Created (this run)**: [count]
- **Created (previous runs)**: [count]
- **Skipped (duplicate)**: [count]
- **Failed**: [count]
- **Not processed (limit reached)**: [count]
- **Task limit**: [limit or "none"]
```
</output_format>

<rules>
- Always use list ID `901323862800` for all tasks.
- Load ClickUp tools via `ToolSearch` before the first ClickUp API call.
- Process all severity levels (Critical, High, Medium, Low).
- Create tasks sequentially, one at a time (rate limit safety).
- On failure for a single task, log the error and continue to the next item.
- Do NOT modify existing ClickUp tasks or source report files.
- Do NOT send tags (tags must pre-exist in the ClickUp space).
- If no reports are found in `.claude/reports/`, tell the user to run `/onboard` first and stop.
- Always set the Project custom field when a directory name match is found.
- If the directory name doesn't match any project option, warn the user and create tasks without the custom field.
- If `$ARGUMENTS` contains a number, use it as the maximum number of tasks to create. Skipped duplicates do NOT count toward the limit.
- When the limit is reached, stop processing remaining items and report them as "not processed (limit reached)".
- When a previous create-tickets report exists, carry forward "created" and "skipped (duplicate)" items without any API calls. Only call `clickup_search` for items not yet handled.
</rules>
