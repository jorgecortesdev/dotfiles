---
name: panel-review
description: Generate a Ralph Loop prompt file that runs an iterative expert panel review. Use when the user asks to "write a ralph loop prompt", "create a panel review", or "write an iterative review prompt".
---

When the user asks you to create a Ralph Loop prompt, generate a markdown file following this proven structure. Infer all details from the user's description — do NOT ask clarifying questions. Make your best judgment on experts, files, goals, and rules.

## Structure

### 1. Context
- Brief description of what's being reviewed and why
- **Key files to read before every round** — list every relevant file in the project. Be thorough. The loop agent needs to re-read these each iteration.
- **Current state** — summarize what exists, what works, what's broken

### 2. Goal
- What the panel must reach consensus on (numbered list, 4-8 items)
- Concrete success criteria, not vague outcomes

### 3. The Panel
- 5-10 expert agents, each with a distinct domain lens on the problem
- Each agent gets: name, abbreviation, focus area, and 3-5 specific questions they must answer
- Pick experts that create productive tension (e.g., a pragmatic engineer vs a theorist)
- Always include at least one agent grounded in the project's domain and one focused on implementation feasibility

### 4. Process (use this exact structure)

```
### Step 1: Read Current State
- Read all key files listed in Context above
- Read `{REVIEW_FILE}` (previous review rounds — may not exist on first iteration)

### Step 2: Determine Iteration
- Check `{REVIEW_FILE}` for the current iteration number
- If no review file exists, this is **Iteration 1**

### Step 3: Each Agent Reviews
For the current iteration, each agent must:
1. **State their top concerns** (max 3 per agent)
2. **Respond to other agents' previous points** (agree, disagree, build on)
3. **Propose concrete designs** (specific data structures, algorithms, values — not vague suggestions)
4. **Rate the design** on a scale of 1-{MAX_RATING}

### Step 4: Facilitate Discussion
After individual reviews, simulate cross-agent discussion:
- Where do agents disagree? Why?
- What compromises can be reached?
- What experiments would resolve uncertainty?

### Step 5: Apply Changes
- If consensus on improvements, update the design document directly
- Document what was changed and why in the review notes

### Step 6: Score Consensus
Each agent gives a final rating. Calculate the average.

### Step 7: Write Review Round
Append the full review round to `{REVIEW_FILE}` with:
- Individual reviews (rating, concerns, responses, proposals) for each agent
- Cross-agent discussion summary
- Changes applied
- Consensus score and status (REVIEWING | CONSENSUS)

### Step 8: Completion Check
- If **all agents rate {THRESHOLD} or higher** AND iteration >= {MIN_ITERATIONS}: output `<promise>{PROMISE}</promise>`
- If **all agents rate {MAX_RATING}** on any iteration >= {EARLY_EXIT}: output `<promise>{PROMISE}</promise>` (early consensus)
- Otherwise, continue to next iteration
```

### 5. Rules
Always include these core rules, plus 2-5 topic-specific ones:
1. **Be genuinely critical.** Don't rubber-stamp. Find real problems.
2. **Be specific.** Vague feedback is useless. Include exact values, formulas, code, designs.
3. **Evolve across iterations.** Don't repeat the same feedback. Build on previous rounds.
4. **Disagree productively.** Agents SHOULD disagree. Resolution through evidence is the goal.
5. **Ground in data.** Reference actual files, metrics, and examples from the project.

## File placement
- If the user specifies a location, use it
- Otherwise, place all generated files in the **project root**:
  - `prompt-{topic}.md` — the Ralph Loop prompt
  - `{topic}-review.md` — where the loop writes review rounds
  - `{topic}-conclusions.md` — the evolving design decisions and rationale

## Defaults
- **Max iterations**: 20 (unless user specifies otherwise)
- **Rating scale**: 1-10
- **Consensus threshold**: all agents rate 9+
- **Early exit**: all agents rate 10 at iteration >= ceil(max_iterations * 0.5)
- **Min iterations for completion**: ceil(max_iterations * 0.75)
- **Promise tag**: `PLAN APPROVED` (or derive from the goal)

## Key principles
- The prompt must be **self-contained** — the loop agent has no memory between iterations, only the files on disk
- List ALL files the agent needs to read. Missing a file means the agent works blind.
- Expert questions should be specific enough to prevent generic answers
- The review file format must be consistent so iteration detection works
- Rules should prevent common failure modes: rubber-stamping, vague feedback, repeating the same points, overwriting existing work
