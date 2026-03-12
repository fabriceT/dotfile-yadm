#!/bin/bash

GIT=${1:-git}
# Default settings
MODEL=${2:-gemma3n:e4b}
MAX_LINES_PER_FILE=20

PROMPT='
Write a concise, single‑line Git commit message for the supplied diff.

Constraints:
  - Max 40 words (≈ 72 characters) – keep it punchy.
  - Imperative mood (e.g. “Add”, “Fix”, “Remove”).
  - Prefixes (Conventional Commits style):
     + fix: when correcting logic or bugs.
     + feat: when adding new functionality
     + delete: when a large block is removed without replacement.
     + chore: when touching tooling (pre‑commit hooks, Makefile, CI config, etc.).
   - Avoid generic verbs (“Update”, “Change”) unless the change truly is a refactor without functional impact.

Examples:
  - fix: resolve token‑expiry race condition
  - delete: remove unused libfoo
  - chore: upgrade pre‑commit to v3.2.0
'
# Step 1: Get the diff
diff=$(${GIT} diff --cached)

if [[ -z "$diff" ]]; then
  echo "[ERROR] No changes found to generate a commit message."
  exit 1
fi

# Step 2: Truncate each file's diff
trimmed_diff=$(echo "$diff" | awk -v max="$MAX_LINES_PER_FILE" '
  /^diff --git / {
    if (count > 0) print "";
    print;
    count = 0;
    next;
  }
  {
    if (count < max) {
      print;
      if (/^\+|^-|^ /) count++;
    }
  }
')

commit_msg=$(echo "$trimmed_diff" | ollama run --hidethinking "${MODEL}" "${PROMPT}")

echo "$commit_msg"
