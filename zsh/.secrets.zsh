get_secret() {
  local key="$1"
  # NOTE: For mac only
  security find-generic-password -a "$USER" -s "$key" -w 2>/dev/null
}

export OPENAI_API_KEY="$(get_secret openai_api_key)"
export GITHUB_TOKEN="$(get_secret github_token)"
