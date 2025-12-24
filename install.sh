#!/bin/bash

# claude-code-agents installer
# Usage: curl -s https://undeadlist.com/agents/install.sh | bash

set -e

REPO_URL="https://github.com/undeadlist/claude-code-agents"
BRANCH="main"

echo "claude-code-agents installer"
echo "================================"
echo ""

# Check if we're in a project directory
if [ ! -f "package.json" ] && [ ! -f "Cargo.toml" ] && [ ! -f "go.mod" ] && [ ! -f "requirements.txt" ]; then
    echo "Warning: No project file detected (package.json, Cargo.toml, etc.)"
    echo "   Are you in your project root?"
    read -p "   Continue anyway? [y/N] " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Create .claude/agents directory
echo "Creating .claude/agents/ directory..."
mkdir -p .claude/agents

# Download agent files
echo "Downloading agents..."

AGENTS=(
    "code-auditor.md"
    "bug-auditor.md"
    "security-auditor.md"
    "doc-auditor.md"
    "infra-auditor.md"
    "ui-auditor.md"
    "fix-planner.md"
    "code-fixer.md"
    "test-runner.md"
    "architect-reviewer.md"
)

for agent in "${AGENTS[@]}"; do
    echo "   -> $agent"
    curl -sL "${REPO_URL}/raw/${BRANCH}/.claude/agents/${agent}" -o ".claude/agents/${agent}"
done

echo ""
echo "Installed ${#AGENTS[@]} agents to .claude/agents/"
echo ""
echo "Quick start:"
echo "   claude \"Run full parallel audit on src/\""
echo ""
echo "Docs: https://github.com/undeadlist/claude-code-agents"
echo "Built by UndeadList: https://undeadlist.com"
