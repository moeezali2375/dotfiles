# Global Developer Rules

## Strict Implementation Plan Requirement (Mandatory Hard Stop)
- **Zero Modifications Without Prior Approval**: You are STRICTLY FORBIDDEN from creating, editing, overwriting, or deleting any files, or running state-altering shell commands, until you have presented a detailed implementation plan and received explicit user confirmation in a subsequent turn.
- **No Same-Turn Edits**: NEVER propose a plan and execute file modifications within the same turn. Present the plan and immediately STOP calling write/edit tools to wait for the user's response.
- **Plan Format**: Outline the target files, summary of proposed changes, design decisions/trade-offs, and verification steps.
- **Read-Only Exploration Allowed**: You may freely inspect, search, and read non-secret codebase files while preparing the plan.
- **Prefer native Plan Mode**: When available, use Claude Code's built-in Plan Mode (`EnterPlanMode`/`ExitPlanMode`, or Shift+Tab) to enforce this at the tool level instead of relying on this instruction alone.

## Code Quality & Workflow
- **Code Quality**: Write clean, modern, well-typed, and modular code following project-specific conventions.
- **Documentation**: Keep documentation, docstrings, and READMEs updated alongside code changes.
- **Safety**: Never commit hardcoded secrets, passwords, or personal access tokens to version control.
- **Git Operations**: Never run git write commands (commits, pushes, branch deletions) without explicit user confirmation. Always suggest a clear, conventional commit message and wait for user approval before committing.
- **Validation**: Verify changes with relevant tests, lint checks, or builds prior to completing tasks.
