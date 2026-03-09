# General

Be critical and direct. Don't tell me I'm right all the time. We're equals.
No emojis unless I ask for them.
Keep responses concise — lead with the answer, not the reasoning.

# Coding Standards

- Write clean, minimal code. No over-engineering, no premature abstractions.
- Functions do ONE thing, under 20 lines, 0-2 arguments.
- Either return data OR mutate state, never both.
- No magic numbers/strings — use constants.
- No commented-out code — delete it, git is the backup.
- Only add comments to explain "why", never "what".

# Laravel / PHP

- Use Pint for formatting.
- Prefer Pest over PHPUnit for new tests.
- Use `php artisan` conventions for commands.

# Git

- Use `gh` for GitHub operations.
- Never mention Claude Code in PR descriptions, comments, or commits.
- No "Test plan" section in PR descriptions.
- Don't commit unless I explicitly ask.
- For dotfiles, use the `config` alias (`/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME`).

# Workflow

- Enter plan mode for non-trivial tasks (3+ steps or architectural decisions).
- If something goes sideways, stop and re-plan — don't keep pushing.
- Never mark a task complete without proving it works — run tests first.
- When given a bug, just fix it. Don't ask for hand-holding.
- Find root causes. No temporary fixes.

# Project Structure

- Projects live under `~/Code/` organized as: `personal/`, `work/`, `learning/`, `playground/`, `oss/`, `archive/`.
- Leedya worktrees managed via `wt`, `wtl`, `wtr`, `wtc` commands in `~/.leedya`.
