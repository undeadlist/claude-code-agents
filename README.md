# Claude Code Agents - Enhanced Edition

[![Claude Code Ready](badges/claude-code-ready.svg)](https://undeadlist.com)

**Full-stack QA workflow with Chrome browser integration.**

![Parallel Audit Demo](./assets/terminal-demo.svg)

The original parallel audit agents + new browser QA capabilities for the complete Replit-style experience: navigate your app, find bugs, fix them, verify.

---

## What's New

### Browser QA Agents

| Agent | What It Does |
|-------|-------------|
| `browser-qa-agent` | Navigates running apps via Chrome, finds console errors, UI bugs |
| `fullstack-qa-orchestrator` | The full loop: find → fix → verify → repeat |

### Enhanced Workflow

```
┌─────────────────────────────────────────────────────┐
│  Code Audit (existing)                              │
│  └─ Parallel agents scan your codebase              │
├─────────────────────────────────────────────────────┤
│  Browser QA (new)                                   │
│  └─ Chrome navigates your running app               │
│  └─ Finds runtime errors, UI bugs, UX issues        │
│  └─ Fixes applied, then verified in browser         │
└─────────────────────────────────────────────────────┘
```

---

## Quick Start

### 1. Install Agents

```bash
# Via npx (recommended)
npx claude-code-agents

# Or via curl
curl -s https://undeadlist.com/agents/install.sh | bash

# Or clone directly
git clone https://github.com/undeadlist/claude-code-agents.git .claude/agents-repo
cp -r .claude/agents-repo/.claude/agents .claude/
```

### 2. Enable Chrome Integration

In Claude Code:
```
/chrome
```

Select "Enabled by default" for persistent access.

### 3. Start Your Dev Server

```bash
npm run dev  # or whatever your project uses
```

### 4. Run Browser QA

```
claude "Use browser-qa-agent to scan http://localhost:3000"
```

---

## Full Workflow Examples

### The Complete Loop (Replit-style)

```
claude "Use fullstack-qa-orchestrator to:
1. Scan http://localhost:3000
2. Test login, dashboard, and checkout flows
3. Fix any issues found
4. Verify fixes in browser
5. Repeat until clean"
```

### Parallel Code Audit + Browser QA

```
claude "Run parallel audit (code-auditor on src/components/,
bug-auditor on src/lib/, security-auditor on src/api/),
then use browser-qa-agent to verify no runtime errors"
```

### Pre-Deploy Checklist

```
claude "Use architect-reviewer to coordinate:
1. Full code audit
2. Browser QA on staging URL
3. Security scan
4. Create deployment readiness report"
```

### Quick Console Check

```
claude "Use browser-qa-agent to navigate to http://localhost:3000,
click through the main nav, and report any console errors"
```

---

## Agent Reference

### Audit Agents (Parallel)
- `code-auditor` - Code quality, DRY, complexity
- `bug-auditor` - Security vulns, auth gaps, runtime risks
- `security-auditor` - Deep OWASP analysis
- `doc-auditor` - Documentation coverage
- `infra-auditor` - Config, env vars, headers
- `ui-auditor` - Accessibility, UX patterns

### Fix Agents
- `fix-planner` - Prioritized remediation from findings
- `code-fixer` - Implements fixes following patterns
- `test-runner` - Runs tests, validates fixes

### Browser Agents
- `browser-qa-agent` - Chrome-based UI testing
- `fullstack-qa-orchestrator` - Coordinates the find-fix-verify loop

### Supervisors
- `architect-reviewer` - Oversees and iterates until production-ready

---

## Project Setup

### Recommended CLAUDE.md

Every project should have a `CLAUDE.md` at the root with:

```yaml
# Required for browser QA
dev_server_cmd: "npm run dev"
dev_url: "http://localhost:3000"
test_flows:
  - "Homepage load"
  - "User login"
  - "Main feature"
```

Use the setup script to auto-generate this:

```bash
curl -s https://undeadlist.com/agents/setup.sh | bash
```

### Directory Structure

```
your-project/
├── CLAUDE.md              # Project config + rules
├── .claude/
│   ├── agents/            # All agent definitions
│   │   ├── browser-qa-agent.md
│   │   ├── fullstack-qa-orchestrator.md
│   │   ├── code-auditor.md
│   │   └── ... (all agents)
│   └── audits/            # Generated reports (gitignored)
│       ├── AUDIT_BROWSER_QA.md
│       ├── AUDIT_CODE.md
│       ├── FIXES.md
│       └── QA_SESSION_LOG.md
└── src/                   # Your code
```

---

## Chrome Integration Details

### Requirements
- Chrome browser (not Brave, Arc, etc.)
- Claude for Chrome extension installed
- Not running in WSL

### How It Works

Claude Code communicates with Chrome via the extension. When you ask for browser testing:

1. Claude opens a new Chrome tab
2. Navigates to your URL
3. Interacts with the page (clicks, types, scrolls)
4. Reads console output and DOM state
5. Reports findings back

### Handling Auth

If your app requires login:

```
claude "Navigate to http://localhost:3000/login,
I'll log in manually, then scan the dashboard"
```

Claude will pause at login pages and wait for you.

### Recording Sessions

```
claude "Record a GIF of the checkout flow at http://localhost:3000"
```

Creates a GIF file documenting the interaction.

---

## Outputs

All reports go to `.claude/audits/`:

| File | Content |
|------|---------|
| `AUDIT_BROWSER_QA.md` | Console errors, UI issues from browser testing |
| `AUDIT_CODE.md` | Code quality findings |
| `AUDIT_SECURITY.md` | Vulnerability scan results |
| `AUDIT_SECURITY_DEEP.md` | OWASP analysis |
| `AUDIT_DOCS.md` | Documentation gaps |
| `AUDIT_INFRA.md` | Config issues |
| `AUDIT_UI_UX.md` | Accessibility/UX findings |
| `FIXES.md` | Prioritized fix plan |
| `TEST_REPORT.md` | Test validation results |
| `QA_SESSION_LOG.md` | Full session transcript |
| `QA_COMPLETE.md` | Final summary when session ends |

These are gitignored by default—working files, not artifacts.

---

## Tips

### Speed vs Thoroughness

**Fast (parallel, no browser):**
```
claude "Run parallel audit on src/"
```

**Thorough (includes browser):**
```
claude "Full QA: parallel audit + browser testing at localhost:3000"
```

### Scope Control

Limit scope to keep things fast:
```
claude "Use browser-qa-agent to test ONLY the login flow"
```

### Handling Flaky Tests

If browser QA keeps failing on timing:
```
claude "Use browser-qa-agent with extra wait time, the app loads slowly"
```

### Multi-Project Setup

Install agents globally for all projects:
```bash
cp -r .claude/agents/ ~/.claude/agents/
```

Then they're available everywhere.

---

## Troubleshooting

### Chrome Not Connecting

```
/chrome status
```

If disconnected:
1. Ensure Chrome is running
2. Check Claude for Chrome extension is enabled
3. Restart Chrome
4. Run `/chrome` again

### Server Not Running

Browser QA will fail if your dev server isn't up:
```bash
# Start server first
npm run dev

# Then run QA
claude "Use browser-qa-agent..."
```

### Wrong Port

Update your CLAUDE.md or specify in prompt:
```
claude "Use browser-qa-agent to scan http://localhost:5173"
```

---

## License

MIT. Use it, fork it, enhance it.

---

Made by [UndeadList](https://undeadlist.com) — the marketplace for indie software.
