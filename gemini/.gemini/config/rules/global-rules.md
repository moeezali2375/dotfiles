---
trigger: always_on
description: Core developer principles: implementation planning, code quality, safety, git workflow, and validation.
---

# Global Developer Rules

- **Implementation Plan First (Strict Hard Stop)**: You are STRICTLY FORBIDDEN from creating, editing, or modifying any files, or executing destructive/write shell commands, without first presenting a detailed implementation plan and receiving explicit user approval in a subsequent turn. Never combine the plan and modifications in the same turn; always present the plan and stop to wait for user alignment.
- **Code Quality**: Write clean, modern, well-typed, and modular code following project-specific conventions.
- **Documentation**: Keep documentation, docstrings, and READMEs updated alongside code changes.
- **Safety**: Never commit hardcoded secrets, passwords, or personal access tokens to version control.
- **Git Operations**: Never run git write commands (such as commits, pushes, or branch deletions) without explicit user confirmation. Always suggest a clear, conventional commit message and wait for user approval before committing.
- **Validation**: Verify changes with relevant tests, lint checks, or builds prior to completing tasks.
