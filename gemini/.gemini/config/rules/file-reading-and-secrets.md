---
trigger: always_on
description: Guidelines for reading files freely with shell tools while requiring explicit user permission before accessing environment files or secrets.
---

# File Reading and Secret Protection Guidelines

## File Reading Freedom
- You are encouraged and authorized to inspect, read, and search codebase files using any appropriate command or tool (`cat`, `tail`, `head`, `sed`, `rg`, `grep`, `view_file`, `fd`, etc.).
- Prefer line-targeted reading (`sed -n`, `head`, `tail`) or line-numbered output (`cat -n`) when examining code chunks to keep context efficient.

## Secrets and Sensitive Files Protection
- **Explicit Permission Required**: NEVER read, output, or search within any file containing secrets, credentials, or environment configurations without first asking the user for explicit confirmation.
- **Restricted Patterns & Files**:
  - Environment variable files: `.env`, `.env.*`, `*.env`, `.envrc`
  - Key files & certificates: `*.pem`, `*.key`, `*.p12`, `id_rsa*`, `id_ed25519*`
  - Credential & auth files: `credentials.json`, `service-account*.json`, `client_secret*.json`, `.netrc`, `.npmrc` (containing auth tokens), `~/.aws/credentials`
  - Files explicitly marked or likely to contain production secrets, passwords, or private API keys.
- **Handling Confirmed Secrets**: If granted permission to inspect a sensitive file, never print or leak raw secret values in chat responses, commit messages, or artifacts. Redact or mask them (e.g., `API_KEY=********`).
