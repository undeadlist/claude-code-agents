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

# Create directories
echo "Creating directories..."
mkdir -p .claude/agents
mkdir -p .claude/audits
mkdir -p workflows

# Download agent files (24 total)
echo "Downloading agents..."

AGENTS=(
    # Audit agents (11)
    "code-auditor.md"
    "bug-auditor.md"
    "security-auditor.md"
    "doc-auditor.md"
    "infra-auditor.md"
    "ui-auditor.md"
    "db-auditor.md"
    "perf-auditor.md"
    "dep-auditor.md"
    "seo-auditor.md"
    "api-tester.md"
    # Fix/Implement agents (4)
    "fix-planner.md"
    "code-fixer.md"
    "test-runner.md"
    "test-writer.md"
    # Browser QA agents (4)
    "browser-qa-agent.md"
    "fullstack-qa-orchestrator.md"
    "console-monitor.md"
    "visual-diff.md"
    # Deploy agents (2)
    "deploy-checker.md"
    "env-validator.md"
    # Utility agents (2)
    "pr-writer.md"
    "seed-generator.md"
    # Supervisors (1)
    "architect-reviewer.md"
)

for agent in "${AGENTS[@]}"; do
    echo "   -> $agent"
    curl -sL "${REPO_URL}/raw/${BRANCH}/.claude/agents/${agent}" -o ".claude/agents/${agent}"
done

# Download workflow files (6 total)
echo ""
echo "Downloading workflows..."

WORKFLOWS=(
    "pre-commit.md"
    "pre-deploy.md"
    "full-audit.md"
    "new-feature.md"
    "bug-fix.md"
    "release-prep.md"
)

for workflow in "${WORKFLOWS[@]}"; do
    echo "   -> $workflow"
    curl -sL "${REPO_URL}/raw/${BRANCH}/workflows/${workflow}" -o "workflows/${workflow}"
done

# Create .gitignore for audits
if [ ! -f ".claude/.gitignore" ]; then
    echo "audits/" > .claude/.gitignore
fi

echo ""
echo "================================"
echo "Installed ${#AGENTS[@]} agents to .claude/agents/"
echo "Installed ${#WORKFLOWS[@]} workflows to workflows/"
echo ""
echo "Quick start:"
echo "   claude \"Run full-audit workflow on src/\""
echo "   claude \"Run pre-commit workflow\""
echo "   claude \"Run pre-deploy workflow\""
echo ""
echo "Docs: https://github.com/undeadlist/claude-code-agents"
echo "Built by UndeadList: https://undeadlist.com"
