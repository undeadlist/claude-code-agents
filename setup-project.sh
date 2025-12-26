#!/bin/bash

# ============================================
# Claude Code Workflow Setup
# One command to set up any project
# ============================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Config
AGENTS_REPO="https://github.com/undeadlist/claude-code-agents.git"
TEMP_DIR="/tmp/claude-agents-$$"

echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════╗"
echo "║  Claude Code Workflow Setup                    ║"
echo "║  UndeadList Edition                            ║"
echo "╚════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check if we're in a project directory
if [ ! -f "package.json" ] && [ ! -f "requirements.txt" ] && [ ! -f "Cargo.toml" ] && [ ! -f "go.mod" ]; then
    echo -e "${YELLOW}Warning: No recognized project file found.${NC}"
    echo "This script works best in a project root directory."
    read -p "Continue anyway? (y/N): " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Create directory structure
echo -e "${GREEN}Creating .claude directory structure...${NC}"
mkdir -p .claude/agents
mkdir -p .claude/audits

# Download agents from repo
echo -e "${GREEN}Downloading agent definitions...${NC}"
if command -v git &> /dev/null; then
    git clone --depth 1 "$AGENTS_REPO" "$TEMP_DIR" 2>/dev/null || {
        echo -e "${YELLOW}Git clone failed, trying curl...${NC}"
        USE_CURL=true
    }
else
    USE_CURL=true
fi

if [ "$USE_CURL" = true ]; then
    # Fallback to downloading individual files
    echo -e "${YELLOW}Downloading agents individually...${NC}"

    AGENTS=(
        # Audit agents (11)
        "code-auditor"
        "bug-auditor"
        "security-auditor"
        "doc-auditor"
        "infra-auditor"
        "ui-auditor"
        "db-auditor"
        "perf-auditor"
        "dep-auditor"
        "seo-auditor"
        "api-tester"
        # Fix/Implement agents (4)
        "fix-planner"
        "code-fixer"
        "test-runner"
        "test-writer"
        # Browser QA agents (4)
        "browser-qa-agent"
        "fullstack-qa-orchestrator"
        "console-monitor"
        "visual-diff"
        # Deploy agents (2)
        "deploy-checker"
        "env-validator"
        # Utility agents (2)
        "pr-writer"
        "seed-generator"
        # Supervisors (1)
        "architect-reviewer"
    )

    BASE_URL="https://raw.githubusercontent.com/undeadlist/claude-code-agents/main/.claude/agents"

    for agent in "${AGENTS[@]}"; do
        curl -sL "$BASE_URL/$agent.md" -o ".claude/agents/$agent.md" 2>/dev/null || \
            echo -e "${YELLOW}Could not download $agent.md${NC}"
    done
else
    # Copy from cloned repo
    cp "$TEMP_DIR/.claude/agents/"*.md .claude/agents/ 2>/dev/null || true
    rm -rf "$TEMP_DIR"
fi

# Create .gitignore for audits
echo -e "${GREEN}Setting up .gitignore for audits...${NC}"
if [ ! -f ".claude/.gitignore" ]; then
    cat > .claude/.gitignore << 'EOF'
# Claude audit outputs - working files, not artifacts
audits/
*.log
EOF
fi

# Check for existing CLAUDE.md
if [ -f "CLAUDE.md" ]; then
    echo -e "${YELLOW}CLAUDE.md already exists. Skipping template creation.${NC}"
    echo "Review your existing CLAUDE.md to ensure it has browser QA config."
else
    # Detect project type and create customized CLAUDE.md
    echo -e "${GREEN}Creating CLAUDE.md...${NC}"

    # Detect tech stack
    STACK=""
    DEV_CMD=""
    DEV_URL="http://localhost:3000"

    if [ -f "package.json" ]; then
        STACK="Node.js/JavaScript"
        if grep -q "\"next\"" package.json 2>/dev/null; then
            STACK="Next.js"
            DEV_CMD="npm run dev"
        elif grep -q "\"react\"" package.json 2>/dev/null; then
            STACK="React"
            DEV_CMD="npm run dev"
        elif grep -q "\"vue\"" package.json 2>/dev/null; then
            STACK="Vue.js"
            DEV_CMD="npm run dev"
        else
            DEV_CMD="npm start"
        fi

        if grep -q "\"typescript\"" package.json 2>/dev/null; then
            STACK="$STACK + TypeScript"
        fi
    elif [ -f "requirements.txt" ] || [ -f "pyproject.toml" ]; then
        STACK="Python"
        if [ -f "manage.py" ]; then
            STACK="Django"
            DEV_CMD="python manage.py runserver"
            DEV_URL="http://localhost:8000"
        elif grep -q "fastapi" requirements.txt 2>/dev/null; then
            STACK="FastAPI"
            DEV_CMD="uvicorn main:app --reload"
            DEV_URL="http://localhost:8000"
        elif grep -q "flask" requirements.txt 2>/dev/null; then
            STACK="Flask"
            DEV_CMD="flask run"
            DEV_URL="http://localhost:5000"
        fi
    elif [ -f "Cargo.toml" ]; then
        STACK="Rust"
        DEV_CMD="cargo run"
    elif [ -f "go.mod" ]; then
        STACK="Go"
        DEV_CMD="go run ."
    fi

    # Get project name
    PROJECT_NAME=$(basename "$(pwd)")

    # Create CLAUDE.md
    cat > CLAUDE.md << EOF
# Project Configuration for Claude Code

## PROJECT CONFIG

\`\`\`yaml
project_name: "$PROJECT_NAME"
dev_server_cmd: "$DEV_CMD"
dev_url: "$DEV_URL"
tech_stack:
  - $STACK
test_flows:
  - "Homepage load"
  - "Main user flow"
\`\`\`

## CORE RULES (NON-NEGOTIABLE)

### 1. No Unauthorized Changes
- **ASK BEFORE** modifying any file not directly related to the current task
- **NEVER** refactor "while you're in there"
- **NEVER** update dependencies unless explicitly requested

### 2. Follow Existing Patterns
- Match the codebase's existing style exactly
- If unsure about a pattern, grep for examples first

### 3. Verify Before Claiming Done
- Run the dev server after changes
- Check for TypeScript/lint errors
- Test the actual UI if it's a UI change

## CHROME BROWSER QA

\`\`\`bash
# Enable Chrome integration:
/chrome

# Run QA:
"Use fullstack-qa-orchestrator to test $DEV_URL"
\`\`\`

## AGENT USAGE

### Quick Audit
\`\`\`
"Run parallel audit on src/"
\`\`\`

### Browser QA Loop
\`\`\`
"Use fullstack-qa-orchestrator to find and fix UI issues"
\`\`\`

### Pre-PR Review
\`\`\`
"Use architect-reviewer to verify changes are production-ready"
\`\`\`
EOF

    echo -e "${GREEN}Created CLAUDE.md with detected stack: $STACK${NC}"
fi

# Verify Chrome extension reminder
echo ""
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
echo -e "${GREEN}Setup complete!${NC}"
echo ""
echo "Agents installed:"
ls -1 .claude/agents/*.md 2>/dev/null | xargs -I {} basename {} .md | sed 's/^/  - /'
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "  1. Review/customize CLAUDE.md for your project"
echo "  2. In Claude Code, run: /chrome"
echo "  3. Start your dev server: $DEV_CMD"
echo "  4. Test with: \"Use browser-qa-agent to scan $DEV_URL\""
echo ""
echo -e "${BLUE}════════════════════════════════════════════════${NC}"
