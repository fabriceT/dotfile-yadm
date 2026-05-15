#!/bin/bash

set -euo pipefail

# Default settings
GIT=git
MODEL=granite4:350m

usage() {
        echo "Usage: ${0##*/} [-m <model>] [-g <git_command>]"
        exit 1
}


while getopts "g:m:y" flag; do
        case ${flag} in
        g) GIT="${OPTARG}" ;;
        m) MODEL="${OPTARG}" ;;
        y) GIT=yadm ;;
        *) usage ;;
        esac
done

# Step 1: Get the diff
diff=$(${GIT} --no-pager diff --cached)

if [[ -z "$diff" ]]; then
        echo "[ERROR] No changes found to generate a commit message."
        exit 1
fi

ollama run "${MODEL}" < <(
        cat <<EOT
Your task: Generate a single, concise and punchy git commit message based on the provided "git diff".

Strict Rules:

1. Format: "<type>(<scope>): <subject>"
    - Include "<scope>" only if the change is specific to a module/component (e.g., "api", "infra", "ci"). Omit if the scope is unclear. Don't invent.
    - The "<subject>" must be in the imperative mood (e.g., "Add", "Fix", "Refactor").
    - No period at the end of the subject line.

2. Allowed Types (Conventional Commits Standard):

    - fix: Bug fixes, logic corrections, race conditions.
    - feat: New features, modules, or functionality additions.
    - refactor: Code changes that neither fix a bug nor add a feature (cleanups, optimizations).
    - chore: Maintenance tasks (CI/CD configs, Makefiles, dependency updates, tooling).
    - docs: Documentation changes only.
    - test: Adding or modifying tests.

3. Style Constraints:

    - Maximum length: 72 characters for the subject line.
    - Avoid generic verbs like "Update" or "Change" unless it is a pure refactor. Be specific about *what* changed.
    - Do NOT use "delete" as a type.
        - If removing unused code/files: use "refactor" or "chore".
        - If removing a feature: use "feat" with a negative subject (e.g., "feat: remove legacy auth module").

4. Decision Logic:

    - If multiple change types exist, prioritize the most critical: fix > feat > refactor > chore.
    - Analyze the diff context (e.g., Go structs, Terraform resources, Ansible tasks) to determine the appropriate scope and type.

Output Examples:

    - fix(api): resolve token expiry race condition
    - feat(infra): add VPC module for eu-west-1 region
    - chore(ci): upgrade pre-commit hooks to v3.2.0
    - refactor(go): simplify retry logic in HTTP client

Input (git diff):
${diff}
EOT
)
