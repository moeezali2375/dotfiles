#!/usr/bin/env bash
# Claude Code PreToolUse hook (matcher: Bash): deny git commands that mutate
# history, rewrite refs, or touch remotes (commit, push, pull, fetch, merge,
# rebase, reset, clean, forced checkout, branch/tag delete, stash
# drop/clear, remote add/rm/set-url). Read-only and local staging commands
# pass through. Exit 2 blocks the tool call and feeds stderr back as the
# reason; exit 0 allows it.
set -euo pipefail

decide() {
  local cmd="$1"
  local g=/usr/bin/grep

  $g -Eq '(^|[^A-Za-z0-9_./-])git([^A-Za-z0-9_./-]|$)' <<<"$cmd" || { echo "ALLOW"; return; }

  if $g -Eq 'git.*\b(commit|push|pull|fetch|merge|rebase|reset|clean)\b' <<<"$cmd"; then
    echo "DENY:git commit/push/pull/fetch/merge/rebase/reset/clean is blocked by policy"; return
  fi
  if $g -Eq '\bcheckout\b.*(--force\b|-f\b|--[[:space:]])' <<<"$cmd"; then
    echo "DENY:git checkout --force/-f/-- (discarding changes) is blocked by policy"; return
  fi
  if $g -Eq '\bbranch\b.*(-D\b|--delete\b|-d\b)' <<<"$cmd"; then
    echo "DENY:git branch delete is blocked by policy"; return
  fi
  if $g -Eq '\btag\b.*(-d\b|--delete\b)' <<<"$cmd"; then
    echo "DENY:git tag delete is blocked by policy"; return
  fi
  if $g -Eq '\bstash\b.*\b(drop|clear)\b' <<<"$cmd"; then
    echo "DENY:git stash drop/clear is blocked by policy"; return
  fi
  if $g -Eq '\bremote\b.*\b(add|rm|remove|set-url)\b' <<<"$cmd"; then
    echo "DENY:git remote add/rm/set-url is blocked by policy"; return
  fi

  echo "ALLOW"
}

input="$(cat)"
tool_name="$(/usr/bin/jq -r '.tool_name // empty' <<<"$input" 2>/dev/null || true)"

# Only inspect Bash tool calls; allow everything else through untouched.
if [[ "$tool_name" != "Bash" ]]; then
  exit 0
fi

command_str="$(/usr/bin/jq -r '.tool_input.command // empty' <<<"$input" 2>/dev/null || true)"
result="$(decide "$command_str")"

if [[ "$result" == DENY:* ]]; then
  echo "${result#DENY:} - ask the user to run this git command manually." >&2
  exit 2
fi

exit 0
