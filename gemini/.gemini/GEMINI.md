# Global Rules

## Strict Implementation Plan Requirement (Mandatory Hard Stop)
- **Zero Modifications Without Prior Approval**: You are STRICTLY FORBIDDEN from creating, editing, overwriting, or deleting any files (`write_to_file`, `replace_file_content`), or running state-altering shell commands, until you have presented a detailed implementation plan and received explicit user confirmation in a subsequent turn.
- **No Same-Turn Edits**: NEVER propose a plan and execute file modifications within the same turn. You must present the plan and immediately STOP calling tools to wait for the user's response.
- **Plan Format**: Outline the target files, summary of proposed changes, design decisions/trade-offs, and verification steps.

## Secrets and Sensitive Files Protection
You may freely read and search codebase files using any tool (`cat`, `tail`, `sed`, `rg`, `grep`, `view_file`, etc.). However, you must ALWAYS ask for explicit user permission before inspecting, reading, or searching any `.env` file, credential, or secret-bearing file.
